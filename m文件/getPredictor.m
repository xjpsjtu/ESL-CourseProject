%��sample�����dataת����һ��600ά������ΪԤ����
for i = 1:2072
    label = Sample(i).label;
    if strcmp(label, '�������_������ƫ')
        Sample(i).label = 1;
    else if strcmp(label, '�������_��ȫ������֧��������')
            Sample(i).label = 2;
        else if strcmp(label, '�������_��ʾ���ҷʺ�')
                Sample(i).label = 3;
            else if strcmp(label, '�����ĵ�ͼ')
                    Sample(i).label = 4;
                else if strcmp(label, '�������_��ȫ������֧��������')
                        Sample(i).label = 5;
                    else if strcmp(label, '����Ķ�����')
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
