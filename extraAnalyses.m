function extraAnalyses(subject,nDataSets)
    %This function analyzes and plots:
    % -endingCoherence (no plot)
    % -coherence staircase
    % -frame rate
    % -number of frames
    
    % subject parameter should be e.g. 'subject1'
    % nDataSets parameter should be e.g. 6

    % PARAMETERS
    plotRange = 1:100;
    axisLabelSize = 22;
    tickSize = 16;
    legendFontSize = 18;
    
    %Create stores for the variables
    endingCoherenceStore    = nan(1,nDataSets);
    unsignedCoherenceStore  = nan(numel(plotRange),nDataSets);
    frameRateStore          = nan(numel(plotRange),nDataSets);
    numberOfFramesStore     = nan(numel(plotRange),nDataSets);
    
    cd ('/Users/cml2/Desktop/YiMerfeldCSD')
    path = pwd;
  
    
    for i = 1:nDataSets
        
        %The filename for this dataset/ this experiment run
        filename = [path,'/data/', subject 'Data' num2str(i) '.xls'];
        %filename = 'sivaData6.xls';
        %Read in the data from the file
        allData = xlsread(filename);
        
        
        %===Unsigned Coherence===
        endingCoherenceStore(i) = allData(455,14);
        
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
        numberOfFrames = allData(:,27);
        %Only get the trials where there is a valid frame rate
        numberOfFrames = numberOfFrames(~isnan(numberOfFrames));
        %Delete the practice trials
        numberOfFrames(1:10,:) = [];
        %Store the frame rate in the store
        numberOfFramesStore(:,i) = numberOfFrames;
        
        
    
    end %End of for loop to go through data sets
    
    %========================
    %====== STATISTICS ======
    %========================
    
    % Stats for the ending coherence
    endingCoherence_SD = std(unsignedCoherenceStore(100,:));
    
    
    %========================
    %======= PLOTTING =======
    %========================
    
    %Set up the legend
    dataLegend = cell(nDataSets,1);
    for i = 1:nDataSets
        dataLegend{i} = [' Run ' num2str(i)];
    end
    
    %Plot for unsignedCoherence
    figure;
    for i = 1:nDataSets
        %Plot the data
        plot(plotRange, unsignedCoherenceStore(:,i), 'MarkerSize', 12, 'Marker', '.', 'LineWidth', 2);
        %title('Staircase Coherence');
        %ylabel('Coherence');
        %xlabel('Trial number');
        xLabel = get(gca, 'Xlabel'); %Get the x label
        xLabelFontSize = get(xLabel,'FontSize'); %Store the Xlabel font size
        yLabel = get(gca, 'Ylabel'); %Get the y label
        yLabelFontSize = get(yLabel,'FontSize'); %Store the Ylabel font size
        xTicks = get(gca, 'XAxis'); %Get the Xaxis 
        yTicks = get(gca, 'YAxis'); %Get the Xaxis 
        set(xTicks, 'FontSize', tickSize); % Set the Xaxis font size
        set(yTicks, 'FontSize', tickSize); % Set the Yaxis font size
        set(xLabel, 'FontSize', xLabelFontSize); %Restore the Xlabel font size
        set(yLabel, 'FontSize', yLabelFontSize); %Restore the Ylabel font size
        
        xlim([0, 100]);
        ylim([0, 1.0]);
        hold on;
    end
    %legendObject = legend(dataLegend);
    %legendObject.FontSize = legendFontSize;
    
    %Plot for frameRate
    figure;
    for i = 1:nDataSets
        %Plot the data
        plot(plotRange, frameRateStore(:,i), 'MarkerSize', 12, 'Marker', '.', 'LineWidth', 1);
        title('Average time per frame');
        ylabel({'Average milliseconds per frame',''}, 'FontSize', axisLabelSize);
        xlabel({'','Trial number'}, 'FontSize', axisLabelSize);
        
        xLabel = get(gca, 'Xlabel'); %Get the x label
        xLabelFontSize = get(xLabel,'FontSize'); %Store the Xlabel font size
        yLabel = get(gca, 'Ylabel'); %Get the y label
        yLabelFontSize = get(yLabel,'FontSize'); %Store the Ylabel font size
        xTicks = get(gca, 'XAxis'); %Get the Xaxis 
        yTicks = get(gca, 'YAxis'); %Get the Xaxis 
        set(xTicks, 'FontSize', tickSize); % Set the Xaxis font size
        set(yTicks, 'FontSize', tickSize); % Set the Yaxis font size
        set(xLabel, 'FontSize', xLabelFontSize); %Restore the Xlabel font size
        set(yLabel, 'FontSize', yLabelFontSize); %Restore the Ylabel font size
           
        xlim([0, 100]);
        ylim([0, 30]);
        hold on;
    end
    legend(dataLegend);
    %legend({'Google Chrome - Ubuntu','Google Chrome - OSX'});
    %Add in the line for the ideal frameRate
    idealFrameRate = 1000/60;
    line([plotRange(1), plotRange(end)], [idealFrameRate, idealFrameRate], 'LineStyle', '--', 'Color', 'k', 'LineWidth', 2);
    
    %Plot for numberOfFrames
    figure;
    for i = 1:nDataSets
        %Plot the data
        plot(plotRange, numberOfFramesStore(:,i), 'MarkerSize', 12, 'Marker', '.', 'LineWidth', 1);
        title('Number of frames per trial');
        ylabel({'Number of frames',''}, 'FontSize', axisLabelSize);
        xlabel({'','Trial number'}, 'FontSize', axisLabelSize);
        
        xLabel = get(gca, 'Xlabel'); %Get the x label
        xLabelFontSize = get(xLabel,'FontSize'); %Store the Xlabel font size
        yLabel = get(gca, 'Ylabel'); %Get the y label
        yLabelFontSize = get(yLabel,'FontSize'); %Store the Ylabel font size
        xTicks = get(gca, 'XAxis'); %Get the Xaxis 
        yTicks = get(gca, 'YAxis'); %Get the Xaxis 
        set(xTicks, 'FontSize', tickSize); % Set the Xaxis font size
        set(yTicks, 'FontSize', tickSize); % Set the Yaxis font size
        set(xLabel, 'FontSize', xLabelFontSize); %Restore the Xlabel font size
        set(yLabel, 'FontSize', yLabelFontSize); %Restore the Ylabel font size
        
        
        xlim([0, 100]);
        ylim([0, 30]);
        hold on;
    end
    legend(dataLegend);
    %legend({'Google Chrome - Ubuntu','Google Chrome - OSX'});
    %Add in the line for the ideal numberOfFrames
    idealNumberOfFrames = 60 * 0.2; %fps * s
    line([plotRange(1), plotRange(end)], [idealNumberOfFrames, idealNumberOfFrames], 'LineStyle', '--', 'Color', 'k', 'LineWidth', 2);


end % End of function