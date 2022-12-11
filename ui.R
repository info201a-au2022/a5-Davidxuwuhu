

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
          p("In this report I will be focusing on each countries ", em("CO2"), " growth throughout the years and how does the it affect other vaiables such as the gdp. I will also examine the relationship between", em("population")," and ", em("CO2")," production rate.")
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
                    uiOutput("selectyear"),
                    uiOutput("wohaha"),
                ),
          mainPanel(
            plotlyOutput("ooo"),
            p("This chart present the average number of co2 release around the globe. By selecting the years in the input menu, one could see the data of co2 rate in each country. Meanwhile charts could show the audience how the number has increased significnatly throughout the years. "),
            plotlyOutput("second"),
            p("Similar to the previous graph, the line chart shows the CO2 rate according to the population in each country.")
            )
            )
          )
        )
  )
