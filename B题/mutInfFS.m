%计算数据中各维与结果的互信息
function [idx,w] = mutInfFS(X,Y,numF)
    [n,dim]=size(X);
    rank = [];
    for i = 1:dim
        rank = [rank; -muteinf(X(:,i),Y,n),i];   %计算第i维与Y的互信息 
    end;
    rank = sortrows(rank,1);   %按互信息进行降序排列，sortrows默认为升序排列，前添加负号 
    
    rank(:,3)=abs(rank(:,1))./sum(rank(:,1));   %各互信息占比
    rank(1,4)=rank(1,3);    %初始化总占比
    
    for i=1:size(rank,1)-1
        rank(i+1,4)=rank(i,4) + rank(i+1,3);    %第i+1行的总占比为上一行总占比加上这行的占比
    end
    
    w = rank(1:numF, 1);    %取前numF个互信息
    idx = rank(1:numF, 2); %取前numF个序号
end