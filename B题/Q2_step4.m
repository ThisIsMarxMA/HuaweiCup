%�õ����ݼ���ʹ�û���Ϣ����������
[X_train,Y_train,X_test,Y_test] = Q3_step2(data,RON_Loss);
[n,dim]=size(X_train);
[ranking,MI]=mutInfFS(X_train,Y_train,dim);  %rankingΪ�õ�����������MIΪ���Ӧ����Ϣֵ

%ʹ��ǰ30���������ж�Ԫ���Իع�
[b,Y_result]=Q3_step1(X_train(:,ranking(1:30)),Y_train,X_test);

%���Թ滮
range=Q1_step2(fanwei); %354����������ȡֵ��Χ
range=[range;0,5];  %���϶�����������

[x,fval,exitflag,output,lambda]=linprog(b(2:end),[],[],[],[],range(:,1),range(:,2));
minRON_Loss=sum(b .* [1,x]');



