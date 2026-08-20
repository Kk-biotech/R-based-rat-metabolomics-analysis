#metabolomics data 
library(readxl)
library(rstatix)
library(tidyverse)
library(ggplot2)
library(ggpubr)
library(dplyr)
library(emmeans)

# Rat dataset 
data  = combined_rat_data.xlsx
data = read_xlsx ("combined_rat_data.xlsx")
data
colnames(data)
data$taurine
data$Diet
data$`trimethylamine N-oxide`
data$`Sampling time`
data$putrescine
data %>% dplyr::select(taurine,Diet)
data = lp_diet_data
data$Diet == "control"
control <- data[trimws(data$Diet) == "control", ]
table(control$`Sampling time`)
unique(control$`Sampling time`)
nrow(control)
                
glimpse('combined_rat_data.xlsx')
view('combined_rat_data.xlsx')
str('combined_rat_data.xlsx')

#vector 
character_vector = c("sample name", "organism","organism part","variant","diet","taurine","trimethylamine N-oxide")
character


#unpaired t-test
metabolite_of_interest <- "taurine"
metabolite_of_interest <- "trimethylamine N-oxide"
t.test(taurine ~ Diet, data = data,var.equal = TRUE)
t.test(`trimethylamine N-oxide` ~ Diet, data = data, var.equal = TRUE
)
library(ggplot2)
#taurine
ggplot(data, aes(x = Diet, y = taurine)) + 
  geom_boxplot(aes(fill = Diet), trim = FALSE) + 
  labs(title = "Taurine Levels in Control and Low Protein Diet Groups", 
       x = "Diet", 
       y = "Taurine Level") + 
  scale_fill_manual(values = c("navyblue", "seagreen4")) + 
  theme_classic() + 
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), 
        axis.title = element_text(size = 10), 
        axis.text = element_text(size = 8))


# TMAO
ggplot(data, aes(x = Diet, y = `trimethylamine N-oxide`)) + 
  geom_boxplot(aes(fill = Diet), trim = FALSE) + 
  labs(title = "Trimethylamine N-oxide Levels in Control and Low Protein Diet Groups", 
       x = "Diet", 
       y = "Trimethylamine N-oxide Level") + 
  scale_fill_manual(values = c("navyblue", "seagreen4")) + 
  theme_classic() + 
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), 
        axis.title = element_text(size = 10), 
        axis.text = element_text(size = 8))


#one way ANOVA 
#metabolic level in different time points based on diet
#taurine (low protein diet)
lp_diet_data <- data[data$Diet == "low protein diet", ]
lp_diet_data$`Sampling time`<- as.factor(lp_diet_data$`Sampling time`)
anova_R = aov(taurine ~ `Sampling time`, data = lp_diet_data)
summary(anova_R)

library(ggplot2)
library(dplyr)
lp_diet_data %>%
  group_by(`Sampling time`) %>%
  summarise(mean = mean(taurine, na.rm = TRUE), 
            sd = sd(taurine, na.rm = TRUE)) %>%
  ggplot(aes(x = `Sampling time`, y = mean)) + 
  geom_col(fill = "royalblue4") + 
  geom_errorbar(aes(ymin = mean - sd, ymax = mean + sd), width = 0.2) + 
  labs(title = "Taurine Levels at Different Sampling Times (Low Protein Diet)", 
       x = "Sampling Time", 
       y = "Taurine Level") + 
  theme_classic() + 
  theme(plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), 
        axis.title = element_text(size = 10), 
        axis.text = element_text(size = 8))

#Tukey HSD 
summary(anova_R)
emmeans_result <- emmeans(anova_R, pairwise ~ `Sampling time`)
emmeans_result

#taurine (control)
control <- data[data$Diet == "control", ]
control$`Sampling time` <- as.factor(control$`Sampling time`)
control_data$`Sampling time` <- droplevels(control_data$`Sampling time`)
anova_R = aov(taurine ~ `Sampling time`, data = control)
summary(anova_R)


control %>%
  group_by(`Sampling time`) %>%
  summarise(mean = mean(taurine, na.rm = TRUE), 
            sd = sd(taurine, na.rm = TRUE)) %>%
  ggplot(aes(x = `Sampling time`, y = mean)) + 
  geom_col(fill = "royalblue4") + 
  geom_errorbar(aes(ymin = mean - sd, ymax = mean + sd), width = 0.2) + 
  labs(title = "Taurine Levels at Different Sampling Times (Control)", 
       x = "Sampling Time", 
       y = "Taurine Level") + 
  theme_classic() + 
  theme(plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), 
        axis.title = element_text(size = 10), 
        axis.text = element_text(size = 8))

