function [ output_args ] = Neural_network( input_args )
%NEURAL_NETWORK Summary of this function goes here
%   Detailed explanation goes here
clear;
clc;

address={'Electrical axis left side\';'Left bundle branch block beat\';'Left ventricular hypertrophy\';'Normal\';
    'Right bundle branch block beat\';'Sinus-bradycardia\'};
    Nk=0;
   inputs=[];
   targets=[];
for k=1:6
    for i=1:5
    s=[address{k},num2str(i),'.mat'];
    Beats = importdata(s);
    for j=1:Beats.beatNumber
        Nk=Nk+1;
        feature(:,1)=featureExtraction1(Beats.beatData{1,j},Beats.rPeak(1,j));
         inputs=[inputs,feature];
         switch k
             case 1 
                 out=[1;0;0;0;0;0];
             case 2 
                 out=[0;1;0;0;0;0];
             case 3 
                 out=[0;0;1;0;0;0];
             case 4 
                 out=[0;0;0;1;0;0];
             case 5 
                 out=[0;0;0;0;1;0];
             case 6 
                 out=[0;0;0;0;0;1];
         end
         targets=[targets,out];
        end
    end
end
  net = newff(inputs,targets,30);
  net = train(net,inputs,targets);
  net.trainparam.goal = 0.0001 ;
  inputs=[];
 targets=[];
for k=1:6
    for i=6:9
    s=[address{k},num2str(i),'.mat'];
    Beats = importdata(s);
    for j=1:Beats.beatNumber
        Nk=Nk+1;
        feature(:,1)=featureExtraction1(Beats.beatData{1,j},Beats.rPeak(1,j));
         inputs=[inputs,feature];
         targets=[targets,k];
        end
    end
end
outputs = net(inputs);
outputlabel=[];
for i=1:size(outputs,2)
    location=find(max(outputs(:,i))==outputs(:,i))
    outputlabel=[outputlabel,location];
end
Ncorrect=0;
for i=1:size(targets,2)
    if (outputlabel(1,i)==targets(1,i))
        Ncorrect=Ncorrect+1;
    end
end
accuracy=Ncorrect/size(targets,2);
end

