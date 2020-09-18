clc
% clear all
A = xlsread('/Users/wanzhichong/Documents/MATLAB/HuaweiCup/325data-sample.xlsx', 'C4:NF328');

% ���ݱ�׼������
a = size(A, 1); % ����
b = size(A, 2); % ����
for i = 1:b
    SA(:,i) = (A(:,i) - mean(A(:,i)))/std(A(:,i));
end

% �������ϵ�����������ֵ����������
CM = corrcoef(SA); % �������ϵ������
[V, D] = eig(CM); % ��������ֵ����������

for j = 1:b
    DS(j,1) = D(b+1-j, b+1-j); % ������ֵ�������������
end
for i = 1:b
    DS(i,2)=DS(i,1)/sum(DS(:,1)); % ������
    DS(i,3)=sum(DS(1:i,1))/sum(DS(:,1)); % ���۹�����
end

% ѡ�����ɷּ���Ӧ����������
T = 0.85; % ���ɷ���Ϣ������
for K=1:b
    if DS(K,3)>=T
        Com_num = K;
        break;
    end
end

% ��ȡ���ɷֶ�Ӧ����������
for j =1:Com_num
    PV(:,j) = V(:,b+1-j);
end

% ���ģ�ͼ����չʾ
disp('����ֵ���乱���ʡ��ۼƹ����ʣ�')
DS
disp('��Ϣ������T��Ӧ�����ɷַ���������������')
Com_num
PV



