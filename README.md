Leading Causes of Death in the United States (1999–2017)

Tools: SQL · Google BigQueryData Source: NCHS – Leading Causes of Death: United States (data.gov)
Overview
This project analyzes 18 years of CDC mortality data using SQL to identify national trends, state-level disparities, and which causes of death improved or worsened over time.
Key Findings
1. Heart disease remains the #1 killer
As of 2017, heart disease had the highest age-adjusted death rate nationally at 165.0 per 100,000 — making it the leading cause of death for the entirety of the dataset’s timeframe.
2. Large geographic disparities exist
Mississippi had the highest average heart disease death rate (277.1), more than double that of Minnesota (137.4), the lowest in the nation. Oklahoma (260.0) and Alabama (254.5) also ranked among the highest, while Colorado (150.6) and Hawaii (155.4) rounded out the healthiest states.
3. Overall mortality has improved since 1999
1999 saw the highest average age-adjusted death rate at 69.81. Rates declined steadily over the following 18 years, reflecting broad public health progress.
4. Most causes improved, but not all
Of the 9 causes tracked, 6 improved since 1999 while 3 got worse — Alzheimer’s disease (+14.5), unintentional injuries (+14.1), and suicide both increased, reflecting broader national crises in aging, accidents, and mental health.

Queries Included
	∙	data_exploration.sql — data validation and structure check
	∙	state_and_national_trends.sql — year-over-year trends by cause
	∙	nsights.sql — headline findings summary
