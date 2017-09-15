function extraAnalyses(subject,nDataSets)
    %This function analyzes and plots:
    % -coherence staircase
    % -frame rate


    plotRange = 1:100;
    
    %Create stores for the variables
    unsignedCoherenceStore = nan(numel(plotRange),nDataSets);
    frameRateStore = nan(numel(plotRange),nDataSets);
  
    
    for i = 1:nDataSets
        
        %The filename for this dataset/ this experiment run
        %filename = [subject 'Data' num2str(i) '_400ms.xls']; %[need to change to i]
        filename = 'sivaData1_200ms.xls';
        %Read in the data from the file
        allData = xlsread(filename);
        
        
        %===Unsigned Coherence===
        %Get all data in the coherence column (unsigned because we will not
        %convert those going left to be negative
        unsignedCoherence = allData(:,14);
        %Only get the trials where there is a valid coherence
        unsignedCoherence = unsignedCoherence(~isnan(unsignedCoherence));
        %Delete the practice trials
        unsignedCoherence(1:10,:) = [];
        %Store the unsignedCoherence in the store
        unsignedCoherenceStore(:,i) = unsignedCoherence;
        
        %===Frame Rate===
        %Get all data in the frame_rate column
        frameRate = allData(:,25);
        %Only get the trials where there is a valid frame rate
        frameRate = frameRate(~isnan(frameRate));
        %Delete the practice trials
        frameRate(1:10,:) = [];
        %Store the frame rate in the store
        frameRateStore(:,i) = frameRate;
        
        %===Number of Frames===
        %Get all data in the number_of_frames column
        numberOfFrames = allData(:,26);
        %Only get the trials where there is a valid frame rate
        numberOfFrames = numberOfFrames(~isnan(numberOfFrames));
        %Delete the practice trials
        numberOfFrames(1:10,:) = [];
        %Store the frame rate in the store
        numberOfFramesStore(:,i) = numberOfFrames;

        
    
    end %End of for loop to go through data sets
    
    %========================
    %======= PLOTTING =======
    %========================
    
    %Set up the legend
    dataLegend = cell(nDataSets,1);
    for i = 1:nDataSets
        dataLegend{i} = [subject 'Data ' num2str(i)];
    end
    
    %Plot for unsignedCoherence
    figure;
    for i = 1:nDataSets
        %Plot the data
        plot(plotRange, unsignedCoherenceStore(:,i), 'MarkerSize', 12, 'Marker', '.', 'LineWidth', 2);
        ylabel('Coherence');
        xlabel('Trial number');
        title('Staircase Coherence');
        xlim([0, 100]);
        ylim([0, 1.0]);
        hold on;
    end
    legend(dataLegend);
    
    %Plot for frameRate
    figure;
    for i = 1:nDataSets
        %Plot the data
        plot(plotRange, frameRateStore(:,i), 'MarkerSize', 12, 'Marker', '.', 'LineWidth', 1);
        ylabel('average ms/frame');
        xlabel('Trial number');
        title('Average frame rate per trial');
        xlim([0, 100]);
        ylim([14, 35]);
        hold on;
    end
    legend(dataLegend);
    %Add in the line for the ideal frameRate
    idealFrameRate = 1000/60;
    line([plotRange(1), plotRange(end)], [idealFrameRate, idealFrameRate], 'LineStyle', '--', 'Color', 'k', 'LineWidth', 2);
    
    %Plot for numberOfFrames
    figure;
    for i = 1:nDataSets
        %Plot the data
        plot(plotRange, numberOfFramesStore(:,i), 'MarkerSize', 12, 'Marker', '.', 'LineWidth', 1);
        ylabel('Number of Frames');
        xlabel('Trial number');
        title('Number of frames per trial');
        xlim([0, 100]);
        ylim([0, 30]);
        hold on;
    end
    legend(dataLegend);
    %Add in the line for the ideal numberOfFrames
    idealNumberOfFrames = 60 * 0.2; %fps * s
    line([plotRange(1), plotRange(end)], [idealNumberOfFrames, idealNumberOfFrames], 'LineStyle', '--', 'Color', 'k', 'LineWidth', 2);


end