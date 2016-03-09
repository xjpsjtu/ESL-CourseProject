function [trainingData, trainingDataGroup] = readData()
    disp('Start reading data...');
    labels = ls('../Train');
    labels = labels(3:end, :);
    trainingData = {};
    trainingDataCount = 0;
    trainingDataGroup = {};
    for labelCount = 1:size(labels, 1)
        label = deblank(labels(labelCount, :));
        disp(['Label: ' num2str(labelCount) '----' label]);
        filenames = ls(['../Train/' label]);
        filenames = filenames(3:end, :);
        for filenameCount = 1:size(filenames, 1)
            filename = deblank(filenames(filenameCount, :));
            load(['../Train/' label '/' filename]);
            currentTrainingData = [];
            currentTrainingDataGroup = [];
            for beatCount = 1:Beats.beatNumber
                beatData = cell2mat(Beats.beatData(beatCount));
                rPeak = Beats.rPeak(beatCount);
                if rPeak >= 100 && rPeak + 100 <= size(beatData, 1)
                    beatData = beatData(rPeak - 100 + 1 : rPeak + 100, :);
                    beatData = reshape(beatData, 1, size(beatData, 1) * size(beatData, 2));
                    currentTrainingData = [currentTrainingData; beatData];
                    currentTrainingDataGroup = [currentTrainingDataGroup; labelCount];
                end
            end
            if trainingDataCount == size(trainingData, 1)
                trainingData = [trainingData; cell(trainingDataCount*2 + 1,1)];
                trainingDataGroup = [trainingDataGroup; cell(trainingDataCount*2 + 1, 1)];
            end
            trainingDataCount = trainingDataCount + 1;
            trainingData{trainingDataCount} = currentTrainingData;
            trainingDataGroup{trainingDataCount} = currentTrainingDataGroup;
        end
    end
    
    trainingData = trainingData(1:trainingDataCount);
    trainingDataGroup = trainingDataGroup(1:trainingDataCount);
    
    disp([num2str(trainingDataCount) ' records read.']);
end

