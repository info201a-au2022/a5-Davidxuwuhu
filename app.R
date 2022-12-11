


library(rsconnect)
library(maps)
library(shiny)
library(tidyverse)
library(ggplot2)
library(shinythemes)
library(plotly)



source("ui.R")
source("server.R")



# Run the application 
shinyApp(ui = ui, server = server)
