%�����ݼ�����Ϊѵ��������Լ�
function[X_train,Y_train,X_test,Y_test]=Q3_step3(X,Y,T)  %T=280
%     X=[1,2;3,4;5,6;7,8];Y=[60;70;80;90];T=0.8;
    %ѵ������
    len = size(X,1);
    X_train = X(1:T,:);
    Y_train = Y(1:T,:);
    %��������
    X_test = X(T+1:len,:);
    Y_test = Y(T+1:len,:);
end