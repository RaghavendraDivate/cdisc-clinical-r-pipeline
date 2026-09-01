# ==============================================================================
# Script 05: Efficacy Line Chart (Figure A)
# Purpose: Plot Mean Change from Baseline in ADAS-Cog Total Score Over Time
# ==============================================================================
library(ggplot2)
library(dplyr)

# 1. Summarize data to get Mean and Standard Error (SE) per visit
plot_data <- adadas %>%
  filter(
    ITTFL == "Y", 
    PARAMCD == "ACTOT", 
    ANL01FL == "Y",
    !is.na(AVISITN) # Ensure visits are ordered correctly
  ) %>%
  group_by(TRTP, AVISITN, AVISIT) %>%
  summarise(
    Mean_CHG = mean(CHG, na.rm = TRUE),
    SD_CHG = sd(CHG, na.rm = TRUE),
    N = n(),
    SE_CHG = SD_CHG / sqrt(N),
    .groups = "drop"
  ) %>%
  # Filter to the key visits shown in the chart
  filter(AVISIT %in% c("Baseline", "Week 8", "Week 16", "Week 24"))

# 2. Build the ggplot
ggplot(plot_data, aes(x = AVISIT, y = Mean_CHG, group = TRTP, color = TRTP)) +
  geom_line(aes(linetype = TRTP), linewidth = 1) +
  geom_point(size = 2) +
  geom_errorbar(aes(ymin = Mean_CHG - SE_CHG, ymax = Mean_CHG + SE_CHG), width = 0.2) +
  scale_color_manual(values = c("Placebo" = "#4A86E8", 
                                "Xanomeline Low Dose" = "#38761D", 
                                "Xanomeline High Dose" = "#CC0000")) +
  scale_linetype_manual(values = c("Placebo" = "solid", 
                                   "Xanomeline Low Dose" = "dashed", 
                                   "Xanomeline High Dose" = "dotted")) +
  labs(
    title = "Figure 1: Mean Change from Baseline in ADAS-Cog Total Score Over Time",
    subtitle = "(ITT Population, LOCF)",
    x = "Study Visit",
    y = "CHG in ADAS-Cog (CHG)",
    color = "Efficacy",
    linetype = "Efficacy"
  ) +
  theme_minimal() +
  theme(
    legend.position = "right",
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold", size = 12)
  )
