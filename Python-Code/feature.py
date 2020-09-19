from sklearn.feature_selection import VarianceThreshold
import pandas as pd
import numpy as np
import xlrd

''' 读取excel '''
# xlsx_325sample = pd.read_excel('./325data-sample.xlsx')
xlsx_325sample = xlrd.open_workbook('./325data-sample.xlsx')
table = xlsx_325sample.sheets()[0]
# nrows = table.nrows #行数
# ncols = table.ncols #列数

start_row = 4 - 1  # 开始行数
end_row = table.nrows  # 结束行数328
start_col = 3 - 1  # 开始列数
end_col = table.ncols  # 结束列数370
# 将数据写入矩阵
data_list = []
for r in range(start_row, end_row):
    data_row = []
    row = table.row_values(r)
    for c in range(start_col, end_col):
        data_row.append(row[c])
    data_list.append(data_row)
print('原始变量数:')
print(len(data_list[0]))

''' 移除低方差变量 '''
sel = VarianceThreshold(threshold=(.8 * (1 - .8)))
remove_lovariance_list = sel.fit_transform(data_list)
print('移除低方差后变量数:')
print(len(remove_lovariance_list[0]))

''' 高相关滤波 '''
k = 0.8  # 配置参数
def data_corr_analysis(data, sigmod=k):
    '''相关性分析：返回出原始数据的相关性矩阵以及根据阈值筛选之后的相关性较高的变量'''
    corr_data = data.corr()
    for i in range(len(corr_data)):
        for j in range(len(corr_data)):
            if j == i:
                corr_data.iloc[i, j] = 0

    x, y, corr_xishu = [], [], []
    for i in list(corr_data.index):
        for j in list(corr_data.columns):
            if abs(corr_data.loc[i, j]) > sigmod:
                x.append(i)
                y.append(j)
                corr_xishu.append(corr_data.loc[i, j])
    z = [[x[i], y[i], corr_xishu[i]] for i in range(len(x))]
    high_corr = pd.DataFrame(z, columns=['VAR1', 'VAR2', 'CORR_XISHU'])
    return high_corr

arr1 = pd.DataFrame(np.array(remove_lovariance_list))
# print(len(data_corr_analysis(arr1)))
data_corr_analysis(arr1).to_excel('相关系数表.xlsx')