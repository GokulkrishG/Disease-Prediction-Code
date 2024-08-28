clc;
warning off
dbstop if error


%% Feature extraction - Normal
% Normal - 0
file1 = dir('.\Normal\*.png');

for In = 1 : length(file1)
 
          
          PreImage = (imread(['.\Normal\' file1(In).name ]));
          
          Feature = FeatureExtract(PreImage,0) ;       
       
         %% Combain all feature
       
          Feat1{In,1} = real(Feature);
          Feat1{In,2} = [file1(In).name ];
         
          Len1(In) = length(Feat1{In,1});
          In
          
end

%% Feature extraction - Adenocarcinoma
% Adenocarcinoma - 1
file2 = dir('.\Adenocarcinoma\*.png');

for In = 1 : length(file2)
 
          
          PreImage = (imread(['.\Adenocarcinoma\' file2(In).name ]));
          
          Feature = FeatureExtract(PreImage,1) ;       
       
         %% Combain all feature
       
          Feat2{In,1} = real(Feature);
          Feat2{In,2} = [file2(In).name ];
         
          Len2(In) = length(Feat2{In,1});
          In          
          
end


%% Feature extraction - Largecellcarcinoma
% Largecellcarcinoma - 2
file3 = dir('.\Largecellcarcinoma\*.png');

for In = 1 : length(file3)
 
          
          PreImage = (imread(['.\Largecellcarcinoma\' file3(In).name ]));
          
          Feature = FeatureExtract(PreImage,2) ;       
       
         %% Combain all feature
       
          Feat3{In,1} = real(Feature);
          Feat3{In,2} = [file3(In).name ];
         
          Len3(In) = length(Feat3{In,1});
          In          
          
end


%% Feature extraction - Squamouscellcarcinoma
%Squamouscellcarcinoma - 3
file4 = dir('.\Squamouscellcarcinoma\*.png');

for In = 1 : length(file4)
 
          
          PreImage = (imread(['.\Squamouscellcarcinoma\' file4(In).name ]));
          
          Feature = FeatureExtract(PreImage,3) ;       
       
         %% Combain all feature
       
          Feat4{In,1} = real(Feature);
          Feat4{In,2} = [file4(In).name ];
         
          Len4(In) = length(Feat4{In,1});
          In          
          
end



max_v1 = max(Len1);

for i = 1 : size(Feat1,1)
    
    if ~isequal(length(Feat1{i,1}),max_v1)
        S = Feat1{i,1} ;
        S(end+1:max_v1) = 0;
        Feat1{i,1} = S ;
        clear S
    end 
end


max_v2 = max(Len2);

for i = 1 : size(Feat2,1)
    
    if ~isequal(length(Feat2{i,1}),max_v2)
        S = Feat2{i,1} ;
        S(end+1:max_v2) = 0;
        Feat2{i,1} = S ;
        clear S
    end 
end

max_v3 = max(Len3);

for i = 1 : size(Feat3,1)
    
    if ~isequal(length(Feat3{i,1}),max_v3)
        S = Feat3{i,1} ;
        S(end+1:max_v3) = 0;
        Feat3{i,1} = S ;
        clear S
    end 
end

max_v4 = max(Len4);

for i = 1 : size(Feat4,1)
    
    if ~isequal(length(Feat4{i,1}),max_v4)
        S = Feat4{i,1} ;
        S(end+1:max_v4) = 0;
        Feat4{i,1} = S ;
        clear S
    end 
end


save Feat1 Feat1
save Feat2 Feat2
save Feat3 Feat3
save Feat4 Feat4
