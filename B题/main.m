file='附件一：325个样本数据.xlsx';
file2='附件三：285号和313号样本原始数据.xlsx';
file3='附件四：354个操作变量信息.xlsx';

%读取附件一325个样本
[data_354]=xlsread(file,'Q4:NF328');    %附件一354个操作变量
[raw_7]=xlsread(file,'C4:I328');        %附件一原材料7个属性
[Daishen_2]=xlsread(file,'M4:N328');    %附件一待生催化剂2个属性
[Zaishen_2]=xlsread(file,'O4:P328');    %附件一再生催化剂2个属性
[product_2]=xlsread(file,'J4:K328');    %附件一产品2个属性
[RON_Loss]=xlsread(file,'L4:L328');     %因变量

%读取附件二No285，No313号样本
[dataNo285]=xlsread(file2,'操作变量','B4:MQ43');    
[dataNo313]=xlsread(file2,'操作变量','B45:MQ84');

%读取附件三 354个操作变量取值范围以及delta值
[~,fanwei]=xlsread(file3,'D2:D355');
[stepLen]=xlsread(file3,'F2:F355');

%第一问 对No285，No313号样本以及325个样本进行预处理
dataNo313_1=Q1_step4(data_354,dataNo313); %根据经验总结出操作变量的范围，并剔除一部分样本数据
dataNo313_2=Q1_step3(dataNo313_1);  %按3sigma法则，异常值置NaN
dataNo313_3=Q1_step1(dataNo313_2,0.5);  %对于部分数据为空值的点使用平均值代替，如果过半则舍弃该列
Vec_dataNo313=mean(dataNo313_3);  %附件三平均值
dataNo285_1=Q1_step4(data_354,dataNo285); %根据经验总结出操作变量的范围，并剔除一部分样本数据
dataNo285_2=Q1_step3(dataNo285_1);  %按3sigma法则，异常值置NaN
dataNo285_3=Q1_step1(dataNo285_2,0.5);  %对于部分数据为空值的点使用平均值代替，如果过半则舍弃该列
Vec_dataNo285=mean(dataNo285);  %附件三平均值
data_354(313,:)=Vec_dataNo313;
data_354(285,:)=Vec_dataNo285;
data_354_2=Q1_step1(data_354,0.5);    %对于部分数据为空值的点使用平均值代替，如果过半则舍弃该列
data_354_raw=data_354_2;  %保存原始数据

%第二问 利用主成分分析和互信息值计算进行降维
% [data_all]=[raw_7,product_2,Daishen_2,Zaishen_2,data_354_raw];  %得到所有变量的样本数据
[data_all]=[raw_7,Daishen_2,Zaishen_2,data_354_raw];  %得到所有变量的样本数据
S=[1,2,3,4,5,6,7];  %确定人工选取的变量
% S=[1,2,4,5,6,7,9,13,14,15,17,20,21,23,24,26,27,28,29,30,31,41,47,53,61,67,68,73,75,76];  %确定人工选取的变量
[data_vip,data_nor]=Q2_step1(data_all,S);   %筛选出人工确定的变量与其他变量
% T=0.9;  %PCA处理的包含信息量
% [data_new]=Q2_step2(data_nor,T);     %进行PCA主成分分析得到新的变量的数据 备选
NUM=23;  %需要提取的操作变量个数
[idx,MI]=mutInfFS(data_nor,RON_Loss,NUM);  %idx为得到的特征排序，MI为其对应的信息值
data_new=[data_vip,data_nor(:,idx)];       %得到新的变量的数据 要求size(data_new,2)<30
data_new_raw=data_new;  %保存原始数据

%第三问 通过多元线性回归与决策回归树建立预测模型
% NUM=280;  %样本划分的训练集个数
% [X_train,Y_train,X_test,Y_test] = Q3_step2(data_new,RON_Loss,NUM);  %将数据集划分为训练集与测试集
% [b,Y_result]=Q3_step1(X_train,Y_train,X_test);  %使用训练集进行多元线性回归，给出回归系数b与预测结果
% ae_LR = sum(abs(Y_result-Y_test))/size(Y_test,1) ;     %计算平均误差
% rr_LR = sum(abs(Y_result-Y_test)<=0.1)/size(Y_test,1) ;    %计算误差值在±0.1的占比    
% x = 1:1:size(Y_test,1);
% plot(x,Y_result,'-bo',x,Y_test,'-r*');      % 画图观察预测值与实际值分布情况
    
