

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



nwda <- da %>% 
  filter(year %in% (2000:2020))
  



  
  
#SERVER

server <- function(input, output){


chart <- reactive({
  chartdata <- nwda %>% 
    filter(country %in% input$haha) 
  
   wu <- ggplot(data = chartdata) + 
      geom_line(mapping = aes_string(
                             x = input$mu,
                             y = input$gdporpopu),
               color = "pink") + 
      labs(x = "Selected varuables: gdp or population",
           y = "Carbon Dioxide",
           title = "The Carbon Dioxide number emission rate by each country",
           caption = "This graph show the CO2 number in diffferent countries, showing the growth of CO2 in relationship with gdp or population. The data continas information from 2000 to 2020"
           
      )
   return(wu)
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
    chart()
  })

  }

