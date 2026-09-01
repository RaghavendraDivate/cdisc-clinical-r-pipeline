# CDISC ADaM Efficacy & Safety Clinical Programming Pipeline

## Overview
This repository contains an end-to-end, production-grade clinical data analysis pipeline written in R. The workflow adheres strictly to **CDISC ADaM standards** (`ADSL`, `ADAE`, `ADADAS`) and mimics regulatory-compliant Clinical Study Report (CSR) production pipelines used in pharmaceutical and CRO environments.

The project demonstrates complete data ingestion, derivation of analysis population flags, descriptive/efficacy summaries, publication-grade visualization (`ggplot2`), automated CSR Word report compilation (`flextable`/`officer`), and rigorous independent double-programming validation (`diffdf`).

---

## Clinical Standards & Analytical Scope
* **CDISC Standards Implemented:** ADSL v1.1, ADAE v1.1, ADADAS v1.1
* **Population Flags:**
  * **`SAFFL`**: Safety Population (subjects receiving at least one dose of study treatment)
  * **`ITTFL`**: Intent-to-Treat Population (all randomized subjects)
  * **`ANL01FL`**: Primary Efficacy Analysis Flag
* **Primary Endpoints:**
  * **ADAS-Cog Total Score**: Baseline change at Week 24 using Last Observation Carried Forward (LOCF) imputation.
  * **Safety Overview**: Subject-level incidence counts of Adverse Events categorized by System Organ Class (`AESOC`) and Preferred Term (`AEDECOD`).

---

## Repository Architecture

```text
cdisc-clinical-r-pipeline/
├── 01_data_ingestion.R                   # Ingestion and validation of raw CDISC domain structures
├── 02_table_demographics.R               # Table 1: Baseline Demographics & Characteristics (ADSL)
├── 03_table_safety.R                     # Table 2: Safety Overview & AE Treatment-Emergent Summary (ADAE)
├── 04_table_efficacy.R                   # Table 3: Primary Efficacy LOCF Analysis (ADADAS)
├── 05_documentation_and_summary.R        # Table 4: Multi-visit Summary Matrix & Pipeline Markdown Spec
├── 06_visualization.R                    # Figure 1: Efficacy Line Chart (ADAS-Cog Total Score over time)
├── 07_Visualization_adverse_effects.R   # Figure 2: AE Stacked Bar Chart by Treatment Arm
├── 08_validation_and_qc.R                # Automated Independent QC & Double-Programming Reconciliation
├── Pipeline_Documentation.md             # Functional spec detailing derivations and population rules
├── QC_Validation_Report.txt              # Independent validation summary and diff logs
├── README.md                             # Repository overview and execution guide
└── output/                               # Generated artifacts directory
    ├── Figure1_Efficacy_LineChart.png
    ├── Figure2_AE_Incidence.png
    ├── Table_4_Summary_Statistics.docx
    └── QC_Validation_Report.txt

Technical Stack & Dependencies
⚬	Language: R (v4.0+)
⚬	Data Manipulation: tidyverse (dplyr, tidyr, stringr, forcats)
⚬	Reporting & Formatting: flextable, officer
⚬	Data Visualization: ggplot2
⚬	Validation & QC: diffdf

Getting Started

Prerequisites
Ensure you have the required R packages installed prior to running the pipeline:
install.packages(c("tidyverse", "flextable", "officer", "diffdf"))


Execution Order

Run the scripts sequentially from 01 to 08 to generate all clinical outputs and validate calculations:Rscript 01_data_ingestion.R
Rscript 02_table_demographics.R
Rscript 03_table_safety.R
Rscript 04_table_efficacy.R
Rscript 05_documentation_and_summary.R
Rscript 06_visualization.R
Rscript 07_Visualization_adverse_effects.R
Rscript 08_validation_and_qc.R


Quality Control & Double Programming

Regulatory submission standards require independent validation. Script 08 (08_validation_and_qc.R) acts as the Quality Control protocol, executing a parallel derivation of primary analysis objects and comparing them against the production datasets using diffdf::diffdf().
⚬	Pass Criteria: Zero mismatches across primary efficacy values (AVAL, CHG), population flag assignments, and cell-level table summaries.
⚬	QC Output: Audit logs are automatically exported to output/QC_Validation_Report.txt.
