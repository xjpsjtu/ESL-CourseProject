[trainingData, trainingDataGroup] = readData();
trainingData = cell2mat(trainingData);
trainingDataGroup = cell2mat(trainingDataGroup);

V = rrLda(trainingData, trainingDataGroup);
gscatter(trainingData * V(:, 1), trainingData * V(:, 2), trainingDataGroup);