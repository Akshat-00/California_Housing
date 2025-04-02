# California Housing Price Analysis (1990)

This project analyzes housing data from California in 1990 to estimate median house prices based on several socio-economic and geographic factors.

## 📊 Project Goals
- Understand how different variables (income, population, proximity to cities, etc.) affect house prices.
- Build multiple linear regression models with and without variable transformations.
- Perform correlation analysis and assess multicollinearity using VIF.
- Apply stepwise model selection to identify the most impactful predictors.

## 🛠️ Tools Used
- R
- Excel (for initial data preprocessing)

## 🚀 How to Run
1. Clone this repo.
2. Place your dataset in a local folder.
3. Update the file path in `scripts/Cal_House_1990.R`.
4. Run the script in R or RStudio.

## 📌 Note
The dataset is **not included** in this repository. Please use your own local copy of the Excel file if replicating this project.

## 🗂️ Dataset Source
The dataset used for this analysis is available on Kaggle: 
[California Housing Prices (1990 Census)](https://www.kaggle.com/datasets/harrywang/housing?select=housing.csv)

## 📈 Key Takeaways
- Income and proximity to the coast are major factors influencing house prices.
- Transforming the target variable helps improve model assumptions and interpretability.
- Stepwise selection is helpful in refining multivariate models.

---
