# MySQL Database connection

import pandas as pd
from sqlalchemy import create_engine

data = pd.read_csv(r"D:/Data/ethnic diversity.csv")

# Creating engine which connect to MySQL
user = 'user1' # user name
pw = 'user1' # password
db = 'education_db' # database

# creating engine to connect database
engine = create_engine(f"mysql+pymysql://{user}:{pw}@localhost/{db}")

# dumping data into database 
data.to_sql('education', con = engine, if_exists = 'replace', chunksize = 500, index = False)

# loading data from database
sql = 'select * from education'

edu = pd.read_sql_query(sql, con = engine)

print(edu)
