%����ֵ��ʹ��ǰ����Сʱƽ�����ݴ��� �����ֵ�����϶࣬�������ÿ�
function[data]=Q1_step1(data,ratio) %ratioȡ0.5
    [n,dim]=size(data);
    for i=1:dim     %����λ��
        vec=data(:,i);
        len=length(vec);
        k=0;
        num=zeros(40,1);
        for j=1:length(vec)
            if isnan(vec(j))   %����ô�ֵΪ��
                len=len-1;
                num(k+1)=j;   %��¼��λ�õ�
                k=k+1;
            end
        end
        %�������Ϊ��ֵ�ĵط��Ҳ���̫�࣬���þ�ֵ���ǿ�
        if len >= round(length(vec)*ratio) && len < length(vec)
            meanVec=sum(vec(~isnan(vec)))/len;
            for j=1:k
                data(num(j),i)=meanVec;
            end
        elseif len < round(length(vec)*ratio)
            data(:,i)=NaN;    %�����ֵ̫���ȫ�ÿ�
        end
    end
end