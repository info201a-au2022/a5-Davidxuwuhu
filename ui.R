

library(shiny)
library(shinythemes)

data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

# Define UI for application that draws a histogram
ui <- fluidPage(theme = shinytheme("simplex"),
  navbarPage("Co2 emission",
  tabPanel("Intro",
    sidebarLayout(
        sidebarPanel(
          h1("Introduction"),
          p("In this report I will be focusing on each countries ", em("CO2"), " growth throughout the years and how does the it affect other vaiables such as the gdp. I will also examine the relationship between", em("population")," and ", em("CO2")," production rate." , style = "font-family: 'times'; font-size:12px;"),
                    ),
        mainPanel(
          h3("The highest co2 the US produces each year"),
          tableOutput("hy"), p("CO2 is record in Million tonnes"),
          h3("The CO2 change over the last 10 years in the US"),
          textOutput("diff"),
          h3("The average value of co2 across all the counties in 2018"),
          tableOutput("avg")
                  )
                )
          ),
    tabPanel("Plots",
              sidebarLayout(
                sidebarPanel(
                  radioButtons(inputId = "gdporpopu",
                              label = "Choose your variable:",
                              choices = c("GDP" = "gdp" , "Carbon Dioxide" = "co2"),
                              selected = "gdp"),
                  
                  selectInput(inputId = "haha",
                              label = "Choose a country:",
                              choices = c("United States","China","Japan"),
                              selected = "United State"),
                  
                  radioButtons(inputId = "mu",
                               label = "Choose your variable:",
                               choices = c("Population" = "population" , "Year" = "year"),
                               selected = "year"),
                  
                ),
          mainPanel(
            plotlyOutput(outputId = "ooo"),
            p("This chart present the average number of co2 release around the globe. By selecting the variable in the input menu, one could see the data of co2 rate in each country according to the gdp and population. Meanwhile charts could show the audience how the number has increased significnatly throughout the years. "),
       
            )
            )
          )
        )
  )
