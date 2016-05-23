%% loader
% 
% load excel files     
%
%% Syntax
%
%       [MocapData,w1Data,w2Data,KinectData,experimentName] = loader(experiment_name)
%
%       [MocapData,w1Data,w2Data,KinectData,experimentName] = loader(keyword)
%
%% Description
% loader creates four cell array containig the data of one or more
% experiments. The experiments can be selected using the exact name or
% through the usage of keywords
%    
%% Examples
% 
% load one experiment using its name
%
%       [MocapData,w1Data,w2Data,KinectData,experimentName] = loader('volunteer_1_65');
%
% load all the controlled experiments
%
%       [MocapData,w1Data,w2Data,KinectData,experimentName] = loader('controlled');
%
% load all the experiments
%
%       [MocapData,w1Data,w2Data,KinectData,experimentName] = loader('all');
%
% load only kinect data of experiments with approach
%
%       [~,~,~,KinectData,experimentName] = loader('approach');
%
%% Input Arguments
% *experiment name*
%
% it should be in one of the following form: " *Subject_Num* "   or   " *Subject1_Subject2_Num* "
%
% *key word*
%
% it has to be selected between one of the following
%
% * all
% * controlled (*experiment type*)
% * notcontrolled (*experiment type*)
% * approach (*experiment type*)
% * noapproach (*experiment type*)
% * giving (*experiment type*)
% * receving (*experiment type*)
% * card (*item*)          
% * paper (*item*)
% * waterbottle (*item*)
% * box (*item*)
% * dictionary (*item*)
% * pillow (*item*)
% * stick (*item*)
% * mug (*item*)
% * ball (*item*)
% * blackbottle (*item*)
% * normal (*strategy*)
% * quick (*strategy*)
% * delay (*strategy*)
% * holding (*strategy*)
% * wrongpos (*strategy*)
% * deceptiveobject (*strategy*)
%
%
%% Output Arguments
%
% the output concerns of four cell array and a vector of string
%
% * MocapData (contains 3D coordinate of 20 marker tracked by a mocap)
% * w1Data (contains IMU data collected by a smartwatch)
% * w2Data (contains IMU data collected by a smartwatch)
% * KinectData (3D coordinates of 15 human joints tracked by the kinect)
% * experimentName (name of experiment) 
%
% w1Data and KinectData refers to the same person.
%
% In case more than one experiment are loaded at the same time, each
% matrix is aranged in a 3 dimensional cell array in which the last index
% allows to identify the experiment. The sam thing works for the vector
% _experimentName_
%
% *e.g.* if I loaded N experiment and I want to access one specific one
%
%       MocapData(:,:,1)
%
%% More About
%
% All the data regarding the experiment descriptions are stored in the file 
% ExperimentTable so that it would be possible to extend the function
% in order to accept more that one input.


function [ MocapData, w1Data, w2Data, KinectData,experimentName] = loader(varargin)
   
    s = cd;

    path(path,strcat(cd,'/lib'));
    
    filename = 'sensor_data/ExperimentTable.xlsx';
    [~,~,A]  = xlsread(filename,'','','basic');
    
    sizeA = size(A);
    nVarargs = length(varargin);
    
    if nVarargs ~= 1
        error('input size not correct, only one input si allowed');
    end
    
    control = {'controlled','notcontrolled'};
    controlType = {'normal','delay','slow','holding','wrongpos','deceptiveobject'};
    object = {'card','paper','waterbottle','box','dictionary','pillow','stick','mug','ball','blackbottle'};
    moving = {'approach','noapproach'};
    agent = {'giving','receiving'};
    
    index = [];
    
    if strcmp('all',varargin)
        index = 0;
    elseif find(strcmp(control,varargin),1)
        index = 2;
    elseif find(strcmp(object,varargin),1)
        varargin = num2str(find(strcmp(object,varargin),1));
        index = 5;
    elseif find(strcmp(moving,varargin),1)
        index = 3;
    elseif find(strcmp(agent,varargin),1)
        index = 4;
    elseif find(strcmp(controlType,varargin),1)
        index = 6;
    else
        index = 1;
    end
    
    if index == 2 || index == 3 || index == 4
        if strcmp(varargin,A(1,index))
            varargin = 'true';
        else
            varargin = 'false';
        end
    end
        
    
        
    numbers = [];
    if index == 0
        numbers = 1:76;
    elseif index~=1 
        for i=2:sizeA(1)
            if strcmp(num2str(cell2mat(A(i,index))),varargin)
                numbers = [numbers,i-1];
            end
        end
    end
           
    folders = dir('sensor_data');
    numNumb = length(numbers);
    numDir = length(folders);
    ID = 1;
    
    for i=1:1:numDir
        directory = folders(i).name;
        if directory ~= '.';
            if index == 1
                filename = strcat('sensor_data/',directory,'/',varargin,'.xlsx');
                inFID = fopen(char(filename),'r');
                if inFID~= -1
                    filename
                    fclose(inFID);
                    [~,~,A]  = xlsread(char(filename),'','','basic');                     
                    [MocapData, w1Data, w2Data, KinectData]=split(A);
                    experimentName = varargin;
                end
            else
                for j=1:numNumb
                    filename = strcat('sensor_data/',directory,'/',directory,'_',num2str(numbers(j)),'*.xlsx');                   
                    files = dir(filename);
                    numFiles = length(files);
                    
                    for k=1:numFiles
                        C = strsplit(files(k).name,{'_','.'});
                        l = length(C);
                        if and(strcmp(C{l-1},'bis'),strcmp(C{l-2},num2str(numbers(j)))) || strcmp(C{l-1},num2str(numbers(j)))
                            filename = strcat('sensor_data/',directory,'/',files(k).name);
                            inFID = fopen(char(filename),'r');

                            if inFID~= -1
                                filename
                                fclose(inFID);
                                [~,~,A]  = xlsread(char(filename),'','','basic');
                                [M, w1, w2, Kinect]=split(A);
                                sM = size(M);
                                sw1 = size(w1);
                                sw2 = size(w2);
                                sK = size(Kinect);
                                MocapData(1:sM(1),1:sM(2),ID) = M;
                                w1Data(1:sw1(1),1:sw1(2),ID) = w1;
                                w2Data(1:sw2(1),1:sw2(2),ID) = w2;
                                KinectData(1:sK(1),1:sK(2),ID) = Kinect;
                                C = strsplit(filename,{'.','/'});
                                experimentName(1,ID) = cellstr(C(3));
                                ID = ID+1;
                            end
                        end
                    end
                end
            end
        end
    end
end
