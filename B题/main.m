clc;clear all;
file='C:\2020���й��о�����ѧ��ģ��������\2020��B��\2020��B��--��������ֵ��ģ\��ģ��\����һ��325����������.xlsx';
file2='C:\2020���й��о�����ѧ��ģ��������\2020��B��\2020��B��--��������ֵ��ģ\��ģ��\��������285�ź�313������ԭʼ����.xlsx';
file3='C:\2020���й��о�����ѧ��ģ��������\2020��B��\2020��B��--��������ֵ��ģ\��ģ��\�����ģ�354������������Ϣ.xlsx';
[data_354]=xlsread(file,'Q4:NF328');
% [raw_7]=xlsread(file,'C4:I328');
% [Daishen_2]=xlsread(file,'M4:N328');
% [Zaishen_2]=xlsread(file,'O4:P328');
% [product_2]=xlsread(file,'J4:K328');
[RON_Loss]=xlsread(file,'L4:L328');

%No285��No313������
[dataNo285]=xlsread(file2,'��������','B4:MQ43');
[dataNo313]=xlsread(file2,'��������','B45:MQ84');
% [rawNo285]=xlsread(file2,'ԭ��','D2:J2');
% [rawNo313]=xlsread(file2,'ԭ��','D3:J3');
% [DaishenNo285]=xlsread(file2,'����������','D3:E3');
% [DaishenNo313]=xlsread(file2,'����������','D4:E4');
% [ZaishenNo285]=xlsread(file2,'����������','D3:E3');
% [ZaishenNo313]=xlsread(file2,'����������','D4:E4');
% [productNo285]=xlsread(file2,'��Ʒ','D3:E3');
% [productNo313]=xlsread(file2,'��Ʒ','D4:E4');

%354����������ȡֵ��Χ
[~,range]=xlsread(file3,'D2:D355');

%����������
% dataNo313=Q1_step3(dataNo313);  %��3sigma�����쳣ֵ��NaN
% dataNo313=Q1_step1(dataNo313,0.7);  %��40*0.7ִ�е�һ��
% Vec_dataNo313=mean(dataNo313);  %������ƽ��ֵ
% 
% dataNo285=Q1_step3(dataNo285);  %��3sigma�����쳣ֵ��NaN
% dataNo285=Q1_step1(dataNo285,0.7);  %��40*0.7ִ�е�һ��
% Vec_dataNo285=mean(dataNo285);  %������ƽ��ֵ
% 
% data_354_2=data_354;    %ԭʼ����
% data_354(313,:)=Vec_dataNo313;
% data_354(285,:)=Vec_dataNo285;
% data_354_3=data_354;    %���������������

%�Ը���һ����
% [d,data_354]=Q1_step2(data_354,range);  %��������Χ�ÿ�
% data_354=Q1_step3(data_354);    %��3sigma�����쳣ֵ�ÿ� 











