function[result]=PCR(X_train,Y_train,X_test,Y_test,k)
%% IV. 主成分分析
% 1. 第一主成分vs.第二主成分
figure
[PCALoadings,PCAScores,PCAVar] = princomp(X_train);
plot(PCAScores(:,1),PCAScores(:,2),'r+')
hold on
[PCALoadings_test,PCAScores_test,PCAVar_test] = princomp(X_test);
plot(PCAScores_test(:,1),PCAScores_test(:,2),'o')
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
legend('Training Set','Testing Set','location','best')
figure
percent_explained = 100 * PCAVar / sum(PCAVar);
pareto(percent_explained)
xlabel('主成分')
ylabel('贡献率(%)')
title('主成分贡献率')
%% V. 主成分回归模型
% 1. 创建模型
betaPCR = regress(Y_train-mean(Y_train),PCAScores(:,1:k));
betaPCR = PCALoadings(:,1:k) * betaPCR;
betaPCR = [mean(Y_train)-mean(X_train) * betaPCR;betaPCR];
% 2. 预测拟合
N = size(X_test,1);
T_sim = [ones(N,1) X_test] * betaPCR;
 
%% VI. 结果分析与绘图
% 1. 相对误差error
error = abs(T_sim - Y_test) ./ Y_test;
% 2. 决定系数R^2
R2 = (N * sum(T_sim .* Y_test) - sum(T_sim) * sum(Y_test))^2 / ((N * sum((T_sim).^2) - (sum(T_sim))^2) * (N * sum((Y_test).^2) - (sum(Y_test))^2)); 
% 3. 结果对比
result = [Y_test T_sim error];
% 4. 绘图
figure
plot(1:N,Y_test,'b:*',1:N,T_sim,'r-o')
legend('真实值','预测值','location','best')
xlabel('预测样本')
ylabel('辛烷值')
string = {'测试集辛烷值含量预测结果对比';['R^2=' num2str(R2)]};
title(string)
