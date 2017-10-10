
% PARAMETERS
plotRange = 1:100;
axisLabelSize = 22;
tickSize = 15;
nSetsPerBrowser = 5;

browserNames = {'Chrome', 'Firefox', 'Safari'};

%Create stores for the variables
frameRateStore          = nan(numel(plotRange),length(browserNames), nSetsPerBrowser);
numberOfFramesStore     = nan(numel(plotRange),length(browserNames), nSetsPerBrowser);


for i = 1:length(browserNames)
    
    for j = 1:nSetsPerBrowser
        
        %The filename for this dataset/ this experiment run
        filename = ['frameRateTest' browserNames{i} num2str(j) '.xls'];
        %Read in the data from the file
        allData = xlsread(filename);
        %Delete the rows without data
        allData(1:2,:) = [];

        %===Frame Rate===
        %Get all data in the frame_rate column
        frameRate = allData(plotRange,26);
        %Store the frame rate in the store
        frameRateStore(plotRange,i,j) = frameRate(plotRange);

        %===Number of Frames===
        %Get all data in the number_of_frames column
        numberOfFrames = allData(plotRange,28);
        %Store the frame rate in the store
        numberOfFramesStore(plotRange,i,j) = numberOfFrames(plotRange);
    
    end
    
end %End of for loop to go through broswerNames

%========================
%======= PLOTTING =======
%========================

%Plot for frameRate
for i = 1:length(browserNames)
    
    subplot(1,3,i);
    for j = 1:nSetsPerBrowser
        
    %Plot the data
    plot(plotRange, frameRateStore(:,i,j), 'MarkerSize', 12, 'Marker', '.', 'LineWidth', 1);
    %title(['Average time per frame - ' browserNames{i}]);
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
    
    %Add in the line for the ideal frameRate
    idealFrameRate = 1000/60;
    line([plotRange(1), plotRange(end)], [idealFrameRate, idealFrameRate], 'LineStyle', '--', 'Color', 'k', 'LineWidth', 2);

end

figure;

%Plot for numberOfFrames
for i = 1:length(browserNames)
    
    subplot(1,3,i);
    for j = 1:nSetsPerBrowser
    %Plot the data
    plot(plotRange, numberOfFramesStore(:,i,j), 'MarkerSize', 12, 'Marker', '.', 'LineWidth', 1);
    %title(['Number of frames per trial - ' browserNames{i}]);
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
    
    %Add in the line for the ideal numberOfFrames
    idealNumberOfFrames = 60 * 0.2; %fps * s
    line([plotRange(1), plotRange(end)], [idealNumberOfFrames, idealNumberOfFrames], 'LineStyle', '--', 'Color', 'k', 'LineWidth', 2);

end




