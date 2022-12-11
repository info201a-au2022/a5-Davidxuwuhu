

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
  
  output$selectyear <- renderUI({
    selectInput(inputId = "year",
                label = "Date",
                min = 1750,
                max = 2021,
                value = 1880)
  })
  
  output$wohaha <- renderUI({
    selectInput(inputId = "haha",
                label = "Choose a country",
                choices = c("United State","China","Japan"),
                selected = "United State")
  })
  
  
  bargraph <- reactive({
    yearchart <- nwda %>% 
      filter(year %in% input$year) 
    
    ggplot(data = yearchart) + 
      geom_bar(mapping = aes(x = country,
                             y = co2),
               color = "Green",
               alpha = 0.3) + 
      labs(x = "Countries",
           y = "Carbon Dioxide",
           title = "The Carbon Dioxide number emission rate by each country",
           caption = "This graph show the CO2 number in diffferent countries, group by years."
           
      )
  })
  
  seconddata <- reactive({
    sec <- hahaha %>% 
      filter(country %in% input$country)
    second <- ggplot() +
      geom_smooth(data = sec, mapping = aes(x = population, 
                                               y = co2),
                  labs(title = "Carbon Dioxide rate according to population in each country" ,
                       x = "Population of each country" , 
                       y = "Cardon Dioxide" ,
                       caption = "Black to white injailed ratio over the years from 1991 to 2018"
                  )
      )
    
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
  
  output$ooo <- renderPlotly({
    (bargraph)
  })
  
  output$second <- renderPlotly({
    (seconddata)
  })
}

