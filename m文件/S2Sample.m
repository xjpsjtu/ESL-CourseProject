
%���ṹ������Sת��Ϊsample����Sample

i = 1; %Sample��index
for k = 1:length(S)
    beatNumber = S(k).Beats.beatNumber; %��������
    label = S(k).Beats.label;  %��ʵ��ǩ
    rPeak = S(k).Beats.rPeak;  %rPeak����
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