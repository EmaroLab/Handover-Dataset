%% split
% 
% split cell array  
%
%% Syntax
%
%       [MocapData, inertial_green, inertial_blue, KinectData] = split(xlsreadMatrix)
%
%% Description
% The xlsread function provides as output a cell array containing all the
% stored in a xlsx file. This function gets one of that matrices and split
% their content into four different matrices.
%
%% Examples
% 
% split the content of a xlsx file
%
%       [MocapData, inertial_green, inertial_blue, KinectData] = split(A)
%
%% Input Arguments
% the input is a cell array obtained by xlsread function, the cell array
% has to contain the following data
%
% * Mocap Data
% * IMU wearable one
% * IMU wearable two
% * Kinect data
%
%% Output Arguments
% the output are four different cell array containing the splitted data
%
% * MocapData (usually a Nx61 cell array)
% * inertial_green (a Nx7 cell array)
% * inertial_blue (a Nx7 cell array)
% * KinectData (a Nx46 cell array)
%
% where N-1 is the number of the time instant, the first row contains
% column identifiers.
%
%% More About
%
% loader function uses split to provide as output the four cell array, we
% suggest to use directly loader to manage the files data.
%
function [MocapData, inertial_green, inertial_blue, KinectData] = split(A)
%split: function splits the cell array generated by xlsread in its four
%components

    pointIndex = 2;
    w1Index = 2;
    w2Index = 2;
    kinectIndex = 2;
    inertial_green(:,1) = A(:,1);
    inertial_blue(:,1) = A(:,1);
    w1Data(:,1) = A(:,1);
    w2Data(:,1) = A(:,1);
    MocapData(:,1) = A(:,1);
    KinectData(:,1) = A(:,1);

    Asize = size(A);
    Asize = Asize(2);

    for i = 2 : Asize
        c_name = char(char(A(1,i)));
        if c_name(1) == 'p'
            MocapData(:,pointIndex) = A(:,i);
            pointIndex = pointIndex+1;
        elseif c_name(1) == 'w' || c_name(1) == 'a'
            if strcmp(c_name(3),'g')
                inertial_green(:,w1Index) = A(:,i);
                w1Index = w1Index+1;
            elseif strcmp(c_name(3),'b')
            inertial_blue(:,w2Index) = A(:,i);
            w2Index = w2Index+1;
            end
        else
            KinectData(:,kinectIndex) = A(:,i);
            kinectIndex = kinectIndex + 1;
        end

    end
end
