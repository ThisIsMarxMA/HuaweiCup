%�ø���һ�ķ�Χֵȥ�淶������
function[data]=Q1_step4(data_354,data)
Mm_data_354=minmax(data_354'); %�ó�����һ��ȡֵ��Χ
b=Mm_data_354;
[n,dim]=size(data);
    for i=1:n %��40��������ȡֵ
        for j=1:dim
            if data(i,j)<b(j,1) || data(i,j)>b(j,2) %����в����Ϸ�Χ�ģ��������䣩
                data(i,j)=NaN;    %������Χ���ÿ�
            end
        end
    end
end