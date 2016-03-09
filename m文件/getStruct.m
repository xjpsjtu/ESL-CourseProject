di=dir('F:\sample\*.mat');
for k=1:length(di)
S(k)=load(['F:\sample\',di(k).name]);
end;