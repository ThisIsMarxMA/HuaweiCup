%����ֵ��ʹ��ǰ����Сʱƽ�����ݴ��� �����ֵ��������
function[]=Q1_step1(data,ratio) %ratioȡ0.5
    [n,dim]=size(data);
    for i=1:dim     %����λ��
        vec=data(:,i);
        len=n;
        k=1;
        num=zeros(40,1);
        for j=1:n
            if vec(j)==0   %����ô�ֵΪ0
                len=len-1;
                num(k)=j;   %��¼0λ�õ�
                k=k+1;
            end
        end
        %�������Ϊ0�ĵط��Ҳ���̫�࣬���þ�ֵ����0
        if len >= round(n*ratio) && len < length(vec)
            meanVec=sum(vec)/len;
            for j=1:k-1
                data(num(j),i)=meanVec;
            end
        end
    end
end