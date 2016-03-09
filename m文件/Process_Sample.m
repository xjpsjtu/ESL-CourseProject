%对样本集做初步处理
%对样本的beatdata做初步处理
for i=1:length(Sample)
    A = Sample(i).beatdata(Sample(i).rPeak - 50:Sample(i).rPeak + 50,:);
    Sample(i).beatdata = A;
end