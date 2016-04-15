%% play
% 
% play experiment video     
%
%% Syntax
%
%       play(experiment_name)
%
%% Description
% play opens a video tab where is displayed the video of the desired
% experiment
%    
%% Examples
% 
% play the video regarding one of the loaded experiment
%
%       play(experimentName(1));
%
%
%% Input Arguments
% *experiment name*
%
% it should be in format provided by the _load_ function and stored in the
% cell array _experimentName_
%
%% Output Arguments
%
% no output is provided, it is opened only a video tab.
%
%% More About
%
% This function doesn't ensure the original quality of the vide, if it is
% important for you to have the real quality we reccommend to open them
% with an external program. All the files are stored in the subfolder
% "Videos".


function [  ] = play( experimentName )
    C = strsplit(experimentName{1},'_');
    len = length(C);
    if len == 3
        name = char(strcat('videos/',C(1),'_',C(2),'/',C(1),'_',C(2),{' '},C(3),'.m4v'));
    elseif len == 5
        name = char(strcat('videos/',C(1),'_',C(2),'_',C(3),'_',C(4),'/',C(1),'_',C(2),'_',C(3),'_',C(4),{' '},C(5),'.m4v'));
    end
    videoFReader   = vision.VideoFileReader(name);
    depVideoPlayer = vision.DeployableVideoPlayer;
    cont = ~isDone(videoFReader);
    
    while cont
        frame = step(videoFReader);
        step(depVideoPlayer, frame);
        cont = ~isDone(videoFReader) && isOpen(depVideoPlayer);
        pause(0.07)
    end
end

