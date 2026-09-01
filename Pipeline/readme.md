# CDISC ADaM Efficacy and Safety Clinical Programming Pipeline

## Executive Summary
This repository contains an end-to-end clinical data analysis pipeline implemented in R, utilizing CDISC ADaM standards (`ADSL`, `ADAE`, `ADADAS`) based on the CDISC Pilot Study dataset. The pipeline handles data ingestion, derivation of analysis population flags, descriptive/efficacy summaries, publication-grade figures (`ggplot2`), CSR document exports (`flextable`), and automated double-programming validation (`diffdf`).

## Clinical Data Standards & Scope
* **CDISC Standards:** ADSL v1.1, ADAE v1.1, ADADAS v1.1
* **Population Flags:** Safety (`SAFFL`), Intent-to-Treat (`ITTFL`), Efficacy (`EFFFL`), Analysis Record (`ANL01FL`)
* **Core Endpoints:** ADAS-Cog Total Score Change from Baseline (LOCF), Adverse Event Incidence Rates

## Repository Architecture
* `01_adsl_demographics.R` — Demographics & Baseline Characteristics (Table 1)
* `02_adae_safety.R` — Adverse Event Incidence & Preferred Term Summary (Table 2)
* `03_adadas_efficacy.R` — Primary Efficacy LOCF Analysis (Table 3)
* `04_table_summary.R` — Multi-visit Descriptive Statistics Matrix
* `05_documentation_and_summary.R` — Formatted Table 4 Export (`flextable`) & Pipeline Documentation
* `06_figures_ae.R` — AE Stacked Bar Chart & Efficacy Line Plot (`ggplot2`)
* `07_docx_reporting.R` — Clinical Study Report (CSR) Word Document Compiler
* `08_validation_and_qc.R` — Double Programming Reconciliation & QC Log (`diffdf`)

## Tech Stack
* **Language:** R (v4.x)
* **Packages:** `tidyverse` (`dplyr`, `ggplot2`), `flextable`, `officer`, `diffdf`
