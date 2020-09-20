file='����һ��325����������.xlsx';
file2='��������285�ź�313������ԭʼ����.xlsx';
file3='�����ģ�354������������Ϣ.xlsx';

%��ȡ����һ325������
[data_354]=xlsread(file,'Q4:NF328');    %����һ354����������
[raw_7]=xlsread(file,'C4:I328');        %����һԭ����7������
[Daishen_2]=xlsread(file,'M4:N328');    %����һ�����߻���2������
[Zaishen_2]=xlsread(file,'O4:P328');    %����һ�����߻���2������
[product_2]=xlsread(file,'J4:K328');    %����һ��Ʒ2������
[RON_Loss]=xlsread(file,'L4:L328');     %�����

%��ȡ������No285��No313������
[dataNo285]=xlsread(file2,'��������','B4:MQ43');    
[dataNo313]=xlsread(file2,'��������','B45:MQ84');

%��ȡ������ 354����������ȡֵ��Χ�Լ�deltaֵ
[~,fanwei]=xlsread(file3,'D2:D355');
[stepLen]=xlsread(file3,'F2:F355');

%��һ�� ��No285��No313�������Լ�325����������Ԥ����
dataNo313_1=Q1_step4(data_354,dataNo313); %���ݾ����ܽ�����������ķ�Χ�����޳�һ������������
dataNo313_2=Q1_step3(dataNo313_1);  %��3sigma�����쳣ֵ��NaN
dataNo313_3=Q1_step1(dataNo313_2,0.5);  %���ڲ�������Ϊ��ֵ�ĵ�ʹ��ƽ��ֵ���棬�����������������
Vec_dataNo313=mean(dataNo313_3);  %������ƽ��ֵ
dataNo285_1=Q1_step4(data_354,dataNo285); %���ݾ����ܽ�����������ķ�Χ�����޳�һ������������
dataNo285_2=Q1_step3(dataNo285_1);  %��3sigma�����쳣ֵ��NaN
dataNo285_3=Q1_step1(dataNo285_2,0.5);  %���ڲ�������Ϊ��ֵ�ĵ�ʹ��ƽ��ֵ���棬�����������������
Vec_dataNo285=mean(dataNo285);  %������ƽ��ֵ
data_354(313,:)=Vec_dataNo313;
data_354(285,:)=Vec_dataNo285;
data_354_2=Q1_step1(data_354,0.5);    %���ڲ�������Ϊ��ֵ�ĵ�ʹ��ƽ��ֵ���棬�����������������
data_354_raw=data_354_2;  %����ԭʼ����

%�ڶ��� �������ɷַ����ͻ���Ϣֵ������н�ά
% [data_all]=[raw_7,product_2,Daishen_2,Zaishen_2,data_354_raw];  %�õ����б�������������
[data_all]=[raw_7,Daishen_2,Zaishen_2,data_354_raw];  %�õ����б�������������
S=[1,2,3,4,5,6,7];  %ȷ���˹�ѡȡ�ı���
% S=[1,2,4,5,6,7,9,13,14,15,17,20,21,23,24,26,27,28,29,30,31,41,47,53,61,67,68,73,75,76];  %ȷ���˹�ѡȡ�ı���
[data_vip,data_nor]=Q2_step1(data_all,S);   %ɸѡ���˹�ȷ���ı�������������
% T=0.9;  %PCA����İ�����Ϣ��
% [data_new]=Q2_step2(data_nor,T);     %����PCA���ɷַ����õ��µı��������� ��ѡ
NUM=23;  %��Ҫ��ȡ�Ĳ�����������
[idx,MI]=mutInfFS(data_nor,RON_Loss,NUM);  %idxΪ�õ�����������MIΪ���Ӧ����Ϣֵ
data_new=[data_vip,data_nor(:,idx)];       %�õ��µı��������� Ҫ��size(data_new,2)<30
data_new_raw=data_new;  %����ԭʼ����

