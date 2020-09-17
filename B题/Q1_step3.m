%利用3σ准则准则剔除误差较大值
function[]=Q1_step3(data)
    [n,dim]=size(data);
    for i=1:dim
        vec=data(:,i);   %取出一列数据
        plot(vec);
        aa=mean(vec); %均值
        sig=std(vec); %标准差
        m=zeros(1,length(vec));
        for t=1:length(vec) %遍历这列数据
            m(t)=abs(vec(t)-aa);
            if m(t)>=3*sig;
                data(t,i)=Inf;  %超过的置Inf
            end
        end
    end
end