function[b,Y_result]=Q3_step1(data_train,Y_train,data_test)
    [n,dim]=size(data_train);
    [Yn,Ydim]=size(Y_train);
    X_train=[ones(Yn,1),data_train];

    %（1）b=regress(Y,X) 确定回归系数的点估计值
    %其中，Y为n*1的矩阵；X为（ones(n,1),x1,…,xm）的矩阵；
    %（2）[b,bint,r,rint,stats]=regress(Y,X,alpha) 求回归系数的点估计和区间估计，并检验回归模型
    %b 回归系数 bint 回归系数的区间估计 r 残差 rint 残差置信区间
    %stats 用于检验回归模型的统计量，有四个数值：相关系数R2、F值、与F对应的概率p，误差方差。
    %相关系数R2越接近1，说明回归方程越显著；F > F1-α（k，n-k-1）时拒绝H0，F越大，说明回归方程越显著；
    %与F对应的概率p时拒绝H0，回归模型成立。p值在0.01-0.05之间，越小越好

    %现在要做的是多元线性回归
    [b,bint,r,rint,stats]=regress(Y_train,X_train);
    %b1为多元回归方程系数
    %画残差图
    rcoplot(r,rint);
    %预测及作图
    for i=1:size(data_test,1)
        Y_result(i,1)=sum(b .* [1,data_test(i,:)]');
    end

%     %相关性分析
%     [rho,pval]=corr(data_train,Y_train,'type','Pearson');
%     [rho2,pval2]=corr(data_train,'type','Pearson');
end


