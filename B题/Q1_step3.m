%����3��׼��׼���޳����ϴ�ֵ
function[data]=Q1_step3(data)
    [n,dim]=size(data);
    for i=1:dim
        vec=data(:,i);   %ȡ��һ������
        aa=mean(vec); %��ֵ
        sig=std(vec); %��׼��
        m=zeros(1,length(vec));
        for t=1:length(vec) %������������
            m(t)=abs(vec(t)-aa);
            if m(t)>=3*sig;
                data(t,i)=0;  %��������0
            end
        end
    end
end