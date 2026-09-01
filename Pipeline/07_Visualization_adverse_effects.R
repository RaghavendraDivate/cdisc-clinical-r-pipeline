# ==============================================================================
# Script 06: Adverse Events Stacked Bar Chart (Figure 2)
# Purpose: Plot Incidence of Common AEs by Preferred Term
# ==============================================================================
library(ggplot2)
library(dplyr)

# 1. Extract Safety Population and Planned Treatment from ADSL
adsl_pop <- adsl %>%
  filter(SAFFL == "Y") %>%
  select(USUBJID, TRT01P)

# 2. Compute Total N (BigN) per treatment group
bign_counts <- adsl_pop %>%
  group_by(TRT01P) %>%
  summarise(BigN = n(), .groups = "drop")

# 3. Join TRT01P into ADAE and calculate % incidence
ae_plot_data <- adae %>%
  filter(AEDECOD %in% c("PRURITUS", "DIZZINESS", "NAUSEA", "HEADACHE")) %>%
  inner_join(adsl_pop, by = "USUBJID") %>%
  group_by(TRT01P, AEDECOD) %>%
  summarise(Count = n_distinct(USUBJID), .groups = "drop") %>%
  left_join(bign_counts, by = "TRT01P") %>%
  mutate(Pct = (Count / BigN) * 100)

# 4. Generate and display plot
p2 <- ggplot(ae_plot_data, aes(x = TRT01P, y = Pct, fill = AEDECOD)) +
  geom_bar(stat = "identity", position = "stack", width = 0.7) +
  scale_fill_brewer(palette = "Set2") +
  labs(
    title = "Figure 2: Incidence of Common Adverse Events",
    subtitle = "Top Preferred Terms (Safety Population)",
    x = "Treatment Groups",
    y = "% of Subjects",
    fill = "AE Preferred Term"
  ) +
  theme_minimal() +
  theme(
    legend.position = "right",
    plot.title = element_text(face = "bold", size = 12)
  )

print(p2)
ggsave("Figure2_AE_Incidence.png", plot = p2, width = 8, height = 5, dpi = 300)
