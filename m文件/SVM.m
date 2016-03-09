function [ output_args ] = SVM( input_args )
%SVM Summary of this function goes here
%   Detailed explanation goes here
clear;
clc;
address={'Electrical axis left side\';'Left bundle branch block beat\';'Left ventricular hypertrophy\';'Normal\';
    'Right bundle branch block beat\';'Sinus-bradycardia\'};
    Nk=0;
    training_instance_matrix=[];
for k=1:6
    for i=1:5
    s=[address{k},num2str(i),'.mat'];
    Beats = importdata(s);
    for j=1:Beats.beatNumber
        Nk=Nk+1;
        feature(:,1)=featureExtraction1(Beats.beatData{1,j},Beats.rPeak(1,j));
         training_label_vector(Nk,1)=k;
         training_instance_matrix=[training_instance_matrix;feature(:,1)'];
        end
    end
    end
 model = svmtrain(training_label_vector, training_instance_matrix );
  Nk=0;
  testing_instance_matrix=[];
 for k=1:6
    for i=6:9
    s=[address{k},num2str(i),'.mat'];
    Beats = importdata(s);
    for j=1:Beats.beatNumber
        Nk=Nk+1;
        feature(:,1)=featureExtraction1(Beats.beatData{1,j},Beats.rPeak(1,j));
        testing_label_vector(Nk,1)=k;
       testing_instance_matrix=[testing_instance_matrix;feature(:,1)'];
        end
    end
 end
 [predicted_label, accuracy, prob_estimates] = svmpredict(testing_label_vector, testing_instance_matrix,model);
end

