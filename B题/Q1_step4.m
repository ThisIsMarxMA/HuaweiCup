%用附件一的范围值去规范附件三
function[data]=Q1_step4(data_354,data)
Mm_data_354=minmax(data_354'); %得出附件一的取值范围
b=Mm_data_354;
[n,dim]=size(data);
    for i=1:n   %对40个样本取值
        for j=1:dim     %对354个操作变量取值
            if data(i,j)<b(j,1) || data(i,j)>b(j,2) %如果有不符合范围的（按闭区间）
                data(i,j)=NaN;    %超出范围则置空
            end
        end
    end
end