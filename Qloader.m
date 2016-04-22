%% Qloader
% 
% lods the questionnaire answers
%
%% Syntax
%
%       Answer = Qloader()
%
%% Description
% loads all the excel files contained in the folder _questionnaire_
%    
%% Examples
% 
% load all the questionnaire
%
%       Answer = Qloader;
%
%% Input Arguments
% No input is admitted 

%% Output Arguments
% the structur of the output is the following:
%
% *Answer* is a 3D cell array
%
% _Answer(:,2,const)_ contains the experiment names
%
% _Answer(1,2:end,const)_ contains the evaluated caratteristics
%
% _Answer(2:end,2:end,const)_ contains the evalutations
%
% the third dimension allow to store data for different volunteers.
%
% *Qname* is a cell vector containing the name of the loaded file, this
% allows to mantain the order with whom the file was loaded

function [Answer, Qname] = Qloader()
    folders = dir('questionnaires/Controlled Experiments');
    numDir = length(folders);

    for i=3:numDir
        filename = strcat('questionnaires/Controlled Experiments/',folders(i).name)
        [~,~,A]  = xlsread(char(filename),'','','basic');
        [c,r]=size(A);
        Qname(i-2) = cellstr(folders(i).name);
        Answer(1:c,1:r,i-2) = A;
    end
end

