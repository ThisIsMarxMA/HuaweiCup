from sklearn.tree import DecisionTreeRegressor
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
N = 280
datafile = './325data-sample.xlsx'
data = pd.read_excel(datafile)
data_fea1 = data.iloc[:N, 1:]
data_fea2 = data.iloc[N:, 1:]

model = DecisionTreeRegressor(max_depth=2, max_leaf_nodes=5)
model.fit(data_fea1, data.y[:N])
a = np.abs(data.y[N:] - model.predict(data_fea2))
count = 0
for i in a:
    if i <= 0.2:
        count += 1
print(count/len(data.y[N:]))