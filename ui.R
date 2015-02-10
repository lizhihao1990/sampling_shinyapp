# Load used packages
library(package = ggvis)

# Elements common to the UI and the server
source("./scripts/common_elements.R")

# Define UI elements
shinyUI(
  fluidPage(
    headerPanel(title = "Sampling strategy visualization"),
    tabsetPanel(
    tabPanel("Documentation", includeMarkdown("./content/documentation.md")),
    tabPanel("Application",
             fluidRow(
                 wellPanel(
                   fluidRow(
                     column(3, selectInput("xvar", "x-axis variable", axis_vars$label,
                                           selected = "Daily protein intake (g)"),
                            uiOutput("plot_ui")),
                     column(3, selectInput("yvar", "y-axis variable", axis_vars$label,
                                           selected = "Daily carb intake (g)"),
                            checkboxInput("emph", "Emphasize immigrant status", value=FALSE)),
                     column(3, selectInput("colorvar", "Color based on", aes_vars$label,
                                           selected = "Gender"),
                            checkboxInput("facet", "Use facet instead of color", value=FALSE)),
                     column(3, selectInput("samp_strat", "Sampling strategy", samp_strats$label,
                                           selected = "Simple random sampling"),
                            checkboxInput("show_sample", "Enable sampling", value=FALSE))
                     ))),
               mainPanel(
                 ggvisOutput(plot_id = "sample_plot")
               )
             )
    )
    )
  )
