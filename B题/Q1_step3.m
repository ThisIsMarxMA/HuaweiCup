%����3��׼��׼���޳����ϴ�ֵ
function[data]=Q1_step3(data)
    [n,dim]=size(data);
    for i=1:dim
        vec=data(:,i);   %ȡ��һ������
        flag=1;
        while(flag==1)  %ѭ��
            flag=0;
            NoNaN_vec=vec(~isnan(vec));   %ȡ���ǿ�Ԫ��
            aa=mean(NoNaN_vec); %�ǿ�Ԫ�ؾ�ֵ
            sig=sqrt((1/(length(NoNaN_vec)-1))*sum((NoNaN_vec-aa).^2)); %��׼��
            for t=1:length(vec) %������������
                if (~isnan(vec(t))) && (abs(vec(t)-aa)>3*sig)
                    vec(t)=NaN;  %�������ÿ�
                    flag=1;
                end
            end
        end
        data(:,i)=vec;  %��ɸѡ������ݸ�ֵ��ȥ
    end
end