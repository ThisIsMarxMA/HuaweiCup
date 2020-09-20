function[result]=PCR(X_train,Y_train,X_test,Y_test,k)
%% IV. ���ɷַ���
% 1. ��һ���ɷ�vs.�ڶ����ɷ�
figure
[PCALoadings,PCAScores,PCAVar] = princomp(X_train);
plot(PCAScores(:,1),PCAScores(:,2),'r+')
hold on
[PCALoadings_test,PCAScores_test,PCAVar_test] = princomp(X_test);
plot(PCAScores_test(:,1),PCAScores_test(:,2),'o')
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
legend('Training Set','Testing Set','location','best')
figure
percent_explained = 100 * PCAVar / sum(PCAVar);
pareto(percent_explained)
xlabel('���ɷ�')
ylabel('������(%)')
title('���ɷֹ�����')
%% V. ���ɷֻع�ģ��
% 1. ����ģ��
betaPCR = regress(Y_train-mean(Y_train),PCAScores(:,1:k));
betaPCR = PCALoadings(:,1:k) * betaPCR;
betaPCR = [mean(Y_train)-mean(X_train) * betaPCR;betaPCR];
% 2. Ԥ�����
N = size(X_test,1);
T_sim = [ones(N,1) X_test] * betaPCR;
 
%% VI. ����������ͼ
% 1. ������error
error = abs(T_sim - Y_test) ./ Y_test;
% 2. ����ϵ��R^2
R2 = (N * sum(T_sim .* Y_test) - sum(T_sim) * sum(Y_test))^2 / ((N * sum((T_sim).^2) - (sum(T_sim))^2) * (N * sum((Y_test).^2) - (sum(Y_test))^2)); 
% 3. ����Ա�
result = [Y_test T_sim error];
% 4. ��ͼ
figure
plot(1:N,Y_test,'b:*',1:N,T_sim,'r-o')
legend('��ʵֵ','Ԥ��ֵ','location','best')
xlabel('Ԥ������')
ylabel('����ֵ')
string = {'���Լ�����ֵ����Ԥ�����Ա�';['R^2=' num2str(R2)]};
title(string)