# one way anova TMAO 
# lp group 
lp_diet_data <- data[data$Diet == "low protein diet", ]
lp_diet_data$`Sampling time`<- as.factor(lp_diet_data$`Sampling time`)
anova_R = aov(`trimethylamine N-oxide`~`Sampling time`, data = lp_diet_data)
summary(anova_R)
emmeans_result <- emmeans(anova_R, pairwise ~ `Sampling time`)
emmeans_result

#tmao (control)
 control <- data[data$Diet == "control", ]
 control$`Sampling time` <- as.factor(control$`Sampling time`)
 control$`Sampling time` <- droplevels(control$`Sampling time`)
 anova_R <- aov(`trimethylamine N-oxide` ~ `Sampling time`, data = control)
 summary(anova_R)
 
 lp_diet_data %>%
   group_by(`Sampling time`) %>%
   summarise(mean = mean(`trimethylamine N-oxide`, na.rm = TRUE), 
             sd = sd(`trimethylamine N-oxide`, na.rm = TRUE)) %>%
   ggplot(aes(x = `Sampling time`, y = mean)) + 
   geom_col(fill = "mediumvioletred") + 
   geom_errorbar(aes(ymin = mean - sd, ymax = mean + sd), width = 0.2) + 
   labs(title = "trimethylamine N-oxide at Different Sampling Times (low protein diet)", 
        x = "Sampling Time", 
        y = "Trimethylamine N-oxide") + 
   theme_classic() + 
   theme(plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), 
         axis.title = element_text(size = 10), 
         axis.text = element_text(size = 8))
 
 control %>%
   group_by(`Sampling time`) %>%
   summarise(mean = mean(`trimethylamine N-oxide`, na.rm = TRUE), 
             sd = sd(`trimethylamine N-oxide`, na.rm = TRUE)) %>%
   ggplot(aes(x = `Sampling time`, y = mean)) + 
   geom_col(fill = "mediumvioletred") + 
   geom_errorbar(aes(ymin = mean - sd, ymax = mean + sd), width = 0.2) + 
   labs(title = "trimethylamine N-oxide at Different Sampling Times (Control)", 
        x = "Sampling Time", 
        y = "Trimethylamine N-oxide") + 
   theme_classic() + 
   theme(plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), 
         axis.title = element_text(size = 10), 
         axis.text = element_text(size = 8)) 
 


#visualizing mttabolites across groups 
#taurine
ggplot(data, aes(x = Diet, y = taurine)) + 
  geom_boxplot(aes(fill = Diet), alpha = 0.7) + 
  geom_jitter(width = 0.1, color = "black") + 
  labs(title = "Taurine Levels in Control and Low Protein Diet Groups", 
       x = "Diet", 
       y = "Taurine Level") + 
  scale_fill_manual(values = c("sienna3", "lightgoldenrod3")) + 
  theme_classic() + 
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), 
        axis.title = element_text(size = 10), 
        axis.text = element_text(size = 8))

#TMAO
ggplot(data, aes(x = Diet, y = `trimethylamine N-oxide`)) + 
  geom_boxplot(aes(fill = Diet), alpha = 0.7) + 
  geom_jitter(width = 0.1, color = "black") + 
  labs(title = "Trimethylamine N-oxide Levels in Control and Low Protein Diet Groups", 
       x = "Diet", 
       y = "Trimethylamine N-oxide Level") + 
  scale_fill_manual(values = c("sienna3", "lightgoldenrod3")) + 
  theme_classic() + 
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), 
        axis.title = element_text(size = 10), 
        axis.text = element_text(size = 8))

# Threonine
ggplot(data, aes(x = Diet, y = threonine)) + 
  geom_boxplot(aes(fill = Diet), alpha = 0.7) + 
  geom_jitter(width = 0.1, color = "black") + 
  labs(title = "Threonine Levels in Control and Low Protein Diet Groups", 
       x = "Diet", 
       y = "Threonine Level") + 
  scale_fill_manual(values = c("sienna3", "lightgoldenrod3")) + 
  theme_classic() + 
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), 
        axis.title = element_text(size = 10), 
        axis.text = element_text(size = 8))

#valine
ggplot(data, aes(x = Diet, y = valine)) + 
  geom_boxplot(aes(fill = Diet), alpha = 0.7) + 
  geom_jitter(width = 0.1, color = "black") + 
  labs(title = "Valine Levels in Control and Low Protein Diet Groups", 
       x = "Diet", 
       y = "Valine Level") + 
  scale_fill_manual(values = c("sienna3", "lightgoldenrod3")) + 
  theme_classic() + 
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), 
        axis.title = element_text(size = 10), 
        axis.text = element_text(size = 8))

