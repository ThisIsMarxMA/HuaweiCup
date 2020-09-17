%将空值处使用前后两小时平均数据代替 如果空值个数较多，则整列置0
function[data]=Q1_step1(data,ratio) %ratio取0.5
    [n,dim]=size(data);
    for i=1:dim     %遍历位点
        vec=data(:,i);
        len=length(vec);
        k=1;
        num=zeros(40,1);
        for j=1:length(vec)
            if vec(j)==0   %如果该处值为0
                len=len-1;
                num(k)=j;   %记录0位置点
                k=k+1;
            end
        end
        %如果存在为0的地方且不是太多，则用均值覆盖0
        if len >= round(length(vec)*ratio) && len < length(vec)
            meanVec=sum(vec)/len;
            for j=1:k-1
                data(num(j),i)=meanVec;
            end
        elseif len < round(length(vec)*ratio)
            data(:,i)=0;    %如果0太多就全置0
        end
    end
end