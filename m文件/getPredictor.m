%将sample里面的data转化成一个600维向量作为预测子
for i = 1:2072
    label = Sample(i).label;
    if strcmp(label, '窦性心律_电轴左偏')
        Sample(i).label = 1;
    else if strcmp(label, '窦性心律_完全性左束支传导阻滞')
            Sample(i).label = 2;
        else if strcmp(label, '窦性心律_提示左室肥厚')
                Sample(i).label = 3;
            else if strcmp(label, '正常心电图')
                    Sample(i).label = 4;
                else if strcmp(label, '窦性心律_完全性右束支传导阻滞')
                        Sample(i).label = 5;
                    else if strcmp(label, '窦性心动过缓')
                            Sample(i).label = 6;
                        end
                    end
                end
            end
        end
    end
        
    A = Sample(i).data;
    j=1;
    for k = 1:12
        for l = 1:50
            Sample(i).p(j) = A(l,k);
            j = j + 1;
        end
    end
end
