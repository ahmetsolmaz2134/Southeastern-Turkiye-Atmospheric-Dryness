# Atmospheric Dryness and Evaporative Demand in Southeastern Türkiye (1990–2025)

## Research Overview

This repository presents a long-term assessment of **atmospheric dryness and evaporative demand across Southeastern Türkiye** during 1990–2025.

The study integrates meteorological variables and statistical methods to investigate temporal variability, long-term trends, and potential changes in atmospheric moisture conditions.

---

## Key Variables

- Air Temperature
- Relative Humidity
- Precipitation
- Wind Speed
- Solar Radiation
- Vapor Pressure Deficit (VPD)
- Potential Evapotranspiration (PET)

---

# Key Results

## Atmospheric Dryness

The following figures present the temporal evolution of atmospheric dryness indicators across the study period.

### Vapor Pressure Deficit (VPD)

![VPD Analysis](figures/vpd_analysis.png)

**Figure 1.** Long-term temporal variability of Vapor Pressure Deficit (VPD) across Southeastern Türkiye.

---

### Potential Evapotranspiration (PET)

![PET Analysis](figures/pet_analysis.png)

**Figure 2.** Temporal variability of Potential Evapotranspiration (PET) during 1990–2025.

---

## Long-Term Trends

Trend analysis was conducted using:

- Mann–Kendall trend test
- Sen's slope estimator
- Statistical significance assessment

### Trend Analysis

![Trend Analysis](figures/trend_analysis.png)

**Figure 3.** Long-term trends in atmospheric dryness and evaporative demand indicators.

---

## Change-Point Analysis

Abrupt changes in the time series were investigated using the **Pettitt change-point test**.

![Pettitt Analysis](figures/pettitt_analysis.png)

**Figure 4.** Detection of statistically significant change points in atmospheric dryness indicators.

---

## Seasonal and Temporal Variability

Seasonal structure and long-term variability were examined using **STL decomposition**.

![STL Decomposition](figures/stl_decomposition.png)

**Figure 5.** Seasonal, trend, and remainder components of the atmospheric dryness time series.

---

# Methodological Framework

```text
Meteorological Data
        │
        ▼
Data Quality Control
        │
        ▼
Meteorological Variables
        │
        ├── Temperature
        ├── Relative Humidity
        ├── Precipitation
        ├── Wind Speed
        └── Solar Radiation
        │
        ▼
Atmospheric Dryness Indicators
        │
        ├── VPD
        └── PET
        │
        ▼
Statistical Analysis
        │
        ├── Mann–Kendall
        ├── Sen's Slope
        ├── Pettitt Test
        ├── STL Decomposition
        └── Correlation Analysis
        │
        ▼
Long-Term Climate Assessment
