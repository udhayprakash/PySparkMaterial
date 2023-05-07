from pyspark.sql import SparkSession

# create SparkSession
spark = SparkSession.builder \
    .appName("PySpark Example") \
    .getOrCreate()

# read input data
df = spark.read.format("csv").option("header", "true").load("data/input/file.csv")

# perform some transformations
df2 = df.groupBy("name").sum("count")

# write output data
df2.write.format("csv").mode("overwrite").save("data/output/output.csv")
