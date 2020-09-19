%将空值处使用前后两小时平均数据代替 如果空值个数较多，则整列置空
function[data]=Q1_step1(data,ratio) %ratio取0.5
    [n,dim]=size(data);
    for i=1:dim     %遍历位点
        vec=data(:,i);  %取出一列位点
        k=0;
        for j=1:n
            if isnan(vec(j))   %如果该处值为空
                num(k+1)=j;   %记录空位置点
                k=k+1;
            end
        end
        len=n-k;    %剩余的非空值个数
        %如果存在为空值的地方且不是太多，则用均值覆盖空
        if len >= round(n*ratio) && len < n
            meanVec=sum(vec(~isnan(vec)))/len;  %对剩余非空值取平均值
            for j=1:k
                data(num(j),i)=meanVec;
            end
        elseif len < round(n*ratio)
            data(:,i)=NaN;    %如果空值太多就全置空
        end
    end
end