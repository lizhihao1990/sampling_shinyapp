# Used packages
library(package = ggplot2)  # Graphics
library(package = tidyr)    # Re structure data
library(package = magrittr) # Piping
library(package = dplyr)    # data.frames manipulation

# Elements common to the UI and the server
source("./scripts/common_elements.R")

# Get data
readRDS(file = "./data/data.Rds")

shinyServer(function(input, output) {
  output$plot <- renderPlot({
    xvar <- axis_vars$name[axis_vars$label==input$xvar]
    yvar <- axis_vars$name[axis_vars$label==input$yvar]
    colorvar <- aes_vars$name[aes_vars$label==input$colorvar]
    samp_strat <- samp_strats$name[samp_strats$label==input$samp_strat]
    
    poverty_range <- seq(input$pov - input$buf, input$pov + input$buf, by=0.01)
    poverty_range <- round(poverty_range, 2)
    poverty_range <- poverty_range[poverty_range>=0 & poverty_range<=5]
    
    use_data <- data %>%
      filter(poverty_ratio %in% poverty_range) %>%
      mutate(pov = input$pov,
             alpha = abs(pov - poverty_ratio),
             alpha = (1 - (alpha / max(alpha)))^2,
             size = as.logical(status == "immigrant"))
    
    if(colorvar=="pov_group" & input$facet) use_data$alpha <- 10
    
    if(!input$emph) use_data$size <- TRUE
    
    set.seed(2014-10-05)
    inter_plot <- 
      ggplot(data=use_data,
             aes_string(x = xvar, y=yvar)) +
      guides(alpha="none", size="none") +
      labs(x = input$xvar, y = input$yvar,
           fill = input$colorvar) +
      scale_fill_brewer(palette = "Set1") +
      scale_size_manual(values=c(2,4)) +
      ylim(range(data[, yvar])) +
      theme_light() +
      theme(legend.position = "bottom",
            legend.background = element_rect(fill = "gray95"))
    
    if(input$facet){
      inter_plot <- inter_plot +
        geom_jitter(shape=21, color=NA, fill = "black",
                    aes_string(alpha="alpha", size = "size")) +
        facet_grid(facets = paste(". ~", colorvar),
                   scales = "free_x", space = "free_x")
    } else {
      inter_plot <- inter_plot +
        geom_jitter(shape=21, color=NA,
                    aes_string(alpha="alpha", size = "size", fill=colorvar)) +
        xlim(range(data[, xvar]))
    }
    
    if(input$sample){
      inter_plot <- inter_plot +
        geom_point(shape=21, size=4, fill=NA, aes_string(color = samp_strat)) +
        scale_color_manual(values = c(NA, "red")) +
        guides(color="none")
    }
    inter_plot
  })
})
