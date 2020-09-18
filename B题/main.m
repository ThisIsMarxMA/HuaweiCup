clc;clear all;
file='C:\2020年中国研究生数学建模竞赛赛题\2020年B题\2020年B题--汽油辛烷值建模\数模题\附件一：325个样本数据.xlsx';
file2='C:\2020年中国研究生数学建模竞赛赛题\2020年B题\2020年B题--汽油辛烷值建模\数模题\附件三：285号和313号样本原始数据.xlsx';
file3='C:\2020年中国研究生数学建模竞赛赛题\2020年B题\2020年B题--汽油辛烷值建模\数模题\附件四：354个操作变量信息.xlsx';
[data_354]=xlsread(file,'Q4:NF328');
% [raw_7]=xlsread(file,'C4:I328');
% [Daishen_2]=xlsread(file,'M4:N328');
% [Zaishen_2]=xlsread(file,'O4:P328');
% [product_2]=xlsread(file,'J4:K328');
[RON_Loss]=xlsread(file,'L4:L328');

%No285，No313号样本
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

%354个操作变量取值范围
[~,range]=xlsread(file3,'D2:D355');

%主函数部分
% dataNo313=Q1_step3(dataNo313);  %按3sigma法则，异常值置NaN
% dataNo313=Q1_step1(dataNo313,0.7);  %按40*0.7执行第一点
% Vec_dataNo313=mean(dataNo313);  %附件三平均值
% 
% dataNo285=Q1_step3(dataNo285);  %按3sigma法则，异常值置NaN
% dataNo285=Q1_step1(dataNo285,0.7);  %按40*0.7执行第一点
% Vec_dataNo285=mean(dataNo285);  %附件三平均值
% 
% data_354_2=data_354;    %原始数据
% data_354(313,:)=Vec_dataNo313;
% data_354(285,:)=Vec_dataNo285;
% data_354_3=data_354;    %附件三处理后数据

%对附件一处理
% [d,data_354]=Q1_step2(data_354,range);  %按变量范围置空
% data_354=Q1_step3(data_354);    %按3sigma法则，异常值置空 











