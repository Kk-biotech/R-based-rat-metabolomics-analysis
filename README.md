# R-Based Rat Metabolomics Analysis

## Overview

This repository contains an R-based statistical analysis and visualization of urinary metabolomics data from rats subjected to control and low-protein dietary conditions.

The project was carried out as part of an internship project in an Environmental Epigenomics research setting and focuses on exploring metabolite-level differences between dietary groups and changes across sampling time points.

## Objectives

The main objectives of the analysis were:

- To compare urinary metabolite levels between control and low-protein diet groups.
- To investigate metabolite variation across different sampling time points.
- To perform statistical analysis of metabolite-level differences.
- To generate graphical representations of metabolite distributions and temporal patterns.
- To explore metabolites that may show differential responses to dietary protein restriction.

## Metabolites Analysed

The analysis included urinary metabolites including:

- Valine
- Tryptophan
- Urea
- Trimethylamine N-oxide (TMAO)
- Taurine

## Methods

The analysis was performed using R and included:

- Data import and preprocessing
- Descriptive analysis
- Comparison between dietary groups
- Statistical testing
- ANOVA-based analysis of sampling-time effects
- Post-hoc / estimated marginal means analysis
- Data visualization

## R Packages

The analysis used R packages including:

- `tidyverse`
- `ggplot2`
- `dplyr`
- `readxl`
- `rstatix`
- `ggpubr`
- `emmeans`

## Visualizations

The repository includes visualizations showing:

- Metabolite distributions between control and low-protein diet groups
- Valine levels
- Tryptophan levels
- Urea levels
- TMAO levels
- Taurine levels across sampling time points

## Project Workflow

```text
Metabolomics Dataset
        ↓
Data Import & Preprocessing
        ↓
Exploratory Data Analysis
        ↓
Statistical Analysis
        ↓
Group Comparisons
        ↓
Temporal Analysis
        ↓
Data Visualization
        ↓
Biological Interpretation
