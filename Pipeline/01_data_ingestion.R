# ==============================================================================
# Script 01: Data Ingestion & Initial Inspection (Local Import)
# Purpose: Load local ADaM .xpt files and verify dataset contents
# ==============================================================================

# step1 Load required libraries
library(haven)
library(dplyr)

# step 2 DEfine paths to ur local raw files
adsl_path <- "~/Desktop/Projects/Veramed_Project/files/dataset/cdiscpilot_update1/AdaM/adsl.xpt"
adae_path <- "~/Desktop/Projects/Veramed_Project/files/dataset/cdiscpilot_update1/AdaM/adae.xpt"
adadas_path <- "~/Desktop/Projects/Veramed_Project/files/dataset/cdiscpilot_update1/AdaM/adadas.xpt"

#  Step 3: Import datasets into R memory from your local folder
adsl <- read_xpt(adsl_path)
adae <- read_xpt(adae_path)
adadas<- read_xpt(adadas_path)

# Part 1: Verify Dataset Dimensions
cat("=========================================\n")
cat("          DATASET INGESTION SUMMARY       \n")
cat("=========================================\n")
cat("1. ADSL (Subject Level)     : ", nrow(adsl), "rows |", ncol(adsl), "columns\n")
cat("2. ADAE (Subject Level)     :", nrow(adae), "rows |" , ncol(adae), "columns\n")
cat("3 . ADADAS (Subject level)  :" , nrow(adadas), "rows |", ncol(adadas), "columns\n")


glimpse(adsl)
glimpse(adae)
glimpse(adadas)
# ------------------------------------------------------------------------------
# Part 2: Inspect ADSL Population & Treatment Arms
# ------------------------------------------------------------------------------
cat("--- Subject Breakdown by Planned Treatment Arm (ADSL) ---\n")
print(table(adsl$TRT01P))

cat("\n--- First 6 Rows of ADSL Key Variables ---\n")
adsl %>% 
  select(USUBJID, TRT01P, AGE, SEX, RACE, MMSETOT) %>% 
  head() %>% 
  print()

# ------------------------------------------------------------------------------
# Part 3: Inspect ADAE Top Adverse Events
# ------------------------------------------------------------------------------
cat("\n--- Top 5 Reported Adverse Event Terms (ADAE) ---\n")
adae %>% 
  count(AEDECOD, sort = TRUE) %>% 
  head(5) %>% 
  print()

# ------------------------------------------------------------------------------
# Part 4: Inspect ADSADAS Primary Endpoint Visits
# ------------------------------------------------------------------------------
cat("\n--- ADAS-Cog Total Score (ACTOT) Visit Counts (ADQSADAS) ---\n")
adadas %>% 
  filter(QSTESTCD == "ACTOT") %>% 
  count(AVISIT, AVISITN) %>% 
  print()
