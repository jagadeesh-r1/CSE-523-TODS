from pyspark.sql import SparkSession
from pyspark.sql.functions import col
from pyspark.sql.types import IntegerType


def store_result(output_file_path, row_list):
    with open(output_file_path, "w") as file:
        for row in row_list:
            row_str = "\t".join([str(cell) for cell in row])
            file.write(row_str + "\n")

def data_processing(dataframe):
    
    dataframe = dataframe.withColumn("AGE", col("AGE").cast(IntegerType())) # Cast the 'Age' column to Integer
    dataframe = dataframe.withColumn("ADMYR", col("ADMYR").cast(IntegerType())) # Cast the 'Year' column to Integer

    groupBy_result = dataframe.groupBy("AGE", "ADMYR").count().orderBy("AGE", "ADMYR") # Group by 'Age' and 'Year' and count the number of admissions

    final_result = groupBy_result.withColumnRenamed("count", "count_of_admissions") # Rename the 'count' column

    return final_result

if __name__ == "__main__":
    spark_app = SparkSession.builder.appName("AgeYearAdmissionCount").getOrCreate()

    file_path = "C:\Users\jagad\Downloads\TEDS-A-2000-2019-DS0001-bndl-data-csv_v1\tedsa_puf_2000_2019.csv"
    dataframe = spark.read.csv(file_path, header=True, inferSchema=True)

    final_result = data_processing(dataframe)

    output_file_path = "C:\Users\jagad\todb\hw4\3_output.txt"
    row_list = final_result.collect()

    store_result(output_file_path, row_list)

    spark_app.stop()
