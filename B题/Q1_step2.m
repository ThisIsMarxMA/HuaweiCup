% 354个操作变量的取值范围与delta误差
function[]=Q1_step2(data,range) 
    for i=1:size(range)
        line=range(i);
        range(i)=regexp(line,'-','split');
    end
    
    [n,dim]=size(data);
    for i=1:n %对40个行向量取值
        for j=1:dim
            if data(i,j)<range{1,j}(1) || dataNo313(i,j)>range{1,j}(2) %如果有不符合范围的
                data(i,j)=Inf; 
            end
        end
    end
end