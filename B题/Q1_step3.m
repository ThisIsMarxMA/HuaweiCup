%����3��׼��׼���޳����ϴ�ֵ
function[]=Q1_step3(data)
    [n,dim]=size(data);
    for i=1:dim
        vec=data(:,i);   %ȡ��һ������
        plot(vec);
        aa=mean(vec); %��ֵ
        sig=std(vec); %��׼��
        m=zeros(1,length(vec));
        for t=1:length(vec) %������������
            m(t)=abs(vec(t)-aa);
            if m(t)>=3*sig;
                data(t,i)=Inf;  %��������Inf
            end
        end
    end
end