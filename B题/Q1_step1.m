%����ֵ��ʹ��ǰ����Сʱƽ�����ݴ��� �����ֵ�����϶࣬�������ÿ�
function[data]=Q1_step1(data,ratio) %ratioȡ0.5
    [n,dim]=size(data);
    for i=1:dim     %����λ��
        vec=data(:,i);  %ȡ��һ��λ��
        k=0;
        for j=1:n
            if isnan(vec(j))   %����ô�ֵΪ��
                num(k+1)=j;   %��¼��λ�õ�
                k=k+1;
            end
        end
        len=n-k;    %ʣ��ķǿ�ֵ����
        %�������Ϊ��ֵ�ĵط��Ҳ���̫�࣬���þ�ֵ���ǿ�
        if len >= round(n*ratio) && len < n
            meanVec=sum(vec(~isnan(vec)))/len;  %��ʣ��ǿ�ֵȡƽ��ֵ
            for j=1:k
                data(num(j),i)=meanVec;
            end
        elseif len < round(n*ratio)
            data(:,i)=NaN;    %�����ֵ̫���ȫ�ÿ�
        end
    end
end