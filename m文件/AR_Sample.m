%��sample�����ÿ��Ԫ�ؽ���AR������ȡ

for l = 1:2072
    for i = l;size(Sample)
    %data = ones(50,12);
    A = Sample(i).beatdata{1,1};
    for k = 1:12
        y = A(:,k); 
        mb = ar(y,49,'burg');   %��ȡA�ĵ�k����AR
        Sample(i).data(:,k) = mb.a;
    end
    end
end
