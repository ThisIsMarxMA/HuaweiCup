%�����������ݽ���PCAͶ��
%function[data_new]=Q2_step2(data,T) %T=0.9
    data=data_354;T=0.9;   
    [n,dim]=size(data);
    std_data=std(data);
    mean_data=mean(data);
    for i = 1:dim
        data_norm(:,i) = (data(:,i) - mean_data(:,i))/std_data(:,i);
    end
    %data_norm=(data-mean_data)./std_data;   %��׼��data
    Cdata=corrcoef(data_norm);   %�������ϵ������
    [V,D]=eig(Cdata);   %��������ֵ����������
    for i=1:dim
        DS(i,1)=D(dim+1-i,dim+1-i);  %����ֵ��������
    end
    for i=1:dim
        DS(i,2)=DS(i,1)/sum(DS(:,1));%����������
        DS(i,3)=sum(DS(1:i,1))/sum(DS(:,1));%�ۼƹ�����
    end
    
    for k=1:dim
        if DS(k,3)>=T;  %�ٶ����ɷ���Ϣ������T
            com_num=k;  %�õ����ɷ������ĸ���
            break;
        end
    end

    for i=1:com_num
        VS(:,i)=V(:,dim+1-i);    %��ȡ���ɷ���������
    end
    data_new=data_norm*VS;      %����ԭ�������������ռ�Ķ�Ӧ����
%end