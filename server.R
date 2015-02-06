# Used packages
library(package = foreign)  # Leer archivos de datos xport de SAS
library(package = ggplot2)  # Gráficas
library(package = tidyr)    # Re organizar datos 
library(package = magrittr) # Piping
library(package = dplyr)    # Manipulación de data.frames

# Elements common to the UI and the server
source("common_elements.R")

# Load data
demographics <- read.xport(file = 'data/DEMO_G.XPT')
nutrients_d1 <- read.xport(file = 'data/DR1TOT_G.XPT')
nutrients_d2 <- read.xport(file = 'data/DR2TOT_G.XPT')

# Load metadata
meta_demographics <- lookup.xport(file = 'data/DEMO_G.XPT')
meta_nutrients_d1 <- lookup.xport(file = 'data/DR1TOT_G.XPT')
meta_nutrients_d2 <- lookup.xport(file = 'data/DR2TOT_G.XPT')

# Pre-process data
do.call(cbind, meta_demographics$DEMO_G[c('name', 'label')]) %>% as.data.frame
do.call(cbind, meta_nutrients_d1$DR1TOT_G[c('name', 'label')]) %>% as.data.frame
do.call(cbind, meta_nutrients_d2$DR2TOT_G[c('name', 'label')]) %>% as.data.frame

# Select variables and filter data
demographics <- demographics %>%
  select(id = SEQN, gender = RIAGENDR, age = RIDAGEYR,
         status = DMDCITZN, poverty_ratio = INDFMPIR) %>%
  na.omit %>%
  filter(status < 3, poverty_ratio < 5, age < 80) %>%
  mutate(gender = ifelse(gender==1, "male", "female"),
         status = ifelse(status==1, "citizen", "immigrant")) %>%
  tbl_df

nutrients_d1 <- nutrients_d1 %>%
  select(id = SEQN, energy = DR1TKCAL,
         protein = DR1TPROT, carbs = DR1TCARB, fat = DR1TTFAT) %>%
  na.omit %>%
  filter(energy > quantile(energy, 0.1), energy < quantile(energy, 0.9),
         protein > quantile(protein, 0.1), protein < quantile(protein, 0.9),
         carbs > quantile(carbs, 0.1), carbs < quantile(carbs, 0.9),
         fat > quantile(fat, 0.1), fat < quantile(fat, 0.9)) %>%
  tbl_df

nutrients_d2 <- nutrients_d2 %>%
  select(id = SEQN, energy = DR2TKCAL,
         protein = DR2TPROT, carbs = DR2TCARB, fat = DR2TTFAT) %>%
  na.omit %>%
  filter(energy > quantile(energy, 0.1), energy < quantile(energy, 0.9),
         protein > quantile(protein, 0.1), protein < quantile(protein, 0.9),
         carbs > quantile(carbs, 0.1), carbs < quantile(carbs, 0.9),
         fat > quantile(fat, 0.1), fat < quantile(fat, 0.9)) %>%
  tbl_df



# Function to calculate sample sizes
samp_si <- function(sizes, p=0.5, alpha=0.05, finite=FALSE, deff=1, response=1){
  z <- qnorm(p=1-alpha/2)  # Z score for the 1-alpha percentile point
  population <- sum(sizes)
  n <- (z^2) * (p) * (1-p) / (alpha^2)
  if(finite[1]) n <- ceiling(n / (1 + ((n-1) / population)))
  n <- n * deff / response
  n <- ceiling(sizes * (n / population))
  ifelse(n>sizes, sizes, n)
}


# Grupos de pobreza
pov_groups <- c("extremely poor", "poor", "middle-low", "middle-high", "high")


sample_group <- function(n, N, clusters=0){
  srs_size <- samp_si(N)
  if(clusters>0){
    (1:n) %in% sample(1:n, size=round(srs_size / clusters), replace = FALSE)
  } else {
    (1:n) %in% sample(1:n, size=round(srs_size*(n/N)), replace = FALSE)
  }
}



datos <- demographics[-1,] %>%
  inner_join(nutrients_d1) %>%
  mutate(age_group = cut(age, seq(0, 80, by=10),
                         right = FALSE, ordered_result=TRUE)) %>%
  tbl_df

srs_size <- samp_si(nrow(datos))
prob_srs <- srs_size/nrow(datos)


set.seed(2014-10-06)

datos <- datos %>%
  mutate(pov_group = factor(cut(poverty_ratio, breaks = 0:5, right = FALSE,
                                labels = pov_groups),
                            labels = pov_groups, ordered = TRUE),
         location = cut(energy, right=TRUE,
                        breaks = c(0, quantile(energy, probs = (1:8)/9),
                                   max(energy)),
                        labels=LETTERS[1:9]),
         srs = sample_group(n(), nrow(datos))) %>%
  group_by(location) %>%
  mutate(strat = sample_group(n(), nrow(datos))) %>%
  ungroup 


# Elegir algunos conglomerados
n <- 4
clusters <-  sample(x = names(table(datos$age_group)), size = n)

# Muestrear en los conglomerados elegidos
datos <- filter(datos, age_group %in% clusters) %>%
  group_by(age_group) %>%
  mutate(clust = sample_group(n(), nrow(datos), clusters=length(clusters))) %>%
  ungroup %>%
  rbind(filter(mutate(datos, clust=FALSE), !age_group %in% clusters))


# Muestrear estratificado disproporcionado (pocos inmigrantes)
datos <- filter(datos, status == "immigrant") %>%
  group_by(status) %>%
  mutate(strat_dis = sample_group(n(), nrow(datos), 2)) %>%
  ungroup %>%
  rbind(mutate(filter(datos, status == "citizen"),
               strat_dis = sample_group(n(), nrow(datos), 2)))


shinyServer(function(input, output) {
  output$plot <- renderPlot({
    xvar <- axis_vars$name[axis_vars$label==input$xvar]
    yvar <- axis_vars$name[axis_vars$label==input$yvar]
    colorvar <- aes_vars$name[aes_vars$label==input$colorvar]
    samp_strat <- samp_strats$name[samp_strats$label==input$samp_strat]
    
    poverty_range <- seq(input$pov - input$buf, input$pov + input$buf, by=0.01)
    poverty_range <- round(poverty_range, 2)
    poverty_range <- poverty_range[poverty_range>=0 & poverty_range<=5]
    
    use_data <- datos %>%
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
      ylim(range(datos[, yvar])) +
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
        xlim(range(datos[, xvar]))
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
