%对sample里面的每个元素进行AR特征提取

for l = 1:2072
    for i = l;size(Sample)
    %data = ones(50,12);
    A = Sample(i).beatdata{1,1};
    for k = 1:12
        y = A(:,k); 
        mb = ar(y,49,'burg');   %提取A的第k列做AR
        Sample(i).data(:,k) = mb.a;
    end
    end
end