#choline 
ggplot(data, aes(x = Diet, y = choline)) + 
  geom_boxplot(aes(fill = Diet), alpha = 0.7) + 
  geom_jitter(width = 0.1, color = "black") + 
  labs(title = "Choline Levels in Control and Low Protein Diet Groups", 
       x = "Diet", 
       y = "Choline Level") + 
  scale_fill_manual(values = c("sienna3", "lightgoldenrod3")) + 
  theme_classic() + 
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), 
        axis.title = element_text(size = 10), 
        axis.text = element_text(size = 8))


#tartarate
ggplot(data, aes(x = Diet, y = tartarate)) + 
  geom_boxplot(aes(fill = Diet), alpha = 0.7) + 
  geom_jitter(width = 0.1, color = "black") + 
  labs(title = "Tartarate Levels in Control and Low Protein Diet Groups", 
       x = "Diet", 
       y = "Tartarate Level") + 
  scale_fill_manual(values = c("sienna3", "lightgoldenrod3")) + 
  theme_classic() + 
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), 
        axis.title = element_text(size = 10), 
        axis.text = element_text(size = 8))


#fumarate
ggplot(data, aes(x = Diet, y = fumarate )) + 
  geom_boxplot(aes(fill = Diet), alpha = 0.7) + 
  geom_jitter(width = 0.1, color = "black") + 
  labs(title = "fumarate Levels in Control and Low Protein Diet Groups", 
       x = "Diet", 
       y = "fumarate Level") + 
  scale_fill_manual(values = c("sienna3", "lightgoldenrod3")) + 
  theme_classic() + 
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), 
        axis.title = element_text(size = 10), 
        axis.text = element_text(size = 8))

#succinic acid 
ggplot(data, aes(x = Diet, y = `succinic acid`)) + 
  geom_boxplot(aes(fill = Diet), alpha = 0.7) + 
  geom_jitter(width = 0.1, color = "black") + 
  labs(title = "succinic acid Levels in Control and Low Protein Diet Groups", 
       x = "Diet", 
       y = "succinic acid Level") + 
  scale_fill_manual(values = c("sienna3", "lightgoldenrod3")) + 
  theme_classic() + 
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), 
        axis.title = element_text(size = 10), 
        axis.text = element_text(size = 8))


#phenylalanine 
ggplot(data, aes(x = Diet, y = phenylalanine)) + 
  geom_boxplot(aes(fill = Diet), alpha = 0.7) + 
  geom_jitter(width = 0.1, color = "black") + 
  labs(title = "phenylalanine Levels in Control and Low Protein Diet Groups", 
       x = "Diet", 
       y = "phenylalanine Level") + 
  scale_fill_manual(values = c("sienna3", "lightgoldenrod3")) + 
  theme_classic() + 
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), 
        axis.title = element_text(size = 10), 
        axis.text = element_text(size = 8))

#isobutyric acid 
ggplot(data, aes(x = Diet, y = `isobutyric acid`)) + 
  geom_boxplot(aes(fill = Diet), alpha = 0.7) + 
  geom_jitter(width = 0.1, color = "black") + 
  labs(title = " isobutyric acid Levels in Control and Low Protein Diet Groups", 
       x = "Diet", 
       y = "isobutyric acid Level") + 
  scale_fill_manual(values = c("sienna3", "lightgoldenrod3")) + 
  theme_classic() + 
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), 
        axis.title = element_text(size = 10), 
        axis.text = element_text(size = 8))

#cadaverine 
ggplot(data, aes(x = Diet, y = cadaverine )) + 
  geom_boxplot(aes(fill = Diet), alpha = 0.7) + 
  geom_jitter(width = 0.1, color = "black") + 
  labs(title = " cadaverine Levels in Control and Low Protein Diet Groups", 
       x = "Diet", 
       y = "cadaverine Level") + 
  scale_fill_manual(values = c("sienna3", "lightgoldenrod3")) + 
  theme_classic() + 
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), 
        axis.title = element_text(size = 10), 
        axis.text = element_text(size = 8))

#isobutyric acid 
ggplot(data, aes(x = Diet, y = `isobutyric acid`)) + 
  geom_boxplot(aes(fill = Diet), alpha = 0.7) + 
  geom_jitter(width = 0.1, color = "black") + 
  labs(title = " isobutyric acid Levels in Control and Low Protein Diet Groups", 
       x = "Diet", 
       y = "isobutyric acid Level") + 
  scale_fill_manual(values = c("sienna3", "lightgoldenrod3")) + 
  theme_classic() + 
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), 
        axis.title = element_text(size = 10), 
        axis.text = element_text(size = 8))

