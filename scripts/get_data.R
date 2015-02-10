# Used packages
library(package = foreign)  # Read SAS xport data
library(package = dplyr)    # data.frames manipulation


# Load RDS if available
if(file.exists("./data/nhanes_data.Rds")){
  nhanes_data <- readRDS(file = "./data/nhanes_data.Rds")
} else {
  # Download the raw data if unavailable
  if(!all(file.exists(c("./data/DEMO_G.XPT",
                            "./data/DR1TOT_G.XPT",
                            "./data/DR2TOT_G.XPT")))){
    
    download.file(url = "http://wwwn.cdc.gov/nchs/nhanes/2011-2012/DEMO_G.XPT",
                  mode = "wb",
                  destfile = "./data/DEMO_G.XPT")
    download.file(url = "http://wwwn.cdc.gov/nchs/nhanes/2011-2012/DR1TOT_G.XPT",
                  mode = "wb",
                  destfile = "./data/DR1TOT_G.XPT")
    download.file(url = "http://wwwn.cdc.gov/nchs/nhanes/2011-2012/DR2TOT_G.XPT",
                  mode = "wb",
                  destfile = "./data/DR2TOT_G.XPT")
  }
  
  # Load data
  demographics <- read.xport(file = "./data/DEMO_G.XPT")
  nutrients_d1 <- read.xport(file = "./data/DR1TOT_G.XPT")
  nutrients_d2 <- read.xport(file = "./data/DR2TOT_G.XPT")
  
  # Load metadata
  meta_demographics <- lookup.xport(file = "./data/DEMO_G.XPT")
  meta_nutrients_d1 <- lookup.xport(file = "./data/DR1TOT_G.XPT")
  meta_nutrients_d2 <- lookup.xport(file = "./data/DR2TOT_G.XPT")
  
  # Process the raw data
  
  do.call(cbind, meta_demographics$DEMO_G[c("name", "label")]) %>% as.data.frame
  do.call(cbind, meta_nutrients_d1$DR1TOT_G[c("name", "label")]) %>% as.data.frame
  do.call(cbind, meta_nutrients_d2$DR2TOT_G[c("name", "label")]) %>% as.data.frame
  
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
  
  
  # Poverty groups
  pov_groups <- c("extremely poor", "poor", "middle-low", "middle-high", "high")
  
  
  sample_group <- function(n, N, clusters=0){
    srs_size <- samp_si(N)
    if(clusters>0){
      (1:n) %in% sample(1:n, size=round(srs_size / clusters), replace = FALSE)
    } else {
      (1:n) %in% sample(1:n, size=round(srs_size*(n/N)), replace = FALSE)
    }
  }
  
  
  
  nhanes_data <- demographics[-1,] %>%
    inner_join(nutrients_d1) %>%
    mutate(age_group = cut(age, seq(0, 80, by=10),
                           right = FALSE, ordered_result=TRUE)) %>%
    tbl_df
  
  srs_size <- samp_si(nrow(nhanes_data))
  prob_srs <- srs_size/nrow(nhanes_data)
  
  
  set.seed(2014-10-06)
  
  nhanes_data <- nhanes_data %>%
    mutate(pov_group = factor(cut(poverty_ratio, breaks = 0:5, right = FALSE,
                                  labels = pov_groups),
                              labels = pov_groups, ordered = TRUE),
           location = cut(energy, right=TRUE,
                          breaks = c(0, quantile(energy, probs = (1:8)/9),
                                     max(energy)),
                          labels=LETTERS[1:9]),
           srs = sample_group(n(), nrow(nhanes_data))) %>%
    group_by(location) %>%
    mutate(strat = sample_group(n(), nrow(nhanes_data))) %>%
    ungroup 
  
  
  # Choose some conglomerates
  n <- 4
  clusters <-  sample(x = names(table(nhanes_data$age_group)), size = n)
  
  # Sample selected conglomerates
  nhanes_data <- filter(nhanes_data, age_group %in% clusters) %>%
    group_by(age_group) %>%
    mutate(clust = sample_group(n(), nrow(nhanes_data), clusters=length(clusters))) %>%
    ungroup %>%
    rbind(filter(mutate(nhanes_data, clust=FALSE), !age_group %in% clusters))
  
  
  # Disproportionate stratified sampling (few immigrants)
  nhanes_data <- filter(nhanes_data, status == "immigrant") %>%
    group_by(status) %>%
    mutate(strat_dis = sample_group(n(), nrow(nhanes_data), 2)) %>%
    ungroup %>%
    rbind(mutate(filter(nhanes_data, status == "citizen"),
                 strat_dis = sample_group(n(), nrow(nhanes_data), 2)))
  
  # Cleanup the workspace
  rm(list = setdiff(ls(), "nhanes_data"))
  
  # And save the RDS for app use
  saveRDS(object = nhanes_data, file = "./data/nhanes_data.Rds")
}
