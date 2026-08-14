# ============================================================
# SOUTHEASTERN TÜRKİYE ATMOSPHERIC DRYNESS ANALYSIS
# Project Structure Generator
# ============================================================

# ------------------------------------------------------------
# 1. PROJECT NAME
# ------------------------------------------------------------

project_name <- "Southeastern-Turkiye-Atmospheric-Dryness-Analysis"

# Ana klasörü oluştur
dir.create(project_name, showWarnings = FALSE)

# ------------------------------------------------------------
# 2. FOLDER STRUCTURE
# ------------------------------------------------------------

folders <- c(
  "data",
  "data/raw",
  "data/processed",
  "data/metadata",
  "R",
  "figures",
  "figures/temperature",
  "figures/humidity",
  "figures/vpd",
  "figures/pet",
  "figures/trends",
  "tables",
  "tables/descriptive_statistics",
  "tables/trend_results",
  "tables/change_points",
  "docs",
  "references"
)

for (folder in folders) {
  dir.create(
    file.path(project_name, folder),
    recursive = TRUE,
    showWarnings = FALSE
  )
}

# ------------------------------------------------------------
# 3. R SCRIPT FILES
# ------------------------------------------------------------

r_scripts <- c(
  "01_NASA_POWER_Data.R",
  "02_Data_Cleaning.R",
  "03_Descriptive_Analysis.R",
  "04_VPD_Calculation.R",
  "05_PET_Calculation.R",
  "06_Aridity_Analysis.R",
  "07_Mann_Kendall.R",
  "08_Sens_Slope.R",
  "09_Pettitt_Test.R",
  "10_STL_Decomposition.R",
  "11_Correlation_Analysis.R",
  "12_Final_Figures.R"
)

for (script in r_scripts) {

  file_path <- file.path(
    project_name,
    "R",
    script
  )

  writeLines(
    c(
      "# ============================================================",
      paste("#", script),
      "# Southeastern Türkiye Atmospheric Dryness Analysis",
      "# ============================================================",
      "",
      "# Project period: 1990-2025",
      "# Data source: NASA POWER",
      "# Study region: Southeastern Türkiye",
      ""
    ),
    file_path
  )
}

# ------------------------------------------------------------
# 4. README
# ------------------------------------------------------------

readme <- '
# Atmospheric Dryness and Evaporative Demand in Southeastern Türkiye (1990–2025)

## Overview

This project investigates long-term changes in atmospheric dryness and evaporative demand across Southeastern Türkiye between 1990 and 2025.

The analysis uses meteorological data obtained from the NASA POWER database and is conducted entirely in R.

## Research Question

How have atmospheric dryness and evaporative demand changed across Southeastern Türkiye between 1990 and 2025?

## Study Area

The initial study area includes:

- Diyarbakır
- Şanlıurfa
- Mardin
- Batman
- Siirt
- Şırnak
- Gaziantep
- Kilis
- Adıyaman

## Data Source

NASA POWER

## Main Climate Variables

- Air Temperature
- Maximum Temperature
- Minimum Temperature
- Relative Humidity
- Precipitation
- Wind Speed
- Surface Solar Radiation

## Derived Climate Indicators

- Vapor Pressure Deficit (VPD)
- Potential Evapotranspiration (PET)
- Aridity Indicators
- Atmospheric Dryness Indicators

## Statistical Methods

- Mann-Kendall Trend Test
- Sen’s Slope Estimator
- Pettitt Change-Point Test
- STL Decomposition
- Pearson Correlation
- Spearman Correlation

## Project Workflow

NASA POWER Data
        ↓
Data Cleaning
        ↓
Quality Control
        ↓
Climate Indicators
        ↓
VPD
        ↓
PET
        ↓
Aridity Analysis
        ↓
Trend Analysis
        ↓
Change-Point Detection
        ↓
STL Decomposition
        ↓
Correlation Analysis
        ↓
Visualization

## Reproducibility

All data-processing and statistical procedures are implemented in R scripts contained within the `R/` directory.

## Status

Project structure established.

Data acquisition and statistical analysis will be added progressively.
'

writeLines(
  readme,
  file.path(project_name, "README.md")
)

# ------------------------------------------------------------
# 5. DATA README
# ------------------------------------------------------------

data_readme <- '
# Data

## Raw Data

Original NASA POWER data will be stored in:

`data/raw/`

## Processed Data

Cleaned and analysis-ready datasets will be stored in:

`data/processed/`

## Metadata

Information about NASA POWER parameters, units, coordinates and data processing will be stored in:

`data/metadata/`
'

writeLines(
  data_readme,
  file.path(project_name, "data", "README.md")
)

# ------------------------------------------------------------
# 6. METHODOLOGY DOCUMENT
# ------------------------------------------------------------

methodology <- '
# Methodology

## Study Period

1990–2025

## Study Region

Southeastern Türkiye

## Data Source

NASA POWER meteorological and solar radiation data.

## Climate Variables

Temperature, relative humidity, precipitation, wind speed and solar radiation.

## Derived Variables

Vapor Pressure Deficit (VPD), Potential Evapotranspiration (PET), and atmospheric dryness indicators.

## Statistical Analysis

Long-term trends will be assessed using the Mann-Kendall test and Sen’s slope estimator.

Potential abrupt changes will be investigated using the Pettitt change-point test.

Seasonal and trend components will be investigated using STL decomposition.

Relationships between climatic variables will be assessed using Pearson and Spearman correlation coefficients.
'

writeLines(
  methodology,
  file.path(project_name, "docs", "methodology.md")
)

# ------------------------------------------------------------
# 7. REFERENCES FILE
# ------------------------------------------------------------

references <- '
# References

NASA POWER Project.
Prediction Of Worldwide Energy Resources.

NASA Langley Research Center.
NASA POWER Data Access Viewer and API.

Additional methodological references will be added during the analysis.
'

writeLines(
  references,
  file.path(project_name, "references", "references.bib")
)

# ------------------------------------------------------------
# 8. LICENSE
# ------------------------------------------------------------

license <- '
MIT License

Copyright (c) 2026

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files, to deal in the Software
without restriction, including without limitation the rights to use, copy,
modify, merge, publish, distribute, sublicense, and/or sell copies of the Software.
'

writeLines(
  license,
  file.path(project_name, "LICENSE")
)

# ------------------------------------------------------------
# 9. INSTALL REQUIRED PACKAGES
# ------------------------------------------------------------

packages <- c(
  "nasapower",
  "tidyverse",
  "lubridate",
  "trend",
  "Kendall",
  "zoo",
  "scales",
  "ggplot2"
)

installed <- rownames(installed.packages())

for (pkg in packages) {

  if (!(pkg %in% installed)) {
    install.packages(pkg)
  }

}

# ------------------------------------------------------------
# 10. CREATE PROJECT SUMMARY
# ------------------------------------------------------------

cat("\n")
cat("============================================================\n")
cat(" PROJECT CREATED SUCCESSFULLY\n")
cat("============================================================\n\n")

cat("Project:\n")
cat(project_name, "\n\n")

cat("Study Area:\n")
cat("Southeastern Türkiye\n\n")

cat("Study Period:\n")
cat("1990-2025\n\n")

cat("Data Source:\n")
cat("NASA POWER\n\n")

cat("Main Analysis:\n")
cat("VPD + PET + Atmospheric Dryness + Trend Analysis\n\n")

cat("Folder:\n")
cat(normalizePath(project_name), "\n\n")

cat("============================================================\n")
cat(" NEXT STEP: NASA POWER DATA DOWNLOAD\n")
cat("============================================================\n")
