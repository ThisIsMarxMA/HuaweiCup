%���������и�ά�����Ļ���Ϣ
function [idx,w] = mutInfFS(X,Y,numF)
    [n,dim]=size(X);
    rank = [];
    for i = 1:dim
        rank = [rank; -muteinf(X(:,i),Y,n),i];   %�����iά��Y�Ļ���Ϣ 
    end;
    rank = sortrows(rank,1);   %������Ϣ���н������У�sortrowsĬ��Ϊ�������У�ǰ��Ӹ��� 
    
    rank(:,3)=abs(rank(:,1))./sum(rank(:,1));   %������Ϣռ��
    rank(1,4)=rank(1,3);    %��ʼ����ռ��
    
    for i=1:size(rank,1)-1
        rank(i+1,4)=rank(i,4) + rank(i+1,3);    %��i+1�е���ռ��Ϊ��һ����ռ�ȼ������е�ռ��
    end
    
    w = rank(1:numF, 1);    %ȡǰnumF������Ϣ
    idx = rank(1:numF, 2); %ȡǰnumF�����
end