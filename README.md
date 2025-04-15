## Overview

This project is an end-to-end data pipeline that processes online retail transactions, loads them into a data warehouse, and visualizes insights through a dashboard. The pipeline is automated using Airflow and deployed in Google Cloud Platform (GCP).

![image](https://github.com/user-attachments/assets/f27576d0-2ef5-44ce-bfbf-36f99fb7e3b5)


## Technologies Used

**Data Lake**: Google Cloud Storage (GCS)

**Cloud platform (Service Account/IAM, Storage)**: Google Cloud Platform (GCP)

**Infrastructure as code (IaC)**: Terraform

**Batch processing**: Python/Pandas

**Data warehouse**: Google Big Query

**Data transformation**: dbt

**Data visualization**: Google Looker Studio

**CI/CD**: GitHub Actions


## DATA EXTRACTION

Extract the CSV and convert it into a DataFrame.

```bash
import pandas as pd
file_path = "/Users/tomilolaadeyinka/Retail Data Pipeline/online_retail.csv"
df = pd.read_csv(file_path)
```

## DATA TRANSFORMATION

**Check for missing values in each column**

```bash 
df.isnull().sum()
```

**Fill missing values in Description with 'No Description'**

```bash
df['Description'] = df ['Description'].fillna('No Description')
```

**Fill missing CustomerID with 0 (or you can drop rows if necessary)**

```bash
df['CustomerID'] = df['CustomerID'].fillna(0)
```

**Convert InvoiceDate to datetime format**

```bash
df['InvoiceDate'] = pd.to_datetime(df['InvoiceDate'])
```

**Remove duplicate rows based on all columns**

```bash
df_cleaned = df.drop_duplicates()
```

**Ensure CustomerID is an integer**

```bash
df['CustomerID'] = df['CustomerID'].astype(int)
```

**InvoiceNumber Validation: Check for any invalid invoice numbers (e.g., negative numbers).**

```bash
df = df[df['InvoiceNo'].apply(lambda x: x.isnumeric())]
```

**Quantity Validation: Ensure that Quantity values are valid (non-negative).**

```bash
df = df[df['Quantity'] >= 0]
```

**UnitPrice Validation: Ensure UnitPrice is non-negative.**

```bash
df = df[df['UnitPrice'] >= 0]
```
```bash
df_cleaned.info()
```
```bash
df_cleaned = df
```

## DATA LOADING

To load the cleaned data up 

```bash
import pandas as pd
```

**Reload the cleaned data from the saved CSV file**

```bash
df_cleaned = pd.read_csv('cleaned_data.csv')
```

**Check the first few rows to verify**

```bash
print(df_cleaned.head())
```
```bash
Install pandas-gbq package
```
```bash
!pip install pandas-gbq
```
```bash
Install google-cloud-bigquery
```
```bash
!pip install google-cloud-bigquery
```
```bash
from google.cloud import bigquery
```

**Setting the Environment Variable in Jupyter Notebook**

You can set the environment variable directly in the notebook before running any code that interacts with Google Cloud

```bash
import os
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "/Users/tomilolaadeyinka/Downloads/retail-data-pipeline-454921-f0b5600c14e2.json"
```
```bash
from google.cloud import bigquery
```

**Importing the required library**
```bash
from pandas_gbq import to_gbq
```
**DataFrame is named df_cleaned**
```bash
to_gbq(df_cleaned, destination_table='retail_dataset.retail_data', project_id='retail-data-pipeline-454921', if_exists='replace')
```

**Unit Tests for Python Code and BigQuery data loading:**
```bash
import unittest

class TestDataCleaning(unittest.TestCase):
    def test_data_cleaning(self):
        # Assuming you have a cleaned DataFrame (df_cleaned)
        self.assertEqual(df_cleaned.isnull().sum().sum(), 0)  # Ensure no missing values

#Manually running the test
test_suite = unittest.TestLoader().loadTestsFromTestCase(TestDataCleaning)
unittest.TextTestRunner().run(test_suite)
```

The test ran successfully, and everything passed without any issues. The message Ran 1 test in 0.123s OK indicates that the data cleaning function worked as expected.

**Terraform**

```bash
brew install terraform
```
```bash
Nano main.tf
```
```bash
mkdir -p ~/projects/retail-data-pipeline/terraform
```
```bash
mv /Users/tomilolaadeyinka/Downloads/retail-data-pipeline-454921-f0b5600c14e2.json ~/projects/retail-data-pipeline/terraform/
```
```bash
export GOOGLE_APPLICATION_CREDENTIALS="$HOME/projects/retail-data-pipeline/terraform/retail-data-pipeline-454921-f0b5600c14e2.json"
```
```bash
echo 'export GOOGLE_APPLICATION_CREDENTIALS="$HOME/projects/retail-data-pipeline/terraform/retail-data-pipeline-454921-f0b5600c14e2.json"' >> ~/.zshrc
```
```bash
terraform init
```
```bash
terraform plan
```
```bash
terraform validate
```
```bash
terraform apply
```

## Query the Data in BigQuery

Overview of the dataset

```bash
SELECT * FROM `retail-data-pipeline-454921.retail_dataset.retail_data` LIMIT 10;
```

Aggregating data

```bash
SELECT COUNT(*) FROM `retail-data-pipeline-454921.retail_dataset.retail_data`;
```
**Top 10 Most Sold Products:**
The bar chart below shows which items sold the most by total quantity.

![image](https://github.com/user-attachments/assets/72313248-6f93-4474-a4e3-6a5d274792ea)


**Monthly Sales Trend:**
The line chart below shows how total quantity sold changed over time month by month.

![image](https://github.com/user-attachments/assets/889646ea-ac9f-4cf7-857a-490d009969c7)





















