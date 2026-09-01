# ==============================================================================
# PROGRAM NAME:   05_documentation_and_summary.R
# PROJECT:        CDISC Pilot Study 01 (ADAS-Cog Analysis)
# DESCRIPTION:    Generates functional documentation for Scripts 01-04 and 
#                 renders Table 4 (ADAS-Cog Descriptive Summary) to Word.
# AUTHOR:         Raghavendra Ramesh Divate
# DATE:           2026-09-01
# INPUT DATA:     adsl, adadas
# OUTPUT DATA:    Pipeline_Documentation.md, Table_4_Summary_Statistics.docx
# DEPENDENCIES:   dplyr, flextable, officer
# ==============================================================================
library(dplyr)
library(flextable)
library(officer)

# ------------------------------------------------------------------------------
# SECTION 1: CREATE TABLE 4 (DESCRIPTIVE STATISTICS SUMMARY)
# ------------------------------------------------------------------------------

# Filter ITT population and compute summary stats by Visit and Treatment
table4_data <- adadas %>%
  filter(
    ITTFL == "Y",
    PARAMCD == "ACTOT",
    ANL01FL == "Y",
    AVISIT %in% c("Baseline", "Week 8", "Week 16", "Week 24")
  ) %>%
  inner_join(
    adsl %>% filter(ITTFL == "Y") %>% select(USUBJID, TRT01P),
    by = "USUBJID"
  ) %>%
  group_by(AVISIT, TRT01P) %>%
  summarise(
    N         = n(),
    Mean_AVAL = sprintf("%.1f (%.2f)", mean(AVAL, na.rm = TRUE), sd(AVAL, na.rm = TRUE)),
    Median_AV = sprintf("%.1f", median(AVAL, na.rm = TRUE)),
    Min_Max   = sprintf("%.1f, %.1f", min(AVAL, na.rm = TRUE), max(AVAL, na.rm = TRUE)),
    Mean_CHG  = sprintf("%.1f (%.2f)", mean(CHG, na.rm = TRUE), sd(CHG, na.rm = TRUE)),
    .groups   = "drop"
  ) %>%
  mutate(AVISIT = factor(AVISIT, levels = c("Baseline", "Week 8", "Week 16", "Week 24"))) %>%
  arrange(AVISIT, TRT01P)

# Render formatted Flextable
ft4 <- flextable(table4_data) %>%
  set_header_labels(
    AVISIT    = "Visit",
    TRT01P    = "Treatment Arm",
    N         = "N",
    Mean_AVAL = "Score: Mean (SD)",
    Median_AV = "Median",
    Min_Max   = "Min, Max",
    Mean_CHG  = "Change: Mean (SD)"
  ) %>%
  autofit() %>%
  theme_booktabs() %>%
  add_header_lines("Table 4: Summary of ADAS-Cog Total Score by Visit (ITT Population)")

# Export Table 4 to Word
doc <- read_docx() %>%
  body_add_flextable(ft4)
print(doc, target = "Table_4_Summary_Statistics.docx")

# ------------------------------------------------------------------------------
# SECTION 2: GENERATE PIPELINE DOCUMENTATION (SCRIPTS 01 - 04)
# ------------------------------------------------------------------------------

doc_text <- "
# Clinical Analysis Pipeline Documentation (Scripts 01 - 04)
**Study:** CDISC Pilot Study 01  
**Target Endpoint:** ADAS-Cog Total Score & Adverse Events  

---

### Script 01: Demographics Summary (`01_adsl_demographics.R`)
* **Objective:** Produce Table 1 (Demographic & Baseline Characteristics).
* **Source Dataset:** `ADSL`
* **Filters Applied:** `SAFFL == 'Y'` (Safety Population)
* **Key Variables:** Age, Sex, Race, Ethnic, Baseline BMI.

### Script 02: Adverse Events Summary (`02_adae_safety.R`)
* **Objective:** Produce Table 2 (Safety Overview & AE Incidence).
* **Source Datasets:** `ADSL`, `ADAE`
* **Filters Applied:** `SAFFL == 'Y'` joined via `USUBJID`
* **Key Derivations:** Subject incidence counts per Preferred Term (`AEDECOD`) divided by Treatment Arm `BigN`.

### Script 03: Efficacy Derivation (`03_adadas_efficacy.R`)
* **Objective:** Derive Primary Efficacy Analysis (Week 24 LOCF).
* **Source Datasets:** `ADSL`, `ADADAS`
* **Filters Applied:** `ITTFL == 'Y'`, `PARAMCD == 'ACTOT'`, `ANL01FL == 'Y'`
* **Key Derivations:** Baseline Change (`CHG = AVAL - BASE`) at Week 24.

### Script 04: Efficacy Summary Table (`04_table_summary.R`)
* **Objective:** Calculate descriptive statistics matrix for all study visits.
* **Source Datasets:** `ADSL`, `ADADAS`
* **Outputs Generated:** `Table_4_Summary_Statistics.docx` (N, Mean, SD, Median, Min, Max for Baseline through Week 24).
"

# Write documentation file
writeLines(doc_text, "Pipeline_Documentation.md")
cat("Success: Table 4 exported to Word and documentation saved to 'Pipeline_Documentation.md'\n")
