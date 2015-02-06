# Elements common to the UI and the server
source("common_elements.R")

# Define UI elements
shinyUI(
  fluidPage(
    title = "Sampling Visualisation",
    fluidRow(
      wellPanel(
        fluidRow(
          column(3, sliderInput("pov", "Poverty index", 0, 5, value = 2.5, step=0.01),
                 sliderInput("buf", "Poverty buffer size", 0.1, 5, value=5, step=0.1)),
          column(3, selectInput("xvar", "x-axis variable", axis_vars$label,
                                selected = "Daily protein intake (g)"),
                 checkboxInput("sample", "Enable sampling", value=FALSE)),
          column(3, selectInput("yvar", "y-axis variable", axis_vars$label,
                                selected = "Daily carb intake (g)"),
                 selectInput("samp_strat", "Sampling strategy", samp_strats$label,
                             selected = "Simple random sampling")),
          column(3, selectInput("colorvar", "Color based on", aes_vars$label,
                                selected = "Gender"),
                 checkboxInput("facet", "Use facet instead of color", value=FALSE),
                 checkboxInput("emph", "Emphasize immigrant status", value=FALSE)
          )))),
    fluidRow(
      plotOutput("plot")
    )
))
