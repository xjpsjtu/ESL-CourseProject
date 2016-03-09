function err = crossValidation(rrMethod, method, ck, gamma)
    rng('default');
    reduceRank = 10;
    
    [trainingData, trainingDataGroup] = readData();
    trainingDataCount = size(trainingData, 1);

    %以下代码将数据完全打乱，这会造成同一组心电数据的不同心跳既用于训练，又用于测试。
%     trainingData = cell2mat(trainingData);
%     trainingDataGroup = cell2mat(trainingDataGroup);
%     randIndex = randperm(size(trainingData, 1));
%     trainingDataCount = size(trainingData, 1);
%     trainingData = mat2cell(trainingData(randIndex, :), ones(trainingDataCount, 1));
%     trainingDataGroup = mat2cell(trainingDataGroup(randIndex, :), ones(trainingDataCount, 1));
    
    % PCA降维
    if strcmp(rrMethod, 'pca')
        coeff = princomp(mapminmax(cell2mat(trainingData)), 'econ');
        coeff = coeff(:, 1:reduceRank);

        for k = 1:trainingDataCount
            trainingData{k} = mapminmax(trainingData{k}) * coeff;
        end
    end
    
    randIndex = randperm(trainingDataCount);
    foldSize = fix(trainingDataCount/5);
    err = 0;
    totalCount = 0;
    for k = 1 : 5
        foldBegin = (k - 1) * foldSize + 1;
        if k == 5
            tempPredictionData = trainingData(randIndex(foldBegin : end));
            tempTrainingData = trainingData(randIndex(1 : foldBegin - 1));
            tempPredictionDataGroup = trainingDataGroup(randIndex(foldBegin : end));
            tempTrainingDataGroup = trainingDataGroup(randIndex(1 : foldBegin - 1));
        else
            tempPredictionData = trainingData(randIndex(foldBegin : foldBegin + foldSize - 1));
            tempTrainingData = trainingData(randIndex(1 : foldBegin - 1));
            tempTrainingData = [tempTrainingData; trainingData(randIndex(foldBegin + foldSize : end))];
            tempPredictionDataGroup = trainingDataGroup(randIndex(foldBegin : foldBegin + foldSize - 1));
            tempTrainingDataGroup = trainingDataGroup(randIndex(1 : foldBegin - 1));
            tempTrainingDataGroup = [tempTrainingDataGroup; trainingDataGroup(randIndex(foldBegin + foldSize : end))];
        end
        
        tempTrainingData = cell2mat(tempTrainingData);
        tempTrainingDataGroup = cell2mat(tempTrainingDataGroup);
        tempPredictionData = cell2mat(tempPredictionData);
        tempPredictionDataGroup = cell2mat(tempPredictionDataGroup);
        totalCount = totalCount + size(tempPredictionData, 1);
        
        % LDA降维
        if strcmp(rrMethod, 'lda')
            V = rrLda(tempTrainingData, tempTrainingDataGroup);
            V = V(:, 1:10);
            tempTrainingData = tempTrainingData * V;
            tempPredictionData = tempPredictionData * V;
        end
        
        if strcmp(method, 'svm')
            err = err + testSvm(tempTrainingData, tempTrainingDataGroup, tempPredictionData, tempPredictionDataGroup, ck, gamma);
        elseif strcmp(method, 'knn')
            err = err + testKnn(tempTrainingData, tempTrainingDataGroup, tempPredictionData, tempPredictionDataGroup, ck);
        end
    end
    
    err = err/totalCount;
end

function errSum = testSvm(trainingData, trainingDataGroup, predictionData, predictionDataGroup, c, gamma)
    svm = libsvmtrain(trainingDataGroup, trainingData, ['-q -c ' num2str(c) ' -g ' num2str(gamma)]);
    group = libsvmpredict(predictionDataGroup, predictionData, svm);
    errSum = 0;
    for k = 1:size(predictionData, 1)
        if group(k) ~= predictionDataGroup(k)
            errSum = errSum + 1;
        end
    end
end

function errSum = testKnn(trainingData, trainingDataGroup, predictionData, predictionDataGroup, k)
    group = knnclassify(predictionData, trainingData, trainingDataGroup, k);
    errSum = 0;
    for k = 1:size(predictionData, 1)
        if group(k) ~= predictionDataGroup(k)
            errSum = errSum + 1;
        end
    end
end