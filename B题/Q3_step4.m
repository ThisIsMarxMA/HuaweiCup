% load carsmall % matlab自带数据，可以直接运行。数据包含变量：Horsepower, Weight, MPG
% X = [Horsepower Weight];
% rtree = fitrtree(X,MPG); % 生成决策树：回归树
% view(rtree,'Mode','graph')  % 查看决策树

% load fisheriris %matlab自带数据，可以直接运行。% load样本数据
% ctree =  fitctree(meas,species); % 生成决策树：分类树
% view(ctree,'Mode','graph') % % 查看决策树

load ionosphere % 包含变量 X 和 Y
ctree = fitctree(X,Y);
resuberror = resubLoss(ctree)%衡量分类误差，此处可以设置损失函数
Ynew = predict(ctree,mean(X))%变量X的所有列求平均值，生成新的样本数据，判断其分类C.检验决策树性能并修正

% leafs = logspace(1,2,10);
% rng('default')
% N = numel(leafs);   %返回个数
% err = zeros(N,1);
% for n=1:N
%         t =  fitctree(X,Y,'CrossVal','On', 'MinLeaf',leafs(n));%交叉验证法估计算法精度
%         err(n) = kfoldLoss(t);%计算分类误差
% end
% plot(leafs,err);
% grid on
% xlabel('Min Leaf Size');
% ylabel('cross-validated error');
% %根据err得到最小的叶子尺寸，再进行决策树生成
% OptimalTree = fitctree(X,Y,'minleaf',40);
% resuberror = resubLoss(OptimalTree) %衡量分类误差，默认均方差算法，此处可以设置损失函数
% lossOpt = kfoldLoss(crossval(OptimalTree))  %交叉验证误差

[~,~,~,bestlevel] = cvLoss(ctree,'SubTrees','All','TreeSize','min')
cptree = prune(ctree,'Level',bestlevel);
view(cptree,'Mode','graph') % 查看决策树
%计算剪枝后决策树的重采样误差和交叉验证误差
resubPrune =  resubLoss(cptree)
lossPrune =  kfoldLoss(crossval(cptree))



