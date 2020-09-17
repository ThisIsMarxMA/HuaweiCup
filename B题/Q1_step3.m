%利用3σ准则准则剔除误差较大值
function[data]=Q1_step3(data)
    [n,dim]=size(data);
    for i=1:dim
        vec=data(:,i);   %取出一列数据
        flag=1;
        while(flag==1)  %循环
            flag=0;
            No0_vec=nonzeros(vec);   %取出非零元素
            aa=mean(No0_vec); %非零元素均值
            sig=sqrt((1/(length(No0_vec)-1))*sum((No0_vec-aa).^2)); %标准差
            for t=1:length(vec) %遍历这列数据
                if (vec(t)~=0) && (abs(vec(t)-aa)>=3*sig)
                    vec(t)=0;  %超过的置0
                    flag=1;
                end
            end
        end
        data(:,i)=vec;  %将筛选后的数据赋值回去
    end
end