# --- Load Required Libraries ---
# Install required packages if not already installed
# install.packages(c("readxl", "psych", "car", "leaps", "QuantPsyc"))

library(readxl)
library(psych)
library(carData)
library(car)
library(leaps)
library(QuantPsyc)

# --- Import Data ---
# Replace with your actual path to the dataset
Live_Data_1990 <- read_excel("path/to/your_data.xlsx")

# --- Set Variables ---
cal_1990 <- Live_Data_1990
house_val <- cal_1990$Median_House_Value
income <- cal_1990$Median_Income
age <- cal_1990$Median_Age
total_rooms <- cal_1990$Tot_Rooms
total_b_rooms <- cal_1990$Tot_Bedrooms
pop <- cal_1990$Population
total_houses <- cal_1990$Households
lat <- cal_1990$Latitude
long <- cal_1990$Longitude
dcoast <- cal_1990$Distance_to_coast
dla <- cal_1990$Distance_to_LA
dsd <- cal_1990$Distance_to_SanDiego
dsj <- cal_1990$Distance_to_SanJose
dsf <- cal_1990$Distance_to_SanFrancisco

# --- Descriptive Statistics ---
describe(cal_1990)

# --- Check Distributions and Apply Transformations ---
hist(house_val, main = "Median House Value Distribution")
log_house_val <- log(house_val)
hist(log_house_val, main = "Log of Median House Value Distribution")
sqrt_house_val <- sqrt(house_val)
hist(sqrt_house_val, main = "Square Root of Median House Value Distribution")

# --- Correlation and Scatterplot Matrix ---
pairs(cal_1990, main = "Scatterplot Matrix")
cor(cal_1990)

# --- Build Initial Models ---
# Full model using raw values
full_model <- lm(house_val ~ income + age + total_rooms + total_b_rooms + pop + total_houses + 
                   lat + long + dcoast + dla + dsd + dsj + dsf, data = cal_1990)
summary(full_model)

# Full model with square root transformation on response
trans_full_model <- lm(sqrt_house_val ~ income + age + total_rooms + total_b_rooms + pop + 
                         total_houses + lat + long + dcoast + dla + dsd + dsj + dsf, data = cal_1990)
summary(trans_full_model)

# --- Check for Multicollinearity ---
vif(trans_full_model)

# --- Model Refinement ---
# Remove lat and long due to multicollinearity
m2 <- lm(sqrt_house_val ~ income + age + total_rooms + total_b_rooms + pop + total_houses + 
           dcoast + dla + dsd + dsj + dsf, data = cal_1990)
summary(m2)
vif(m2)

# Further remove total rooms and total bedrooms
m4 <- lm(sqrt_house_val ~ income + age + pop + total_houses + dcoast + dla + dsd + dsj + dsf, 
         data = cal_1990)
summary(m4)
vif(m4)

# --- Model Selection Techniques ---
# Backward selection
step(m4, direction = "backward")

# Forward selection
Base <- lm(sqrt_house_val ~ 1, data = cal_1990)
step(Base, scope = list(upper = m4, lower = ~1), direction = "forward")

# --- Model Diagnostics ---
plot(fitted(m4), rstandard(m4), main = "Predicted vs. Residuals Plot")
abline(a = 0, b = 0, col = 'red')

qqnorm(rstandard(m4))
qqline(rstandard(m4), col = 2)

# --- Feature Importance ---
lm.beta(m4)

# --- Visualize Key Relationships ---
plot(dcoast, house_val, main = "Distance to Coast vs. House Value")
plot(income, house_val, main = "Income vs. House Value")

