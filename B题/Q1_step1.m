%����ֵ��ʹ��ǰ����Сʱƽ�����ݴ��� �����ֵ�����϶࣬��������0
function[data]=Q1_step1(data,ratio) %ratioȡ0.5
    [n,dim]=size(data);
    for i=1:dim     %����λ��
        vec=data(:,i);
        len=length(vec);
        k=1;
        num=zeros(40,1);
        for j=1:length(vec)
            if vec(j)==0   %����ô�ֵΪ0
                len=len-1;
                num(k)=j;   %��¼0λ�õ�
                k=k+1;
            end
        end
        %�������Ϊ0�ĵط��Ҳ���̫�࣬���þ�ֵ����0
        if len >= round(length(vec)*ratio) && len < length(vec)
            meanVec=sum(vec)/len;
            for j=1:k-1
                data(num(j),i)=meanVec;
            end
        elseif len < round(length(vec)*ratio)
            data(:,i)=0;    %���0̫���ȫ��0
        end
    end
end