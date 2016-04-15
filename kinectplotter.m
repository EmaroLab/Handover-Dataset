%% kinectplotter
% 
% plot kinect skeleton   
%
%% Syntax
%
%       kinectplotter(KinectData)
%
%       kinectplotter(KinectData,rate)
%
%       kinectplotter(KinectData,keyword)
%
%% Description
% display a "video" of the recorded kinect skeleton 
%
%% Examples
% 
% display skeleton at default speed
%
%       kinectplotter(KinectData)
%
% display skeleton at a custon speed
%
%       kinectplotter(KinectData,0.4)
%
% display skeleton at the recorded speed
%
%       kinectplotter(KinectData,'natural')
%
%% Input Arguments
% there is a compulsory input and an optional one
% 
% * *compulsory* KinectData ( a cell array containing 3D point of the
% traked human joints)
%
% * *optional* rate (a real number indicating the reprudaction speed, it's
% default value is 0.1 and it can be substituted with the keyword "narual")
%
%% Output Arguments
% no output is generated, it is only opened a figure tab
%

function [] = kinectplotter( varargin )

    nVarargs = length(varargin);
    
    if nVarargs > 2
        error('kinectplotter accpets maximum two inputs');
    elseif nVarargs == 0
        error('kinectplotter requires at least one input');
    end
    
    KinectData = varargin{1};
    rate = 0.1;
    flag = false;
    M = 0;
        
    kinect = cell2mat(KinectData(2:end,2:end));
    if nVarargs==2
        if strcmp(varargin{2},'natural')
            flag = true;
        else
            rate = varargin{2};
        end
    end
    
    Time = cell2mat(KinectData(2:end,1));
    Time = circshift(Time,length(Time)-1)-Time;
    Time(end) = Time(end-1);
       
    [timeS,columns] = size(kinect);
    figure(1)
    
    for i=1:timeS
        clf(1)
        hold on
        for j=1:columns
            if abs(kinect(i,j)) > M
                M = abs(kinect(i,j));
            end
        end
        
        X =[kinect(i,1),kinect(i,4),kinect(i,7),kinect(i,37),kinect(i,16),kinect(i,13),kinect(i,10)];
        Y =[kinect(i,2),kinect(i,5),kinect(i,8),kinect(i,38),kinect(i,17),kinect(i,14),kinect(i,11)];
        Z =[kinect(i,3),kinect(i,6),kinect(i,9),kinect(i,39),kinect(i,18),kinect(i,15),kinect(i,12)];
        plot3(X,Y,Z,'black')

        X =[kinect(i,19),kinect(i,22),kinect(i,25),kinect(i,37),kinect(i,34),kinect(i,31),kinect(i,28)];
        Y =[kinect(i,20),kinect(i,23),kinect(i,26),kinect(i,38),kinect(i,35),kinect(i,32),kinect(i,29)];
        Z =[kinect(i,21),kinect(i,24),kinect(i,27),kinect(i,39),kinect(i,36),kinect(i,33),kinect(i,30)];
        plot3(X,Y,Z,'red')

        X =[kinect(i,34),kinect(i,40),kinect(i,43)];
        Y =[kinect(i,35),kinect(i,41),kinect(i,44)];
        Z =[kinect(i,36),kinect(i,42),kinect(i,45)];
        plot3(X,Y,Z,'black')

        X =[kinect(i,16),kinect(i,40)];
        Y =[kinect(i,17),kinect(i,41)];
        Z =[kinect(i,18),kinect(i,42)];
        plot3(X,Y,Z,'black')

        X =[kinect(i,25),kinect(i,7)];
        Y =[kinect(i,26),kinect(i,8)];
        Z =[kinect(i,27),kinect(i,9)];
        plot3(X,Y,Z,'black')

        view([-3,-4,1.7])
        axis([-M M -M M -M M]);
       
        if flag
            pause(Time(i));
        else
            pause(rate);
        end
        M = 0;
    end
    pause()
    close()
end

