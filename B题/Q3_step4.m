% load carsmall % matlab�Դ����ݣ�����ֱ�����С����ݰ���������Horsepower, Weight, MPG
% X = [Horsepower Weight];
% rtree = fitrtree(X,MPG); % ���ɾ��������ع���
% view(rtree,'Mode','graph')  % �鿴������

% load fisheriris %matlab�Դ����ݣ�����ֱ�����С�% load��������
% ctree =  fitctree(meas,species); % ���ɾ�������������
% view(ctree,'Mode','graph') % % �鿴������

load ionosphere % �������� X �� Y
ctree = fitctree(X,Y);
resuberror = resubLoss(ctree)%�����������˴�����������ʧ����
Ynew = predict(ctree,mean(X))%����X����������ƽ��ֵ�������µ��������ݣ��ж������C.������������ܲ�����

% leafs = logspace(1,2,10);
% rng('default')
% N = numel(leafs);   %���ظ���
% err = zeros(N,1);
% for n=1:N
%         t =  fitctree(X,Y,'CrossVal','On', 'MinLeaf',leafs(n));%������֤�������㷨����
%         err(n) = kfoldLoss(t);%����������
% end
% plot(leafs,err);
% grid on
% xlabel('Min Leaf Size');
% ylabel('cross-validated error');
% %����err�õ���С��Ҷ�ӳߴ磬�ٽ��о���������
% OptimalTree = fitctree(X,Y,'minleaf',40);
% resuberror = resubLoss(OptimalTree) %����������Ĭ�Ͼ������㷨���˴�����������ʧ����
% lossOpt = kfoldLoss(crossval(OptimalTree))  %������֤���

[~,~,~,bestlevel] = cvLoss(ctree,'SubTrees','All','TreeSize','min')
cptree = prune(ctree,'Level',bestlevel);
view(cptree,'Mode','graph') % �鿴������
%�����֦����������ز������ͽ�����֤���
resubPrune =  resubLoss(cptree)
lossPrune =  kfoldLoss(crossval(cptree))



