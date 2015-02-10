# Used packages
library(package = ggvis)  # Graphics
library(package = RColorBrewer) # Colors
library(package = markdown) # Process md files
library(package = tidyr)    # Re structure data
library(package = magrittr) # Piping
library(package = dplyr)    # data.frames manipulation

# Elements common to the UI and the server
source("./scripts/common_elements.R")

# Get data
source("./scripts/get_data.R")

shinyServer(function(input, output, session) {
  reactive({
    xvar <- axis_vars$name[axis_vars$label==input$xvar]
    yvar <- axis_vars$name[axis_vars$label==input$yvar]
    colorvar <- aes_vars$name[aes_vars$label==input$colorvar]
    samp_strat <- samp_strats$name[samp_strats$label==input$samp_strat]
    
    xvar_name <- input$xvar
    yvar_name <- input$yvar
    colorvar_name <- input$colorvar
    facet <- input$facet
    show_sample <- input$show_sample
    emph <- input$emph
  })
  
  # use_data <- 
    reactive({
      use_data <-nhanes_data %>%
    mutate(size = as.numeric(status == "immigrant")) %>%
    select_(.dots = list(x = xvar, y = yvar, "size",
                         color = colorvar, samp_strat = samp_strat)) %>%
    mutate(x = jitter(x, 1), y = jitter(y, 1))
    use_data
    })
  
  set.seed(2014-10-05)
  
    if(!emph) use_data$size <- 1
    
    inter_plot <- 
      ggvis(data=use_data, x = ~x, y = ~y) %>%
      layer_points(fill = ~color, size = ~factor(size)) %>%
      add_axis("x", title = xvar_name) %>%
      add_axis("y", title = yvar_name) %>%
      add_legend(scales = "fill", title = colorvar_name) %>% 
      hide_legend(scales = "size") %>%
      scale_nominal(property = "size", range = c(5, 20))
  
    if(facet){
      inter_plot <- inter_plot %>% 
        scale_nominal(property = "fill",
                      range = c("black", "black")) %>%
        group_by(color) %>%
        subvis()
    } else {
      inter_plot <- inter_plot %>% 
        scale_nominal(property = "fill",
                      range = brewer.pal(n = max(3, length(table(use_data$color))),
                                         name = "Set1"))
    }
    
#     if(show_sample){
#       inter_plot <- inter_plot %>%
#         filter(samp_strat) %>%
#         layer_points(stroke = "sampled", fillOpacity = 0) %>% 
#         scale_nominal(property = "stroke", range = c("purple", "red")) %>%
#         hide_legend("stroke")
#     }
    
    bind_shiny(vis = inter_plot,
               plot_id = "sample_plot",
               controls_id = "plot_ui")
  # })
})
