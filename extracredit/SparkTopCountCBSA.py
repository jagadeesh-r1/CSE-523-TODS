import sys
from pyspark.sql import SparkSession, functions


def create_spark_session():
    return SparkSession.builder.appName("SparkTopCountCBSA").getOrCreate() # Create a SparkSession

def load_data(spark, data_path):
    df = spark.read.csv(data_path, header=True, inferSchema=True)
    return df.filter(df.CBSA2010 != -9) # Filter out rows with missing CBSA2010 values

def get_total_admissions_per_cbsa(df):
    return df.groupBy("CBSA2010").agg(functions.count("*").alias("TotalAdmissions")) # Group by CBSA2010 and count the number of admissions

def get_top_5_cbsas(total_admissions_per_cbsa):
    top_5_cbsas = total_admissions_per_cbsa.sort(functions.col("TotalAdmissions").desc()).limit(5) # Sort by TotalAdmissions in descending order and get the top 5
    return [row.CBSA2010 for row in top_5_cbsas.collect()]

def get_yearly_admissions(df, top_5_cbsa_list):
    return df.filter(df.CBSA2010.isin(top_5_cbsa_list)).groupBy("CBSA2010", "ADMYR").agg(functions.count("*").alias("YearlyAdmissions")) # Filter out rows with CBSA2010 not in the top 5 list, group by CBSA2010 and ADMYR, and count the number of admissions

def get_lowest_admissions_year(yearly_admissions):
    lowest_admissions_year = yearly_admissions.groupBy("CBSA2010").min("YearlyAdmissions").withColumnRenamed("min(YearlyAdmissions)", "MinYearlyAdmissions") # Group by CBSA2010 and get the minimum YearlyAdmissions
    return lowest_admissions_year.join(yearly_admissions, ["CBSA2010"]).filter(functions.col("YearlyAdmissions") == functions.col("MinYearlyAdmissions")) # Join with the original dataframe and filter out rows with YearlyAdmissions not equal to MinYearlyAdmissions

def main(data_path):
    spark = create_spark_session()
    df = load_data(spark, data_path)
    total_admissions_per_cbsa = get_total_admissions_per_cbsa(df)
    top_5_cbsa_list = get_top_5_cbsas(total_admissions_per_cbsa)
    yearly_admissions = get_yearly_admissions(df, top_5_cbsa_list)
    lowest_admissions_year = get_lowest_admissions_year(yearly_admissions)
    lowest_admissions_year.select("CBSA2010", "ADMYR", "Yearly_Admissions").show() # Print the result
    spark.stop()

if __name__ == "__main__":
    data_path = sys.argv[1]
    main(data_path)