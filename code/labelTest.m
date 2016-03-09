[trainingData, trainingDataGroup] = readData();
trainingData = cell2mat(trainingData);
trainingDataGroup = cell2mat(trainingDataGroup);
[coeff trainingData] = princomp(trainingData, 'econ');
trainingData = trainingData(:, 1:10);

svm = libsvmtrain(trainingDataGroup, trainingData, '-q -c 500 -g 0.002');

filenames = ls('../Test');
filenames = filenames(3:end, :);

testingData = [];
testingDataCount = 0;

for filenameCount = 1:size(filenames, 1)
    filename = deblank(filenames(filenameCount, :));
    load(['../Test/' filename]);
    data = data(:, 2:end);
    peaks = findPeaks(data);
    beat = averageBeats(data, peaks);
    beat = reshape(beat, 1, size(beat, 1) * size(beat, 2));
    if testingDataCount == size(testingData, 1)
        testingData = [testingData; zeros(2 * testingDataCount + 1, size(beat, 2))];
    end
    testingDataCount = testingDataCount + 1;
    testingData(testingDataCount, :) = beat;
end

testingData = testingData(1:testingDataCount, :);
labels = libsvmpredict(zeros(testingDataCount, 1), testingData, svm);
save('TestResult.mat', 'filenames', 'labels');