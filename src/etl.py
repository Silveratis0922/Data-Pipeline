from pyspark.sql import SparkSession


def create_spark_session():
    return SparkSession.builder \
        .appName("CVReader") \
        .getOrCreate()


def read_csv(spark, file_path):
    print(f"lecture du fichier: ", {file_path})

    df = spark.read \
        .option("header", "true") \
        .option("inferShema", "true") \
        .csv(file_path)

    print(f"Nombre de lignes :", {df.count()})
    print(f"Colonnes : {df.columns}")

    print("Apercu : \n")
    df.show(5)

    print("Types des colonnes : \n")
    df.printSchema()

    return df

def main():
    spark = create_spark_session()

    try:
        df = read_csv(spark, "data/raw/data_2022_nov.csv")
        print("Lecture reussie !")
    except Exception as e:
        print (f"{type(e).__name__} : {e}")

if __name__ == "__main__":
    main()