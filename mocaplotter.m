%% mocaplotter
% 
% plots mocap data    
%
%% Syntax
%
%       mocaplotter(MocapData)
%
%       mocaplotter(MocapData,rate)
%
%       mocaplotter(MocapData,keyword)
%
%% Description
% plot the 3D coordinates of the markers traked by the mocap at each time
% instant
%    
%% Examples
% 
% plot mocap data at default speed
%
%       mocaplotter(MocapData);
%
% plot mocap data at a custon speed
%
%       mocaplotter(MocapData,0.5);
%
%  plot mocap data at the recorded speed
%
%       mocaplotter(MocapData,'natural');
%
%% Input Arguments
% there is a compulsory input and an optional one
%
% * *compulsory* MocapData ( a cell array containing 3D point of the
% traked markers)
%
% * *optional* rate (a real number indicating the reprudaction speed, it's
% default value is 0.1 and it can be substituted with the keyword "narual")
%
%% Output Arguments
% no output is generated, it is only opened a figure tab
%
function [] = mocaplotter( varargin )

    nVarargs = length(varargin);
    
    if nVarargs > 2
        error('kinectplotter accpets maximum two inputs');
    elseif nVarargs == 0
        error('kinectplotter requires at least one input');
    end
    
    MocapData = varargin{1};
    rate = 0.1;
    flag = false;
    
    if nVarargs==2
        if strcmp(varargin{2},'natural')
            flag = true;
        else
            rate = varargin{2};
        end        
    end
    
    
    Mocap = cell2mat(MocapData(2:end,2:end));
    
    Time = cell2mat(MocapData(2:end,1));
    Time = circshift(Time,length(Time)-1)-Time;
    Time(end) = Time(end-1);
    
    
    [row,column] = size(Mocap);
    figure('units','normalized','outerposition',[0 0 1 1])
    for i=1:row
        X = [];
        Y = [];
        Z = [];
        for j=1:column/3
            X = [X,Mocap(i,3*j-2)];
            Y = [Y,Mocap(i,3*j-1)];
            Z = [Z,Mocap(i,3*j)];
        end
        scatter3(Z,X,Y)
        axis([-2 2 -2 2 -2 2]);
        view([-3,2,1.7]);
        if flag
            pause(Time(i));
        else
            pause(rate)
        end
    end
    pause
    close all
end

