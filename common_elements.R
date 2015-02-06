# Elements common to the UI and the server
axis_vars <- data.frame(stringsAsFactors = FALSE,
                        names = c("age", "energy", "protein", "carbs", "fat"),
                        labels = c("Age", "Daily energy intake (kcal)",
                                   "Daily protein intake (g)",
                                   "Daily carb intake (g)",
                                   "Daily fat intake (g)"))
aes_vars <- data.frame(stringsAsFactors = FALSE,
                       names = c("gender", "status", "location",
                                 "pov_group", "age_group"),
                       labels = c("Gender", "Migratory status",
                                  "Location (fictitious)", "Economic status",
                                  "Age group"))

samp_strats <- data.frame(stringsAsFactors = FALSE,
                          names = c("srs", "strat", "clust", "strat_dis"),
                          labels = c("Simple random sampling",
                                     "Stratified sampling",
                                     "Cluster sampling",
                                     "Disproportionate stratified sampling\n(favors immigrants)"))
