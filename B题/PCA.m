clc
% clear all
A = xlsread('/Users/wanzhichong/Documents/MATLAB/HuaweiCup/325data-sample.xlsx', 'C4:NF328');

% 数据标准化处理
a = size(A, 1); % 列数
b = size(A, 2); % 行数
for i = 1:b
    SA(:,i) = (A(:,i) - mean(A(:,i)))/std(A(:,i));
end

% 计算相关系数矩阵的特征值和特征向量
CM = corrcoef(SA); % 计算相关系数矩阵
[V, D] = eig(CM); % 计算特征值和特征向量

for j = 1:b
    DS(j,1) = D(b+1-j, b+1-j); % 对特征值按降序进行排序
end
for i = 1:b
    DS(i,2)=DS(i,1)/sum(DS(:,1)); % 贡献率
    DS(i,3)=sum(DS(1:i,1))/sum(DS(:,1)); % 积累贡献率
end

% 选择主成分及对应的特征向量
T = 0.85; % 主成分信息保留率
for K=1:b
    if DS(K,3)>=T
        Com_num = K;
        break;
    end
end

% 提取主成分对应的特征向量
for j =1:Com_num
    PV(:,j) = V(:,b+1-j);
end

% 输出模型及结果展示
disp('特征值及其贡献率、累计贡献率：')
DS
disp('信息保留率T对应的主成分分数与特征向量：')
Com_num
PV



