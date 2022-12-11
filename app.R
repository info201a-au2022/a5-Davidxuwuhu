

library(rsconnect)
library(maps)
library(shiny)
library(shinythemes)
library(tidyverse)

source("ui.R")
source("server.R")



# Run the application 
shinyApp(ui = ui, server = server)
