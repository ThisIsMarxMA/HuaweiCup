function[b,Y_result]=Q3_step1(data_train,Y_train,data_test)
    [n,dim]=size(data_train);
    [Yn,Ydim]=size(Y_train);
    X_train=[ones(Yn,1),data_train];

    %��1��b=regress(Y,X) ȷ���ع�ϵ���ĵ����ֵ
    %���У�YΪn*1�ľ���XΪ��ones(n,1),x1,��,xm���ľ���
    %��2��[b,bint,r,rint,stats]=regress(Y,X,alpha) ��ع�ϵ���ĵ���ƺ�������ƣ�������ع�ģ��
    %b �ع�ϵ�� bint �ع�ϵ����������� r �в� rint �в���������
    %stats ���ڼ���ع�ģ�͵�ͳ���������ĸ���ֵ�����ϵ��R2��Fֵ����F��Ӧ�ĸ���p�����
    %���ϵ��R2Խ�ӽ�1��˵���ع鷽��Խ������F > F1-����k��n-k-1��ʱ�ܾ�H0��FԽ��˵���ع鷽��Խ������
    %��F��Ӧ�ĸ���pʱ�ܾ�H0���ع�ģ�ͳ�����pֵ��0.01-0.05֮�䣬ԽСԽ��

    %����Ҫ�����Ƕ�Ԫ���Իع�
    [b,bint,r,rint,stats]=regress(Y_train,X_train);
    %b1Ϊ��Ԫ�ع鷽��ϵ��
    %���в�ͼ
    rcoplot(r,rint);
    %Ԥ�⼰��ͼ
    for i=1:25
        Y_result(i,1)=sum(b .* [1,data_test(i,:)]');
    end

%     %����Է���
%     [rho,pval]=corr(data_train,Y_train,'type','Pearson');
%     [rho2,pval2]=corr(data_train,'type','Pearson');
end


