
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

