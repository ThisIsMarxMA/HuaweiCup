%将数据集划分为训练集与测试集
function[X_train,Y_train,X_test,Y_test]=Q3_step2(X,Y,T)  %T=280
%     X=[1,2;3,4;5,6;7,8];Y=[60;70;80;90];T=0.8;
    %训练数据
    len = size(X,1);
    randidx = randsample(len,T,false) ;    %随机取样，不可重复
    X_train = X(randidx,:);
    Y_train = Y(randidx,:);
    %测试数据
    randidx2=[];
    for i=1:len
        if ~sum(i==randidx)
            randidx2=[randidx2,i];
        end
        X_test = X(randidx2,:);
        Y_test = Y(randidx2,:);
    end
end