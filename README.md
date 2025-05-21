# GDP Growth Prediction with Linear Regression  
This project explores how historical GDP per capita and lagged GDP growth impact future GDP growth using BigQuery ML and Tableau for visualization.

---

## Summary  
I trained a linear regression model to predict GDP growth rates based on:

- Average GDP per capita by country and year  
- Lagged GDP growth from the previous year  

The dataset was cleaned to remove invalid GDP values, and growth rates were calculated year-over-year.

---

## Model Performance  
- Mean Absolute Error: 0.0404  
- Mean Squared Error: 0.0037  
- Mean Squared Log Error: 0.0038  
- Median Absolute Error: 0.0261  
- R Squared (R²): 0.0117  

The model shows modest predictive ability with low explained variance, indicating potential for improvement with additional features or modeling approaches.

---

## Tools  
- **Google BigQuery ML** – for data preprocessing, feature engineering, and training the linear regression model  
- **SQL** – for querying and manipulating the GDP dataset  
- **Tableau** – for creating an interactive map visualization of predicted GDP growth by country  
- **GitHub** – for version control and project collaboration  

---

## Key Insights  
- Lagged GDP growth is a relevant feature but the model explains only a small portion of GDP growth variance.  
- Predictions have a moderate average error (~4%), reflecting the complexity and noise in GDP growth data.    

---

## Files  
- `queries/` – SQL scripts for data cleaning, feature engineering, model training, and prediction  
- `dashboard/` – Tableau workbook and exported visualizations of predicted GDP growth  
- `notes/summary.md` – Documentation covering data preparation, model details, and interpretation  
