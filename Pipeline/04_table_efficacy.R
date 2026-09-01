# ==============================================================================
# Script 04: Efficacy Table (Table 3 - ADAS-Cog Total Score at Week 24)
# Purpose: Calculate baseline, Week 24, and change from baseline (CHG) stats
# ==============================================================================

library(dplyr)
library(tidyr)

# Step 1: Ensure adsl and adadas datasets are available
if (!exists("adsl"))   adsl   <- haven::read_xpt("data/raw/adsl.xpt")
if (!exists("adadas")) adadas <- haven::read_xpt("data/raw/adadas.xpt")

# Step 2: Filter for primary population (ITTFL == "Y") and primary parameter (ACTOT)
efficacy_data <- adadas %>%
  filter(
    ITTFL == "Y",
    PARAMCD == "ACTOT",
    AVISIT == "Week 24",
    ANL01FL == "Y"  # Analysis flag for primary timepoint
  )

# Step 3: Compute summary statistics by treatment arm
efficacy_summary <- efficacy_data %>%
  group_by(TRTP) %>%
  summarise(
    N = n(),
    Baseline_Mean_SD = sprintf("%.1f (%.2f)", mean(BASE, na.rm = TRUE), sd(BASE, na.rm = TRUE)),
    Week24_Mean_SD   = sprintf("%.1f (%.2f)", mean(AVAL, na.rm = TRUE), sd(AVAL, na.rm = TRUE)),
    CHG_Mean_SD      = sprintf("%.1f (%.2f)", mean(CHG, na.rm = TRUE), sd(CHG, na.rm = TRUE)),
    .groups = "drop"
  )

# Step 4: Display Table 3 Summary
cat("==================================================================\n")
cat("      TABLE 3: PRIMARY EFFICACY (ADAS-COG TOTAL SCORE AT WEEK 24) \n")
cat("==================================================================\n\n")

print(efficacy_summary)
