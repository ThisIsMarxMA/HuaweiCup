file='C:\2020年中国研究生数学建模竞赛赛题\2020年B题\2020年B题--汽油辛烷值建模\数模题\附件一：325个样本数据.xlsx';
file2='C:\2020年中国研究生数学建模竞赛赛题\2020年B题\2020年B题--汽油辛烷值建模\数模题\附件三：285号和313号样本原始数据.xlsx';
file3='C:\2020年中国研究生数学建模竞赛赛题\2020年B题\2020年B题--汽油辛烷值建模\数模题\附件四：354个操作变量信息.xlsx';
% [data_354]=xlsread(file,'Q4:NF328');
% [raw_7]=xlsread(file,'C4:I328');
% [Daishen_2]=xlsread(file,'M4:N328');
% [Zaishen_2]=xlsread(file,'O4:P328');
% [product_2]=xlsread(file,'J4:K328');
% [RON_Loss]=xlsread(file,'L4:L328');

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
