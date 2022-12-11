

library(rsconnect)
library(maps)
library(shiny)
library(tidyverse)
library(ggplot2)
library(shinythemes)
library(plotly)

data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

  da <- data %>% 
  select(country, year, co2, gdp, population) %>% 
  na.omit()

#What is the average value of co2 across all the counties in 2018?

Avgc02 <- da %>% 
  select(country, year, co2) %>% 
  filter(year ==  2018) %>%  
  group_by(country) %>% 
  summarise(co2 = mean(co2, na.rm = FALSE))
  

#The highest co2 the US produces each year

highyear <- da %>% 
  filter(country == "United States") %>% 
  filter(co2 == max(co2, na.rm = FALSE)) %>% 
  summarise(year, co2) %>% 
  na.omit()


#How much has US's co2 change over the last 10 years?

shinjithebest <- da %>% 
  filter(country == "United States") %>% 
  filter(year == max(year)) %>% 
  summarise(co2)

shinjithebest2 <- da %>% 
  filter(country == "United States") %>% 
  filter(year == max(year) - 10) %>% 
  summarise(co2)

shinjibestta <- paste(abs(shinjithebest - shinjithebest2), "million tonnes")

hahaha <- da %>% 
  select(country, co2, population)
  

nwda <- da %>% 
  select(country, year, co2)
  



  
  
#SERVER

server <- function(input, output){


    
   wu <- ggplot(data = nwda) + 
      geom_col(mapping = aes(x = country,
                             y = co2),
               color = "Green") + 
      labs(x = "Countries",
           y = "Carbon Dioxide",
           title = "The Carbon Dioxide number emission rate by each country",
           caption = "This graph show the CO2 number in diffferent countries, group by years."
           
      )


  
  seconddata <- reactive({
    sec <- hahaha %>% 
      filter(country %in% input$haha)
 thesec <- ggplot(data = hahaha) +
    geom_point(mapping = aes(x = population, 
                            y = co2)) +
                  labs(x = "Population of each country" , 
                       y = "Cardon Dioxide" ,
                       title = "Carbon Dioxide rate according to population in each country",
                       caption = "Black to white injailed ratio over the years from 1991 to 2018"
                  )
  return(thesec)
  })

  
  output$avg <- renderTable({
    avg <- Avgc02
  })
  
  output$hy <- renderTable({
    hy <- highyear
  })
  
  output$diff <- renderText({
    diff <- shinjibestta
  })
  
  output$ooo <- renderPlot({
    wu
  })
  
  output$second <- renderPlot({
    seconddata
  })
}

