function [ feature ] = featureExtraction1( beatData,peak )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
feature=[];
    for i=1:12
       sample=beatData(:,i);
       change=dct(sample);
       change=change(1:7,1);
      feature=[feature;change];
    end
end



