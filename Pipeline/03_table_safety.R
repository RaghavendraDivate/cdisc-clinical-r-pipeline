# ==============================================================================
# Script 03: Safety Table (Table 2 - Adverse Events)
# Purpose: Summarize the incidence of Adverse Events by treatment arm
# ==============================================================================

library(dplyr)
library(tidyr)

# Step 1: Ensure adsl and adae datasets are available
if (!exists("adsl")) adsl <- haven::read_xpt("data/raw/adsl.xpt") # or readRDS if saved
if (!exists("adae")) adae <- haven::read_xpt("data/raw/adae.xpt")

# Step 2: Get total patients per actual treatment arm (Denominators)
pop_counts <- adsl %>%
  group_by(TRT01A) %>%
  summarise(N = n(), .groups = "drop") %>%
  drop_na(TRT01A)

# Step 3: Count unique subjects experiencing each Adverse Event (AEDECOD)
ae_summary <- adae %>%
  group_by(TRTA, AEDECOD) %>%
  summarise(Subj_Count = n_distinct(USUBJID), .groups = "drop") %>%
  drop_na(TRTA)

# Step 4: Merge, calculate total counts for sorting, format, and pivot
ae_table <- ae_summary %>%
  # Create a total count for each AE to use for sorting
  group_by(AEDECOD) %>%
  mutate(Total_AE_Count = sum(Subj_Count)) %>%
  ungroup() %>%
  # Sort numerically descending by the highest total occurrences
  arrange(desc(Total_AE_Count), AEDECOD) %>%
  # Merge denominators and format
  left_join(pop_counts, by = c("TRTA" = "TRT01A")) %>%
  mutate(
    pct = (Subj_Count / N) * 100,
    Formatted_Stat = sprintf("%d (%.1f%%)", Subj_Count, pct)
  ) %>%
  select(AEDECOD, TRTA, Formatted_Stat) %>%
  pivot_wider(names_from = TRTA, values_from = Formatted_Stat, values_fill = "0 (0.0%)")

# Step 5: Display Sorted Table 2 Summary
cat("==================================================================\n")
cat("      TABLE 2: ADVERSE EVENT INCIDENCE (DESCENDING ORDER)         \n")
cat("==================================================================\n\n")

print(head(ae_table, 15))