#N-methylnicotinamide 
ggplot(data, aes(x = Diet, y = `N-methylnicotinamide`)) + 
  geom_boxplot(aes(fill = Diet), alpha = 0.7) + 
  geom_jitter(width = 0.1, color = "black") + 
  labs(title = " N-methylnicotinamide Levels in Control and Low Protein Diet Groups", 
       x = "Diet", 
       y = "N-methylnicotinamide Level") + 
  scale_fill_manual(values = c("sienna3", "lightgoldenrod3")) + 
  theme_classic() + 
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), 
        axis.title = element_text(size = 10), 
        axis.text = element_text(size = 8))
#citric acid 
ggplot(data, aes(x = Diet, y = `citric acid`)) + 
  geom_boxplot(aes(fill = Diet), alpha = 0.7) + 
  geom_jitter(width = 0.1, color = "black") + 
  labs(title = " citric acid Levels in Control and Low Protein Diet Groups", 
       x = "Diet", 
       y = "citric acid Level") + 
  scale_fill_manual(values = c("sienna3", "lightgoldenrod3")) + 
  theme_classic() + 
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), 
        axis.title = element_text(size = 10), 
        axis.text = element_text(size = 8))

#putrescine
ggplot(data, aes(x = Diet, y = `putrescine`)) + 
  geom_boxplot(aes(fill = Diet), alpha = 0.7) + 
  geom_jitter(width = 0.1, color = "black") + 
  labs(title = "putrescine Levels in Control and Low Protein Diet Groups", 
       x = "Diet", 
       y = "putrescine Level") + 
  scale_fill_manual(values = c("sienna3", "lightgoldenrod3")) + 
  theme_classic() + 
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), 
        axis.title = element_text(size = 10), 
        axis.text = element_text(size = 8))


# 2-oxoglutarate 
ggplot(data, aes(x = Diet, y = `2-oxoglutarate`)) + 
  geom_boxplot(aes(fill = Diet), alpha = 0.7) + 
  geom_jitter(width = 0.1, color = "black") + 
  labs(title = "2-oxoglutarate Levels in Control and Low Protein Diet Groups", 
       x = "Diet", 
       y = "2-oxoglutarate Level") + 
  scale_fill_manual(values = c("sienna3", "lightgoldenrod3")) + 
  theme_classic() + 
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), 
        axis.title = element_text(size = 10), 
        axis.text = element_text(size = 8))

# cis-aconitic acid
ggplot(data, aes(x = Diet, y = `cis-aconitic acid`)) + 
  geom_boxplot(aes(fill = Diet), alpha = 0.7) + 
  geom_jitter(width = 0.1, color = "black") + 
  labs(title = "cis-aconitic acid Levels in Control and Low Protein Diet Groups", 
       x = "Diet", 
       y = "cis-aconitic acid Level") + 
  scale_fill_manual(values = c("sienna3", "lightgoldenrod3")) + 
  theme_classic() + 
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), 
        axis.title = element_text(size = 10), 
        axis.text = element_text(size = 8))

# urea
ggplot(data, aes(x = Diet, y = `urea`)) + 
  geom_boxplot(aes(fill = Diet), alpha = 0.7) + 
  geom_jitter(width = 0.1, color = "black") + 
  labs(title = "urea Levels in Control and Low Protein Diet Groups", 
       x = "Diet", 
       y = "urea Level") + 
  scale_fill_manual(values = c("sienna3", "lightgoldenrod3")) + 
  theme_classic() + 
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5, size = 12, face = "bold"), 
        axis.title = element_text(size = 10), 
        axis.text = element_text(size = 8))
## R Packages and Methods

### R packages used

- **readxl** – importing Excel-based metabolomics data
- **tidyverse** – data manipulation and workflow
- **dplyr** – data filtering, grouping and summarization
- **ggplot2** – statistical visualization
- **ggpubr** – publication-oriented visualization support
- **rstatix** – statistical analysis support
- **emmeans** – estimated marginal means and pairwise comparisons

### Statistical methods

The analysis included:

- Exploratory inspection of the metabolomics dataset
- Independent/unpaired t-tests for comparison of metabolite levels between dietary groups
- One-way ANOVA for evaluating metabolite levels across sampling time points within dietary groups
- Estimated marginal means and pairwise comparisons following ANOVA
- Boxplot-based visualization with individual observations
- Mean ± standard deviation visualization across sampling time points
