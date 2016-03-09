
%将结构体数组S转化为sample数组Sample

i = 1; %Sample的index
for k = 1:length(S)
    beatNumber = S(k).Beats.beatNumber; %测试天数
    label = S(k).Beats.label;  %真实标签
    rPeak = S(k).Beats.rPeak;  %rPeak数组
    beatData = S(k).Beats.beatData;  %beatData cell
    for l = 1:beatNumber
        rp = rPeak(l);
        Sample(i).label = label;
        Sample(i).rPeak = rp;
        A = beatData(l);
        %if(rp -100 < 0||rp + 100 > size(A,1))continue;
        %else Sample(i).beatdata = A(rp - 100:rp + 100,:);
        %end
        Sample(i).beatdata = A;
        i = i + 1;
    end
end