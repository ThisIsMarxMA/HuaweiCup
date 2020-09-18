%将处理后的数据进行PCA投射
%function[data_new]=Q2_step2(data,T) %T=0.9
    data=data_354;T=0.9;   
    [n,dim]=size(data);
    std_data=std(data);
    mean_data=mean(data);
    for i = 1:dim
        data_norm(:,i) = (data(:,i) - mean_data(:,i))/std_data(:,i);
    end
    %data_norm=(data-mean_data)./std_data;   %标准化data
    Cdata=corrcoef(data_norm);   %计算相关系数矩阵
    [V,D]=eig(Cdata);   %计算特征值与特征向量
    for i=1:dim
        DS(i,1)=D(dim+1-i,dim+1-i);  %特征值降序排列
    end
    for i=1:dim
        DS(i,2)=DS(i,1)/sum(DS(:,1));%单个贡献率
        DS(i,3)=sum(DS(1:i,1))/sum(DS(:,1));%累计贡献率
    end
    
    for k=1:dim
        if DS(k,3)>=T;  %假定主成分信息保留率T
            com_num=k;  %得到主成分向量的个数
            break;
        end
    end

    for i=1:com_num
        VS(:,i)=V(:,dim+1-i);    %提取主成分特征向量
    end
    data_new=data_norm*VS;      %计算原样本在新特征空间的对应坐标
%end