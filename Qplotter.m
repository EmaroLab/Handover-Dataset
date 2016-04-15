%% Qplotter
% 
% plots answer to the questions  
%
%% Syntax
%
%       Qplotter(Answer)
%
%% Description
% creates an histogram for each charateristic analyzed. For all the
% experiments performs the average considering the data of all the
% volunteer.
%
% * naturalness
% * praticality
% * comfort
% * safety
% * speed
% * timing
%    
%% Examples
% 
% create histogram considering all the volunteer
%
%       Qplotter(Answer);
%
% create histogram considering only one volunteer
%
%       Qplotter(Answer(:,:,1));
%
%% Input Arguments
% There is only one allowed input the Answer cell array, it can be a 3D cell array
% or not.
%
% _Answer(:,2,const)_ contains the experiment names
%
% _Answer(1,2:end,const)_ contains the evaluated caratteristics
%
% _Answer(2:end,2:end,const)_ contains the evalutations
%
%
% the third dimension allow to store data for different volunteers.
%
%% Output Arguments
% no output is generated, it is only opened a figure tab
%
function [] = Qplotter(Answer)
    [~,~,n] = size(Answer);
    naturalness(1:44) = 0;
    praticality(1:44) = 0;
    comfort(1:44) = 0;
    safety(1:44) = 0;
    speed(1:44) = 0;
    timing(1:44) = 0;
    nexperiment(1:44) = 0;
    for i=1:n
        [c,~] = size(Answer(:,:,i));
        for j=2:c
            if iscellstr(Answer(j,1,i))
               
                C = strsplit(Answer{j,1,i},{'#','_'});
                num = str2double(C{2})-32;
                
                naturalness(1,num) = naturalness(1,num)+ cell2mat(Answer(j,2,i));
                praticality(1,num) = praticality(1,num)+ cell2mat(Answer(j,3,i));
                comfort(1,num) = comfort(1,num)+ cell2mat(Answer(j,4,i));
                safety(1,num) = safety(1,num)+ cell2mat(Answer(j,5,i));
                speed(1,num) = speed(1,num)+ cell2mat(Answer(j,6,i));
                timing(1,num) = timing(1,num)+ cell2mat(Answer(j,7,i));
                nexperiment(1,num) = nexperiment(1,num)+ 1;
            end
        end
    end
    
    figure('units','normalized','outerposition',[0 0 1 1])
    ax1 = subplot(3,2,1);
    avg = naturalness./nexperiment;
    y = [avg(1,1:8);avg(1,9:16);avg(1,17:24);avg(1,25:32);avg(1,33:40);avg(1,41:44)  0 0 0 0];
    bar(ax1,y,0.4);
    title('naturalness');
    axis([ 0 7 0 4]);
    
    ax2 = subplot(3,2,2);
    avg = praticality./nexperiment;
    y = [avg(1,1:8);avg(1,9:16);avg(1,17:24);avg(1,25:32);avg(1,33:40);avg(1,41:44)  0 0 0 0];
    bar(ax2,y,0.4);
    title('praticality');
    axis([ 0 7 0 4]);
    
    ax3 = subplot(3,2,3);
    avg = comfort./nexperiment;
    y = [avg(1,1:8);avg(1,9:16);avg(1,17:24);avg(1,25:32);avg(1,33:40);avg(1,41:44)  0 0 0 0];
    bar(ax3,y,0.4);
    title('comfort');
    axis([ 0 7 0 4]);
    
    ax4 = subplot(3,2,4);
    avg = safety./nexperiment;
    y = [avg(1,1:8);avg(1,9:16);avg(1,17:24);avg(1,25:32);avg(1,33:40);avg(1,41:44)  0 0 0 0];
    bar(ax4,y,0.4);
    title('safety');
    axis([ 0 7 0 4]);
    
    ax5 = subplot(3,2,5);
    avg = speed./nexperiment;
    y = [avg(1,1:8);avg(1,9:16);avg(1,17:24);avg(1,25:32);avg(1,33:40);avg(1,41:44)  0 0 0 0];
    bar(ax5,y,0.4);
    title('speed');
    axis([ 0 7 0 4]);
    
    ax6 = subplot(3,2,6);
    avg = timing./nexperiment;
    y = [avg(1,1:8);avg(1,9:16);avg(1,17:24);avg(1,25:32);avg(1,33:40);avg(1,41:44)  0 0 0 0];
    bar(ax6,y,0.4);
    title('timing');
    axis([ 0 7 0 4]);
    pause
    close all
end

