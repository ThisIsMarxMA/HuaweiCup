% 354个操作变量的取值范围与delta误差
function[data]=Q1_step2(data,fanwei) 
    b=zeros(length(fanwei),2);
    for i=1:size(fanwei)
        aaa=fanwei(i);
        temp=cell2mat(regexp(aaa{1,1},'[^（^）^(^)]','match'));   %去除括号
        L1=length(temp);    %长度一
        
        temp2=regexp(temp,'-','split');
        L2=sum(cellfun('length',temp2));  %长度二
        
        if L1-L2==1
            b(i,1)=str2double(temp2(1));
            b(i,2)=str2double(temp2(2));
        elseif L1-L2==2
            b(i,1)=-str2double(temp2(2));
            b(i,2)=str2double(temp2(3));
        elseif L1-L2==3
            b(i,1)=-str2double(temp2(2));
            b(i,2)=-str2double(temp2(4));
        end
    end
    
    [n,dim]=size(data);
    for i=1:n %对40个行向量取值
        for j=1:dim
            if data(i,j)<b(j,1) || data(i,j)>b(j,2) %如果有不符合范围的
                data(i,j)=0;    %超出范围则置零 
            end
        end
    end
end