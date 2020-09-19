%得出人工选取的位点和剩余用于降维/特征提取的位点
function[data_vip,data_nor]=Q2_step1(data,S)    %S=[1,2,4,7,9]
    [n,dim]=size(data);
    k=1;data_vip=[];data_nor=[];
    for i=1:dim
        if k<=length(S) && i==S(k)
            data_vip=[data_vip,data(:,i)];
            k=k+1;
        else
            data_nor=[data_nor,data(:,i)];
        end
    end
end