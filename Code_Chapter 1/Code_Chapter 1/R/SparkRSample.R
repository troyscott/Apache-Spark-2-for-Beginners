# SPARK_HOME settings and SparkR library path settings
# When you are running this script from your setup, please make sure that it is pointing to your SPARK_HOME directory
SPARK_HOME_DIR <- "/Users/RajT/source-code/spark-source/spark-2.0"
Sys.setenv(SPARK_HOME=SPARK_HOME_DIR)
.libPaths(c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib"), .libPaths()))
library(SparkR)
spark <- sparkR.session(master="local[*]")

# Sample Spark Program
path <- file.path(Sys.getenv("SPARK_HOME"), "examples/src/main/resources/people.json")
people <- read.json(path)
createOrReplaceTempView(people, "people")
teenagers <- sql("SELECT age, name FROM people WHERE age >= 13 AND age <= 19")
teenagersLocalDF <- collect(teenagers)
print(teenagersLocalDF)