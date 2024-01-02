import random as rd 
from datetime import datetime
import pandas as pd 

rd.seed(datetime.now())

n = 200

genData = pd.read_excel("preferences.xlsx")

lst = [rd.randint(40, 240), rd.randint(0, 14), rd.randint(0, 14),
     rd.randint(), rd.randint()]

genData.append(lst)

genData.to_excel("preferences.xlsx")

# genData.append([])
# 240	0	14	14	14	30	7	2	-2
# print(genData)
