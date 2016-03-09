%测试不同的c和gamma对准确率的影响，保存在svm_acq中
svm_acq = ones(20,10);
for i = 1:3
    for j = 1:3
        C = 5 * i;
        R = 2^(-j - 2);
        str = ['-t 2 -c ' num2str(C) ' -g ' num2str(R)]
        model = svmtrain(data_label,data_inst,str );
        [predict_label, accuracy, dec_values] = svmpredict(data_label, data_inst, model,'-q');
        svm_acq(i,j) = accuracy(1);
    end
end