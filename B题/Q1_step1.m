%将空值处使用前后两小时平均数据代替 如果空值个数较多，则整列置空
function[data]=Q1_step1(data,ratio) %ratio取0.5
    [n,dim]=size(data);
    for i=1:dim     %遍历位点
        vec=data(:,i);
        len=length(vec);
        k=0;
        num=zeros(40,1);
        for j=1:length(vec)
            if isnan(vec(j))   %如果该处值为空
                len=len-1;
                num(k+1)=j;   %记录空位置点
                k=k+1;
            end
        end
        %如果存在为空值的地方且不是太多，则用均值覆盖空
        if len >= round(length(vec)*ratio) && len < length(vec)
            meanVec=sum(vec(~isnan(vec)))/len;
            for j=1:k
                data(num(j),i)=meanVec;
            end
        elseif len < round(length(vec)*ratio)
            data(:,i)=NaN;    %如果空值太多就全置空
        end
    end
end