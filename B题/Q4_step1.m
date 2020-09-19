% 得到354个操作变量的取值范围
function[b]=Q4_step1(fanwei) 
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
end