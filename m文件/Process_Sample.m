%������������������
%��������beatdata����������
for i=1:length(Sample)
    A = Sample(i).beatdata(Sample(i).rPeak - 50:Sample(i).rPeak + 50,:);
    Sample(i).beatdata = A;
end