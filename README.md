# CDISC ADaM Efficacy & Safety Clinical Programming Pipeline 🏥

[![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)](https://www.r-project.org/)
[![Clinical Data](https://img.shields.io/badge/Clinical%20Data-00897B?style=for-the-badge&logo=medical&logoColor=white)](#)
[![CDISC](https://img.shields.io/badge/CDISC%20ADaM-FF6F00?style=for-the-badge&logoColor=white)](#)
[![Statistics](https://img.shields.io/badge/Statistics-013243?style=for-the-badge&logoColor=white)](#)
[![Data Science](https://img.shields.io/badge/Data%20Science-7B68EE?style=for-the-badge&logoColor=white)](#)

---

## 📌 Project Overview

An **end-to-end clinical data analysis and reporting pipeline in R** designed to demonstrate clinical programming practices aligned with **CDISC ADaM standards**.

This project simulates a **regulatory-oriented clinical trial programming workflow** covering data ingestion, analysis population derivation, efficacy and safety analyses, statistical summaries, publication-ready visualizations, automated reporting, and independent quality control.

---

## 🎯 Key Capabilities

✅ **CDISC ADaM-aligned analysis dataset processing**
- ADSL (Subject-Level Analysis Dataset)
- ADAE (Adverse Events Dataset)
- ADADAS (ADAS-Cog Efficacy Assessments)

✅ **Analysis population derivation**
- Safety Population (SAFFL)
- Intent-to-Treat Population (ITTFL)
- Primary Efficacy Analysis Flag (ANL01FL)

✅ **Statistical analyses**
- Baseline demographics and characteristics
- Treatment-emergent adverse events
- Primary efficacy analysis with LOCF
- Comparative analysis across treatment arms

✅ **Publication-ready outputs**
- Formatted analysis tables
- Professional visualizations (ggplot2)
- Automated Word report generation (flextable + officer)
- Pipeline documentation

✅ **Quality control**
- Independent double-programming validation
- Automated dataset reconciliation (diffdf)
- Audit-oriented QC reports

---

## 🧬 Clinical Standards & Scope

### CDISC ADaM Datasets

| Dataset    | Purpose                                                                 |
| ---------- | ----------------------------------------------------------------------- |
| **ADSL**   | Subject-level demographics, treatment information, population flags    |
| **ADAE**   | Adverse event analysis and treatment-emergent safety summaries         |
| **ADADAS** | ADAS-Cog efficacy analysis and endpoint derivations                   |

### Analysis Populations

| Flag      | Description                                                           |
| --------- | --------------------------------------------------------------------- |
| `SAFFL`   | Safety Population — subjects receiving ≥1 dose of study treatment    |
| `ITTFL`   | Intent-to-Treat Population — randomized subjects                     |
| `ANL01FL` | Primary efficacy analysis flag                                        |

### Primary Endpoints

**Efficacy:**
- ADAS-Cog Total Score (baseline, Week 24, change from baseline)
- LOCF-based imputation for missing Week 24 assessments
- Summarized by treatment arm

**Safety:**
- Treatment-emergent adverse events (TEAE)
- Subject-level incidence by System Organ Class and Preferred Term
- By-treatment-arm summaries

---

## 🏗️ Repository Architecture

```
cdisc-clinical-r-pipeline/
│
├── 01_data_ingestion.R
│   └── Ingestion and validation of raw CDISC domain structures
│
├── 02_table_demographics.R
│   └── Table 1: Baseline Demographics & Characteristics (ADSL)
│
├── 03_table_safety.R
│   └── Table 2: Safety Overview & AE Treatment-Emergent Summary (ADAE)
│
├── 04_table_efficacy.R
│   └── Table 3: Primary Efficacy LOCF Analysis (ADADAS)
│
├── 05_documentation_and_summary.R
│   └── Table 4: Multi-visit Summary Matrix & Pipeline Documentation
│
├── 06_visualization.R
│   └── Figure 1: ADAS-Cog Efficacy Line Chart
│
├── 07_Visualization_adverse_effects.R
│   └── Figure 2: AE Incidence by Treatment Arm
│
├── 08_validation_and_qc.R
│   └── Independent QC & Double-Programming Reconciliation
│
├── Pipeline_Documentation.md
│   └── Functional specification and derivation rules
│
├── QC_Validation_Report.txt
│   └── Independent validation summary
│
├── README.md
│   └── Project documentation
│
└── Pipeline/output/
    ├── Figure1_Efficacy_LineChart_Fixed.png
    ├── Figure2_AE_Incidence.png
    ├── Table_4_Summary_Statistics.docx
    └── QC_Validation_Report.txt
```

---

## 🛠️ Technical Stack

| Category                    | Technologies                                        |
| --------------------------- | --------------------------------------------------- |
| **Programming Language**    | R 4.0+                                              |
| **Data Manipulation**       | tidyverse, dplyr, tidyr, stringr, forcats           |
| **Visualization**           | ggplot2                                             |
| **Reporting**               | flextable, officer                                  |
| **Validation / QC**         | diffdf                                              |
| **Clinical Standards**      | CDISC ADaM                                          |

---

## ⚙️ Installation & Setup

### Prerequisites

Install **R 4.0 or later** from [r-project.org](https://www.r-project.org/)

### Install Required Packages

```r
install.packages(c(
  "tidyverse",
  "dplyr",
  "tidyr",
  "ggplot2",
  "flextable",
  "officer",
  "diffdf"
))
```

### Verify Installation

```r
library(tidyverse)
library(flextable)
library(diffdf)
cat("All packages loaded successfully!\n")
```

---

## ▶️ Running the Pipeline

Scripts are designed to be executed **sequentially from 01 through 08**.

### 1️⃣ Data Ingestion

```bash
Rscript 01_data_ingestion.R
```

Loads and validates input analysis datasets. Establishes required data structures.

**Output:** Validated ADSL, ADAE, ADADAS datasets ready for analysis

---

### 2️⃣ Demographics Table

```bash
Rscript 02_table_demographics.R
```

Generates baseline demographics and subject characteristic summaries from ADSL.

**Output:** Table 1 with age, gender, baseline characteristics by treatment arm

---

### 3️⃣ Safety Analysis

```bash
Rscript 03_table_safety.R
```

Generates safety and treatment-emergent adverse event summaries using ADAE.

**Output:** Table 2 with adverse events by System Organ Class and treatment

---

### 4️⃣ Efficacy Analysis

```bash
Rscript 04_table_efficacy.R
```

Performs primary ADAS-Cog efficacy analysis with baseline change and LOCF handling.

**Output:** Table 3 with efficacy endpoints and statistical comparisons

---

### 5️⃣ Documentation & Summary

```bash
Rscript 05_documentation_and_summary.R
```

Generates multi-visit summary matrix and pipeline documentation.

**Output:** Table 4 and pipeline functional specification

---

### 6️⃣ Efficacy Visualization

```bash
Rscript 06_visualization.R
```

Creates ADAS-Cog efficacy line chart.

**Output:** Figure 1 showing efficacy trends over time

---

### 7️⃣ Adverse Event Visualization

```bash
Rscript 07_Visualization_adverse_effects.R
```

Creates adverse event incidence visualization by treatment arm.

**Output:** Figure 2 showing AE patterns

---

### 8️⃣ Independent QC & Validation

```bash
Rscript 08_validation_and_qc.R
```

Performs independent derivation and reconciliation of key outputs.

**Output:** QC_Validation_Report.txt with reconciliation results

---

## 📊 Generated Deliverables

### Tables

| Table | Content |
| ----- | ------- |
| **Table 1** | Baseline Demographics & Characteristics |
| **Table 2** | Safety Overview & Treatment-Emergent AE Summary |
| **Table 3** | Primary Efficacy Analysis (LOCF) |
| **Table 4** | Multi-visit Summary Statistics |


### Reports

- **Automated Word Summary Report** — Formatted analysis tables
- **Pipeline Documentation** — Functional specifications and derivation rules
- **QC Validation Report** — Independent validation and reconciliation audit trail

---

## 🖼️ Figures

### Figure 1: ADAS-Cog Efficacy Over Time
![ADAS-Cog Efficacy Line Chart](Pipeline/output/Figure1_Efficacy_LineChart_Fixed.png)

Change from baseline in ADAS-Cog Total Score across visits, by treatment arm, with LOCF-based endpoint handling for Week 24.

### Figure 2: Adverse Event Incidence by Treatment Arm
![AE Incidence by Treatment Arm](Pipeline/output/Figure2_AE_Incidence.png)

Subject-level treatment-emergent adverse event incidence, summarized by System Organ Class and treatment arm.

---

## 🔍 Quality Control & Double Programming

Independent validation is central to clinical programming workflows.

### QC Methodology

The `08_validation_and_qc.R` script performs:

1. **Independent Derivation** — Re-derive key analysis objects from raw data
2. **Comparison** — Compare independently generated results against production outputs
3. **Reconciliation** — Identify and document any discrepancies

### QC Scope

Validation checks:
- Analysis population flag assignments
- Primary efficacy analysis values (AVAL, CHG)
- Subject-level analysis records
- Cell-level summary statistics
- Key table outputs

### Pass Criteria

✅ **Pipeline passes validation when:** Zero unexpected mismatches identified across predefined QC checks

### QC Output

Validation results automatically written to:

```
output/QC_Validation_Report.txt
```

Provides audit-oriented record of independent programming and reconciliation.

---

## 📄 Documentation

Additional technical details available in `Pipeline_Documentation.md`:

- Dataset structures and specifications
- Population derivation rules
- Analysis variable derivations
- Endpoint definitions
- LOCF methodology
- Table specifications
- QC methodology
- Pipeline execution requirements

---

## 🎓 Skills Demonstrated

✅ **Clinical Trial Data Programming**
- CDISC ADaM concepts and implementation
- ADSL / ADAE / efficacy analysis datasets
- Analysis population derivation

✅ **Statistical Analysis**
- Baseline and demographic summaries
- Safety analysis and adverse events
- Efficacy analysis with endpoint derivations
- Baseline and change-from-baseline calculations
- Missing data handling (LOCF)

✅ **R Programming**
- Advanced dplyr/tidyr data manipulation
- ggplot2 visualization
- Functional programming
- Script modularity and reusability

✅ **Reporting & Documentation**
- Automated Word report generation
- Publication-ready visualizations
- Comprehensive technical documentation

✅ **Quality Assurance**
- Independent double programming
- Dataset reconciliation
- Clinical programming QC principles
- Audit trail documentation

---

## 🚀 Project Objectives

The objective is to demonstrate an **end-to-end clinical programming workflow in R**, from analysis dataset ingestion through statistical analysis, reporting, visualization, and independent validation.

It demonstrates how clinical programming concepts can be implemented in a reproducible and structured programming environment.

---

## 📌 Disclaimer

**This is a demonstration/portfolio project** using simulated or non-production clinical data.

🚫 **Not intended for:**
- Actual regulatory submissions
- Clinical decision-making
- Production use without modification

✅ **Intended for:**
- Portfolio demonstration
- Educational purposes
- Learning CDISC ADaM standards
- R clinical programming practice

---

## 📚 Resources

- [CDISC Standards](https://www.cdisc.org/standards)
- [ADaM Implementation Guide](https://www.cdisc.org/standards/foundational/adam)
- [R for Data Science](https://r4ds.had.co.nz/)
- [ggplot2 Documentation](https://ggplot2.tidyverse.org/)
- [Flextable Documentation](https://davidgohel.github.io/flextable/)

---

**Built to demonstrate clinical programming excellence. For educational purposes only. 🏥📊**