%������ ͨ����Ԫ���Իع�����߻ع�������Ԥ��ģ��
% NUM=280;  %�������ֵ�ѵ��������
% [X_train,Y_train,X_test,Y_test] = Q3_step2(data_new,RON_Loss,NUM);  %�����ݼ�����Ϊѵ��������Լ�
% [b,Y_result]=Q3_step1(X_train,Y_train,X_test);  %ʹ��ѵ�������ж�Ԫ���Իع飬�����ع�ϵ��b��Ԥ����
% ae_LR = sum(abs(Y_result-Y_test))/size(Y_test,1) ;     %����ƽ�����
% rr_LR = sum(abs(Y_result-Y_test)<=0.1)/size(Y_test,1) ;    %�������ֵ�ڡ�0.1��ռ��    
% x = 1:1:size(Y_test,1);
% plot(x,Y_result,'-bo',x,Y_test,'-r*');      % ��ͼ�۲�Ԥ��ֵ��ʵ��ֵ�ֲ����
    
NUM=280;  %�������ֵ�ѵ��������
test_runtimes=1;    %���߻ع������д���
ae = 0;rr = 0;
for i=1:test_runtimes
    [X_train,Y_train,X_test,Y_test] = Q3_step2(data_new,RON_Loss,NUM);  %�����ݼ�����Ϊѵ��������Լ�
    rtree = fitrtree(X_train,Y_train,'minleaf',2); % ���ɾ��������ع���
    rptree = prune(rtree,'Level',1);  %��������֦
%     view(rptree,'Mode','graph')  % �鿴������
%     resuberror = resubLoss(rptree);   %�����������˴�����������ʧ����
%     lossOpt = kfoldLoss(crossval(rptree));  %������֤���
    Y_sty = predict(rptree,X_test);   %ʹ���������ݽ���Ԥ��
    ae = ae+sum(abs(Y_sty-Y_test))/size(Y_test,1) ;     %����ƽ�����
    rr = rr+sum(abs(Y_sty-Y_test)<=0.1)/size(Y_test,1) ;    %�������ֵ�ڡ�0.1��ռ��    
    x = 1:1:size(Y_test,1);
    plot(x,Y_sty,'-bo',x,Y_test,'-r*');      % ��ͼ�۲�Ԥ��ֵ��ʵ��ֵ�ֲ����
end
mae = ae / test_runtimes ;
mrr = rr / test_runtimes ;

% ������
range_354=Q4_step1(fanwei); %354����������ȡֵ��Χ
range_Sul=[0,5];  %���϶�����������    ������Ҫ�ģ�ͣ�����ʱ�䲻�㣬�˴�����
RON_Loss_ev=mean(RON_Loss);
Edge_low=range_354(idx,1);
Edge_high=range_354(idx,2);

% Edge_low=[(0.2 .* mean([raw_7 Daishen_2 Zaishen_2])');range_354(idx,1)];  %����ȡֵ��Χ�Ͷ�
% Edge_high=[(1.8 .* mean([raw_7 Daishen_2 Zaishen_2])');range_354(idx,2)];   %����ȡֵ��Χ�߶�
% [x_val,fval,exitflag,output,lambda]=linprog(b(2:end),[],[],[],[],Edge_low,Edge_high);    %���Թ滮
% minRON_Loss=sum(b .* [1;x_val]);

% 9����Ʒ����
x = [248, 89.7, 20.6, 23.5, 50.11, 727.8, 88.3, 1.53, 7.25];
% 21��������������Ӧ�����15 - 76��21������
y = [0.3111, 2.4768, 418.7897, 2.363, 10.7732, 237.651, 2.3748, 0, 4.7623, 0.6600, 126.0056, 54.9900, 789.3278, 0.9926, 426.7278, 49.8122, 8943.7576, 187.1445, 366.3277, -0.1526, 1.9900];
% 21��������������Χ�Ͳ���ȡֵ
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






