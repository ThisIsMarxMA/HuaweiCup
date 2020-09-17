%将空值处使用前后两小时平均数据代替 如果空值个数较少
function[]=Q1_step1(data,ratio) %ratio取0.5
    [n,dim]=size(data);
    for i=1:dim     %遍历位点
        vec=data(:,i);
        len=n;
        k=1;
        num=zeros(40,1);
        for j=1:n
            if vec(j)==0   %如果该处值为0
                len=len-1;
                num(k)=j;   %记录0位置点
                k=k+1;
            end
        end
        %如果存在为0的地方且不是太多，则用均值覆盖0
        if len >= round(n*ratio) && len < length(vec)
            meanVec=sum(vec)/len;
            for j=1:k-1
                data(num(j),i)=meanVec;
            end
        end
    end
end