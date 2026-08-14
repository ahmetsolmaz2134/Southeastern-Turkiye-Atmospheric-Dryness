# Atmospheric Dryness and Evaporative Demand in Southeastern Türkiye (1990–2025)

## Overview

This project investigates long-term changes in atmospheric dryness and evaporative demand across Southeastern Türkiye during the 1990–2025 period.

The study uses meteorological data obtained from the NASA Prediction of Worldwide Energy Resources (NASA POWER) database and applies reproducible statistical methods in R.

## Research Objectives

- Assess long-term temperature variability.
- Examine changes in atmospheric moisture conditions.
- Quantify Vapor Pressure Deficit (VPD).
- Estimate Potential Evapotranspiration (PET).
- Detect significant temporal trends.
- Identify potential climatic change points.
- Analyse seasonal and long-term variability.
- Examine relationships among major climatic variables.

## Study Area

Southeastern Türkiye is a climatically sensitive region characterized by substantial temperature and precipitation variability and predominantly semi-arid environmental conditions.

The region provides an appropriate geographical setting for investigating changes in atmospheric moisture demand and evaporative conditions.

## Study Period

**1990–2025**

## Data Source

NASA Prediction of Worldwide Energy Resources (NASA POWER)

## Climate Variables

- Air Temperature
- Maximum Temperature
- Minimum Temperature
- Relative Humidity
- Precipitation
- Wind Speed
- Surface Solar Radiation

## Derived Indicators

### Vapor Pressure Deficit

Vapor Pressure Deficit (VPD) is used to characterize atmospheric moisture demand and atmospheric dryness.

### Potential Evapotranspiration

Potential Evapotranspiration (PET) is used to characterize atmospheric evaporative demand.

## Statistical Methods

The study will employ:

- Mann–Kendall Trend Test
- Sen's Slope Estimator
- Pettitt Change-Point Test
- STL Decomposition
- Pearson Correlation
- Spearman Correlation

## Analytical Framework

NASA POWER Data  
↓  
Data Processing  
↓  
Quality Control  
↓  
VPD and PET Calculation  
↓  
Trend Analysis  
↓  
Change-Point Detection  
↓  
STL Decomposition  
↓  
Correlation Analysis  
↓  
Scientific Visualization

## Repository Structure

```text
Southeastern-Turkiye-Atmospheric-Dryness/
│
├── README.md
├── LICENSE
│
├── R/
│   └── analysis.R
│
├── data/
│   └── README.md
│
└── figures/
    └── README.md
