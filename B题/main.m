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

%��ȡ������ 354����������ȡֵ��Χ
[~,fanwei]=xlsread(file3,'D2:D355');

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
[data_all]=[raw_7,product_2,Daishen_2,Zaishen_2,data_354_raw];  %�õ����б�������������
S=[1,2,8,9];  %ȷ���˹�ѡȡ�ı���
% S=[1,2,4,5,6,7,9,13,14,15,17,20,21,23,24,26,27,28,29,30,31,41,47,53,61,67,68,73,75,76];  %ȷ���˹�ѡȡ�ı���
[data_vip,data_nor]=Q2_step1(data_all,S);   %ɸѡ���˹�ȷ���ı�������������
% T=0.9;  %PCA����İ�����Ϣ��
% [data_new]=Q2_step2(data_nor,T);     %����PCA���ɷַ����õ��µı��������� ��ѡ
NUM=30;  %��Ҫ��ȡ�Ĳ�����������
[idx,MI]=mutInfFS(data_nor,RON_Loss,NUM);  %idxΪ�õ�����������MIΪ���Ӧ����Ϣֵ
data_new=[data_vip,data_nor(:,idx)];       %�õ��µı��������� Ҫ��size(data_new,2)<30
data_new_raw=data_new;  %����ԭʼ����

%������ ͨ����Ԫ���Իع�����߻ع�������Ԥ��ģ��
NUM=280;  %�������ֵ�ѵ��������
[X_train,Y_train,X_test,Y_test] = Q3_step2(data_new,RON_Loss,NUM);  %�����ݼ�����Ϊѵ��������Լ�
[b,Y_result]=Q3_step1(X_train,Y_train,X_test);  %ʹ��ѵ�������ж�Ԫ���Իع飬�����ع�ϵ��b��Ԥ����

test_runtimes=1;    %���߻ع������д���
ae = 0;
rr = 0;
for i=1:test_runtimes
    [X_train,Y_train,X_test,Y_test] = Q3_step2(data_new,RON_Loss,NUM);  %�����ݼ�����Ϊѵ��������Լ�
    rtree = fitrtree(X_train,Y_train,'minleaf',2); % ���ɾ��������ع���
    rptree = prune(rtree,'Level',1);  %��������֦
%     view(rptree,'Mode','graph')  % �鿴������
%     resuberror = resubLoss(rptree);   %�����������˴�����������ʧ����
%     lossOpt = kfoldLoss(crossval(OptimalTree));  %������֤���
    Y_sty = predict(rtree,X_test);   %ʹ���������ݽ���Ԥ��
    ae = ae+sum(abs(Y_sty-Y_test))/size(Y_test,1) ;     %����������
    rr = rr+sum(abs(Y_sty-Y_test)<=0.1)/size(Y_test,1) ;    %�������ֵ�ڡ�0.1��ռ��    
    x = 1:1:size(Y_test,1);
    plot(x,Y_sty,'-bo',x,Y_test,'-r*');      % ��ͼ�۲�Ԥ��ֵ��ʵ��ֵ�ֲ����
end
mae = ae / test_runtimes ;
mrr = rr / test_runtimes ;

% %������
% range=Q4_step1(fanwei); %354����������ȡֵ��Χ
% range=[range;0,5];  %���϶�����������
% [x,fval,exitflag,output,lambda]=linprog(b(2:end),[],[],[],[],range(:,1),range(:,2));    %���Թ滮
% minRON_Loss=sum(b .* [1,x]');








