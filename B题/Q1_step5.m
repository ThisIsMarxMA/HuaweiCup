%有空值则一列删除
function[data_new]=Q1_step5(data)
    [n,dim]=size(data);
    k=1;
    for i=1:dim
        if sum(isnan(data(:,i)))==0
            data_new(:,k)=data(:,i);
            k=k+1;
        end
    end
end