NUM=280;  %样本划分的训练集个数
test_runtimes=1;    %决策回归树运行次数
ae = 0;rr = 0;
for i=1:test_runtimes
    [X_train,Y_train,X_test,Y_test] = Q3_step2(data_new,RON_Loss,NUM);  %将数据集划分为训练集与测试集
    rtree = fitrtree(X_train,Y_train,'minleaf',2); % 生成决策树：回归树
    rptree = prune(rtree,'Level',1);  %决策树剪枝
%     view(rptree,'Mode','graph')  % 查看决策树
%     resuberror = resubLoss(rptree);   %衡量分类误差，此处可以设置损失函数
%     lossOpt = kfoldLoss(crossval(rptree));  %交叉验证误差
    Y_sty = predict(rptree,X_test);   %使用样本数据进行预测
    ae = ae+sum(abs(Y_sty-Y_test))/size(Y_test,1) ;     %计算平均误差
    rr = rr+sum(abs(Y_sty-Y_test)<=0.1)/size(Y_test,1) ;    %计算误差值在±0.1的占比    
    x = 1:1:size(Y_test,1);
    plot(x,Y_sty,'-bo',x,Y_test,'-r*');      % 画图观察预测值与实际值分布情况
end
mae = ae / test_runtimes ;
mrr = rr / test_runtimes ;

% 第四问
range_354=Q4_step1(fanwei); %354个操作变量取值范围
range_Sul=[0,5];  %加上对硫含量的限制    硫含量需要搭建模型，由于时间不足，此处放弃
RON_Loss_ev=mean(RON_Loss);
Edge_low=range_354(idx,1);
Edge_high=range_354(idx,2);

% Edge_low=[(0.2 .* mean([raw_7 Daishen_2 Zaishen_2])');range_354(idx,1)];  %变量取值范围低端
% Edge_high=[(1.8 .* mean([raw_7 Daishen_2 Zaishen_2])');range_354(idx,2)];   %变量取值范围高端
% [x_val,fval,exitflag,output,lambda]=linprog(b(2:end),[],[],[],[],Edge_low,Edge_high);    %线性规划
% minRON_Loss=sum(b .* [1;x_val]);

% 9个产品变量
x = [248, 89.7, 20.6, 23.5, 50.11, 727.8, 88.3, 1.53, 7.25];
% 21个操作变量，对应下面点15 - 76，21个变量
y = [0.3111, 2.4768, 418.7897, 2.363, 10.7732, 237.651, 2.3748, 0, 4.7623, 0.6600, 126.0056, 54.9900, 789.3278, 0.9926, 426.7278, 49.8122, 8943.7576, 187.1445, 366.3277, -0.1526, 1.9900];
% 21个操作变量按范围和步长取值
var_15 = linspace(0.2, 0.37, (0.37-0.2) / 0.01);
var_17 = linspace(2.35, 2.7, (2.7-2.35) / 0.1);
var_20 = linspace(399, 430, (430-399) / 1);
var_21 = linspace(2.25, 2.55, (2.55-2.25) / 0.1);
var_23 = linspace(8, 1500, (1500-8) / 100);
var_24 = linspace(165, 250, (250-165) / 2);
var_26 = linspace(2.25, 2.55, (2.55-2.25) / 0.1);
var_27 = linspace(0, 350, (350-0) / 50);
var_28 = linspace(4.5, 5.85, (5.85-4.5) / 0.1);
var_29 = linspace(0.6, 0.7, (0.7-0.6) / 0.05);
var_30 = linspace(100, 150, (150-100) / 1);
var_31 = linspace(45, 60, (60-45) / 1);
var_41 = linspace(430, 1500, (1500-430) / 50);
var_47 = linspace(0.95, 1, (1-0.95) / 0.05);
var_53 = linspace(0, 900, (900-0) / 50);
var_61 = linspace(0, 75, (75-0) / 5);
var_67 = linspace(5500, 9000, (9000-5500) / 0.01);
var_68 = linspace(1.5, 650, (650-1.5) / 10);
var_73 = linspace(-0.2, 0, (0-0.2) / -0.05);
var_75 = linspace(400, 500, (500-400) / 1);
var_76 = linspace(400, 450, (450-400) / 1);






