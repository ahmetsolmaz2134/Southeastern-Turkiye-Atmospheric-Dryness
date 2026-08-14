# ================================================================
# SOUTHEASTERN TÜRKİYE ATMOSPHERIC DRYNESS ANALYSIS
# Academic GitHub Repository Structure
# ================================================================

# ------------------------------------------------
# 1. PROJECT DIRECTORY
# ------------------------------------------------

project_dir <- "Southeastern-Turkiye-Atmospheric-Dryness"

if (!dir.exists(project_dir)) {
  dir.create(project_dir, recursive = TRUE)
}

# ------------------------------------------------
# 2. CLEAN / CREATE DIRECTORY STRUCTURE
# ------------------------------------------------

folders <- c(
  "data",
  "data/raw",
  "data/processed",
  "R",
  "figures",
  "tables",
  "docs"
)

for (folder in folders) {
  dir.create(
    file.path(project_dir, folder),
    recursive = TRUE,
    showWarnings = FALSE
  )
}

# ------------------------------------------------
# 3. REMOVE OLD R SCRIPTS
# ------------------------------------------------

old_files <- list.files(
  file.path(project_dir, "R"),
  full.names = TRUE
)

if (length(old_files) > 0) {
  file.remove(old_files)
}

# ------------------------------------------------
# 4. CREATE ACADEMIC R WORKFLOW
# ------------------------------------------------

scripts <- list(

  "01_data_acquisition.R" = '
# ================================================================
# 01_data_acquisition.R
# NASA POWER Data Acquisition
# ================================================================

# Study:
# Atmospheric Dryness and Evaporative Demand in Southeastern Türkiye
# Period: 1990–2025
# Data Source: NASA POWER

# This script will retrieve meteorological data from NASA POWER.

# Variables:
# T2M
# T2M_MAX
# T2M_MIN
# RH2M
# PRECTOTCORR
# WS2M
# ALLSKY_SFC_SW_DWN

# Study locations will be defined in the final analysis stage.
',

  "02_data_processing.R" = '
# ================================================================
# 02_data_processing.R
# Data Processing and Quality Control
# ================================================================

# Tasks:
# 1. Import NASA POWER data
# 2. Convert dates
# 3. Check missing observations
# 4. Detect invalid values
# 5. Standardize variable names
# 6. Prepare analysis-ready datasets
',

  "03_vpd_analysis.R" = '
# ================================================================
# 03_vpd_analysis.R
# Vapor Pressure Deficit Analysis
# ================================================================

# This script will calculate and analyse Vapor Pressure Deficit (VPD).

# Main objectives:
# - Calculate VPD
# - Examine temporal variability
# - Assess seasonal behaviour
# - Quantify long-term changes
',

  "04_pet_analysis.R" = '
# ================================================================
# 04_pet_analysis.R
# Potential Evapotranspiration Analysis
# ================================================================

# This script will estimate Potential Evapotranspiration (PET).

# Main objectives:
# - Calculate PET
# - Examine temporal variability
# - Assess seasonal patterns
# - Investigate long-term changes
',

  "05_trend_analysis.R" = '
# ================================================================
# 05_trend_analysis.R
# Long-Term Trend Analysis
# ================================================================

# Statistical methods:
#
# - Mann–Kendall trend test
# - Sen’s slope estimator
#
# These methods will be applied to:
#
# - Temperature
# - Relative humidity
# - Precipitation
# - VPD
# - PET
',

  "06_change_point_analysis.R" = '
# ================================================================
# 06_change_point_analysis.R
# Change-Point Analysis
# ================================================================

# Method:
# Pettitt change-point test
#
# Objective:
# Identify statistically significant shifts in the temporal
# behaviour of atmospheric dryness and evaporative demand.
',

  "07_stl_decomposition.R" = '
# ================================================================
# 07_stl_decomposition.R
# Seasonal-Trend Decomposition
# ================================================================

# STL decomposition will be used to separate:
#
# 1. Seasonal component
# 2. Trend component
# 3. Remainder component
#
# The analysis will help identify long-term changes while
# accounting for seasonal variability.
',

  "08_visualization.R" = '
# ================================================================
# 08_visualization.R
# Scientific Visualization
# ================================================================

# Planned outputs:
#
# - Temperature time series
# - Relative humidity time series
# - Precipitation time series
# - VPD time series
# - PET time series
# - Trend figures
# - Change-point figures
# - STL decomposition plots
# - Comparative climate figures
'
)

for (filename in names(scripts)) {

  writeLines(
    scripts[[filename]],
    file.path(project_dir, "R", filename)
  )
}

# ------------------------------------------------
# 5. ACADEMIC README
# ------------------------------------------------

readme <- '
# Atmospheric Dryness and Evaporative Demand in Southeastern Türkiye (1990–2025)

## Abstract

This project investigates long-term changes in atmospheric dryness and evaporative demand across Southeastern Türkiye during the 1990–2025 period.

Meteorological data are obtained from the NASA Prediction of Worldwide Energy Resources (NASA POWER) database and analysed using reproducible statistical workflows implemented in R.

The study focuses on temperature, relative humidity, precipitation, wind speed, solar radiation, vapor pressure deficit (VPD), and potential evapotranspiration (PET).

The statistical framework combines non-parametric trend analysis, change-point detection, seasonal-trend decomposition, and correlation analysis to characterize temporal changes in atmospheric conditions.

---

## Research Objectives

The study aims to:

1. Quantify long-term changes in temperature and atmospheric moisture.
2. Assess temporal variability in vapor pressure deficit.
3. Estimate changes in potential evapotranspiration.
4. Identify statistically significant climate trends.
5. Detect potential climatic change points.
6. Separate long-term trends from seasonal variability.
7. Examine relationships among temperature, precipitation, humidity, VPD, and PET.

---

## Study Area

The study focuses on Southeastern Türkiye, a climatically sensitive region characterized by semi-arid to Mediterranean climatic conditions and substantial spatial and temporal variability in temperature and precipitation.

The region is particularly relevant for investigating atmospheric dryness and evaporative demand because increasing thermal conditions may interact with precipitation variability and atmospheric moisture availability.

---

## Study Period

**1990–2025**

---

## Data Source

Meteorological and solar radiation data are obtained from:

**NASA Prediction of Worldwide Energy Resources (NASA POWER)**

The project uses reproducible data acquisition procedures implemented in R.

---

## Climate Variables

The analysis includes:

- Air temperature (T2M)
- Maximum air temperature (T2M_MAX)
- Minimum air temperature (T2M_MIN)
- Relative humidity (RH2M)
- Precipitation (PRECTOTCORR)
- Wind speed (WS2M)
- Surface solar radiation (ALLSKY_SFC_SW_DWN)

---

## Derived Climate Indicators

The following indicators will be calculated:

### Vapor Pressure Deficit (VPD)

VPD is used as an indicator of atmospheric moisture demand and atmospheric dryness.

### Potential Evapotranspiration (PET)

PET represents the atmospheric evaporative demand under available environmental conditions.

### Atmospheric Dryness Indicators

Additional dryness-related indicators will be derived from temperature, precipitation, humidity, and evaporative demand variables.

---

## Methodology

The analytical workflow consists of the following stages:

```text
NASA POWER Data
        |
        v
Data Acquisition
        |
        v
Data Quality Control
        |
        v
Climate Variable Processing
        |
        v
VPD Calculation
        |
        v
PET Estimation
        |
        v
Trend Analysis
        |
        v
Change-Point Detection
        |
        v
STL Decomposition
        |
        v
Correlation Analysis
        |
        v
Scientific Visualization
