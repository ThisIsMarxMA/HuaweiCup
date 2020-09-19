%得到数据集并使用互信息对特征排序
[X_train,Y_train,X_test,Y_test] = Q3_step2(data,RON_Loss);
[n,dim]=size(X_train);
[ranking,MI]=mutInfFS(X_train,Y_train,dim);  %ranking为得到的特征排序，MI为其对应的信息值

%使用前30个特征进行多元线性回归
[b,Y_result]=Q3_step1(X_train(:,ranking(1:30)),Y_train,X_test);

%线性规划
range=Q1_step2(fanwei); %354个操作变量取值范围
range=[range;0,5];  %加上对硫含量的限制

[x,fval,exitflag,output,lambda]=linprog(b(2:end),[],[],[],[],range(:,1),range(:,2));
minRON_Loss=sum(b .* [1,x]');



