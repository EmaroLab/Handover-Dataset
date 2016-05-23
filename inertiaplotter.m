%% inertiaplotter
% 
% plot inertial data    
%
%% Syntax
%
%       loader(IMUdata)
%
%% Description
% inertialplotter plots angular velocities and linear accellerations stored
% in a cell array in the format provided my loader function
%    
%% Examples
% 
% plot IMU data of the first subject
%
%       inertiaplotter(inertial_green)
%
% plot IMU data of the second subject
%
%       inertiaplotter(inertial_blue)
%
%
%% Input Arguments
% the input is a cell array containing IMU data in the format
%
% * 1 column Time
% * 2-4 columns Velocity (xyz format)
% * 5-7 columns Acceleration (xyz format)
%
%% Output Arguments
%
% no output is generated, it is only opened a figure tab with the plots
%


function [] = inertiaplotter(wearableData)

    T = cell2mat(wearableData(2:end,1));
    vX = cell2mat(wearableData(2:end,2));
    vY = cell2mat(wearableData(2:end,3));
    vZ = cell2mat(wearableData(2:end,4));
    
    aX = cell2mat(wearableData(2:end,5));
    aY = cell2mat(wearableData(2:end,6));
    aZ = cell2mat(wearableData(2:end,7));
    
    figure('units','normalized','outerposition',[0 0 1 1])
    subplot(2, 1, 1)
    hold on
    plot(T,aX,'red');
    plot(T,aY,'green');
    plot(T,aZ,'blue');
    ylabel('Acceleration (m/s^2)');
    xlabel('Time (s)');
    legend('x axis (raw data)','y axis (raw data)','z axis (raw data)','Location','northoutside','Orientation','horizontal')
    
    subplot(2, 1, 2)
    hold on
    plot(T,vX,'red');
    plot(T,vY,'green');
    plot(T,vZ,'blue');
    ylabel('Degree per second (dps)');
    xlabel('Time (s)');
    legend('x axis (raw data)','y axis (raw data)','z axis (raw data)','Location','northoutside','Orientation','horizontal')
end

