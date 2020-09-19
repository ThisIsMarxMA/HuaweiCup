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
% [rawNo285]=xlsread(file2,'原料','D2:J2');
% [rawNo313]=xlsread(file2,'原料','D3:J3');
% [DaishenNo285]=xlsread(file2,'待生吸附剂','D3:E3');
% [DaishenNo313]=xlsread(file2,'待生吸附剂','D4:E4');
% [ZaishenNo285]=xlsread(file2,'再生吸附剂','D3:E3');
% [ZaishenNo313]=xlsread(file2,'再生吸附剂','D4:E4');
% [productNo285]=xlsread(file2,'产品','D3:E3');
% [productNo313]=xlsread(file2,'产品','D4:E4');

%读取附件三 354个操作变量取值范围
[~,fanwei]=xlsread(file3,'D2:D355');

%第一问 对No285，No313号样本以及325个样本进行预处理
dataNo313=Q1_step4(data_354,dataNo313); %根据经验总结出操作变量的范围，并剔除一部分样本数据
dataNo313=Q1_step3(dataNo313);  %按3sigma法则，异常值置NaN
dataNo313=Q1_step1(dataNo313,0.5);  %对于部分数据为空值的点使用平均值代替，如果过半则舍弃该列
Vec_dataNo313=mean(dataNo313);  %附件三平均值
dataNo285=Q1_step4(data_354,dataNo285); %根据经验总结出操作变量的范围，并剔除一部分样本数据
dataNo285=Q1_step3(dataNo285);  %按3sigma法则，异常值置NaN
dataNo285=Q1_step1(dataNo285,0.5);  %对于部分数据为空值的点使用平均值代替，如果过半则舍弃该列
Vec_dataNo285=mean(dataNo285);  %附件三平均值
data_354(313,:)=Vec_dataNo313;
data_354(285,:)=Vec_dataNo285;
data_354_raw=data_354;  %保存原始数据

%第二问 利用主成分分析和互信息值计算进行降维
[data_all]=[raw_7,Daishen_2,Zaishen_2,product_2,data_354];  %得到所有变量的样本数据
S=[1,2,4,7,9];  %确定人工选取的变量
[data_vip,data_nor]=Q2_step1(data_all,S);   %筛选出人工确定的变量与其他变量
% T=0.9;  %PCA处理的包含信息量
% [data_new]=Q2_step2(data_nor,T);     %进行PCA主成分分析得到新的变量的数据 备选
NUM=30;  %需要提取的操作变量个数
[idx,MI]=mutInfFS(data_nor,RON_Loss,NUM);  %idx为得到的特征排序，MI为其对应的信息值
data_new=[data_vip,data_nor(:,idx)];       %得到新的变量的数据 要求size(data_new,2)<30
data_new_raw=data_new;  %保存原始数据

%第三问 通过多元线性回归与决策回归树建立预测模型
NUM=280;  %样本划分的训练集个数
[X_train,Y_train,X_test,Y_test] = Q3_step2(data_new,RON_Loss,NUM);  %将数据集划分为训练集与测试集
[b,Y_result]=Q3_step1(X_train,Y_train,X_test);  %使用训练集进行多元线性回归，给出回归系数b与预测结果

%第四问
range=Q4_step1(fanwei); %354个操作变量取值范围
range=[range;0,5];  %加上对硫含量的限制
[x,fval,exitflag,output,lambda]=linprog(b(2:end),[],[],[],[],range(:,1),range(:,2));%线性规划
minRON_Loss=sum(b .* [1,x]');







