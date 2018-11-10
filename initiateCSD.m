close all;

cd ('/Users/cml2/Desktop/YiMerfeldCSD')
path = pwd;


%========================
%====Parameters Start====
%========================

%Set how many trials we would like to use
plotRange = 15:5:100;
nDataSets = 6;
subject = ['subject' num2str(2)];
legendFontSize = 25;
tickFontSize = 20;

%======================
%====Parameters End====
%======================

%Preallocate the arrays to store the end variables
finalMu = nan(length(plotRange),nDataSets);
finalSigma = nan(length(plotRange),nDataSets);
finalK = nan(length(plotRange),nDataSets);

%Preallocate the arrays to store the end variables
initialMu = nan(length(plotRange),nDataSets);
initialSigma = nan(length(plotRange),nDataSets);
initialK = nan(length(plotRange),nDataSets);

%========================================

%For loop for each of the datasets
for i = 1:nDataSets
    i = 2
    %The filename for this dataset/ this experiment run
    filename = [path '/data/' subject 'Data' num2str(i) '.xls'];
    
    %========================================
    %For loop for each iteration of the plot range
    counter = 1;
    for j = plotRange
        close all;
        
        % Returns the parameters after the maximation of log likelohood in the
        % form [initialMu, initialSigma, initialK, finalMu, finalSigma, finalK]
        muSigmaK = oneSubjectnTrialsCSD(filename, j);
        
        %Parse it out and store it in our array store
        initialMu(counter,i)    = muSigmaK(1);
        initialSigma(counter,i) = muSigmaK(2);
        initialK(counter,i)     = muSigmaK(3);
        
        finalMu(counter,i)      = muSigmaK(4);
        finalSigma(counter,i)   = muSigmaK(5);
        finalK(counter,i)       = muSigmaK(6);
        
        %Increment counter
        counter = counter + 1;
    end
    
end %End of for loop for each dataset

%========================================
%Plot all the mu, sigmas, and Ks

%Plot the Mu's
figure; % New figure

for i = 1:nDataSets
    
    plot(plotRange, finalMu(:,i), 'LineWidth', 1, 'Color', 'r', 'DisplayName', 'Final');
    ylabel('Mu');
    xlabel('Number of trials');
    title('Individual Mu''s');
    xlim([0, plotRange(end)]);
    ylim([-1, 1]);
    hold on;
    plot(plotRange, initialMu(:,i), 'LineWidth', 1, 'Color', 'k', 'DisplayName', 'Initial');
    hold on;
    legend('show');
    
end

%Plot the Sigma's
hold off;
figure;
for i = 1:nDataSets
    
    plot(plotRange, finalSigma(:,i), 'LineWidth', 1, 'Color', 'r', 'DisplayName', 'Final');
    ylabel('Sigma');
    xlabel('Number of trials');
    title('Individual Sigma''s');
    xlim([0 plotRange(end)]);
    ylim([-0.5, 1.5]);
    hold on;
    plot(plotRange, initialSigma(:,i), 'LineWidth', 1, 'Color', 'k', 'DisplayName', 'Initial');
    hold on;
    legend('show');
    
end


%Plot the K's
hold off;
figure;
for i = 1:nDataSets
    
    plot(plotRange, finalK(:,i), 'LineWidth', 1, 'Color', 'r', 'DisplayName', 'Final');
    ylabel('K');
    xlabel('Number of trials');
    title('Individual K''s');
    xlim([0, plotRange(end)]);
    ylim([0.5, 2.5]);
    hold on;
    plot(plotRange, initialK(:,i), 'LineWidth', 1, 'Color', 'k', 'DisplayName', 'Initial');
    hold on;
    legend('show');
    
end %End of for loop for each dataset

%========================================

%Calculate the mean and std dev of variables and store them in arrays

%Initial
meanInitialMu  = mean(initialMu,2);
meanInitialSigma  = mean(initialSigma,2);
meanInitialK  = mean(initialK,2);

sdInitialMu = std(initialMu,0,2);
sdInitialSigma = std(initialSigma,0,2);
sdInitialK = std(initialK,0,2); %This will not be plotted

%Final
meanFinalMu  = mean(finalMu,2);
meanFinalSigma  = mean(finalSigma,2);
meanFinalK  = mean(finalK,2);

sdFinalMu = std(finalMu,0,2);
sdFinalSigma = std(finalSigma,0,2);
sdFinalK = std(finalK,0,2); %This will not be plotted

%=====

%Calculate the error bars to be plotted for each variable

%Initial
sdUpperInitialMu = meanInitialMu + sdInitialMu;
sdLowerInitialMu = meanInitialMu - sdInitialMu;

sdUpperInitialSigma = meanInitialSigma + sdInitialSigma;
sdLowerInitialSigma = meanInitialSigma - sdInitialSigma;

sdUpperInitialK = meanInitialK + sdInitialK;
sdLowerInitialK = meanInitialK - sdInitialK;

%Final
sdUpperFinalMu = meanFinalMu + sdFinalMu;
sdLowerFinalMu = meanFinalMu - sdFinalMu;

sdUpperFinalSigma = meanFinalSigma + sdFinalSigma;
sdLowerFinalSigma = meanFinalSigma - sdFinalSigma;

sdUpperFinalK = meanFinalK + sdFinalK;
sdLowerFinalK = meanFinalK - sdFinalK;

%========================================
%Plot all the Summary Graphs

%Plot the summary Mu
figure;
%Conventional Psychometric Fit
plot(plotRange, meanInitialMu, 'LineWidth', 3, 'Color', 'k', 'DisplayName', 'Psy');
hold on;
h = plot(plotRange, sdUpperInitialMu, 'LineWidth', 1, 'Color', 'k');
set(get(get(h,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');%Turn off the legend for the SD line
hold on;
h = plot(plotRange, sdLowerInitialMu, 'LineWidth', 1, 'Color', 'k');
set(get(get(h,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');%Turn off the legend for the extra SD line
hold on;
%CSD
plot(plotRange, meanFinalMu, 'LineWidth', 3, 'Color', 'r', 'DisplayName', 'CSD');
hold on;
h = plot(plotRange, sdUpperFinalMu, 'LineWidth', 1, 'Color', 'r');
set(get(get(h,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');%Turn off the legend for the SD line
hold on;
h = plot(plotRange, sdLowerFinalMu, 'LineWidth', 1, 'Color', 'r');
set(get(get(h,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');%Turn off the legend for the extra SD line
hold off;
%Formatting
%ylabel('Mu\_cap');
%xlabel('Number of trials');
%title('Summary Mu\_cap');
xTicks = get(gca, 'XAxis'); %Get the Xaxis
yTicks = get(gca, 'YAxis'); %Get the Xaxis
set(xTicks, 'FontSize', tickFontSize); % Set the Xaxis font size
set(yTicks, 'FontSize', tickFontSize); % Set the Yaxis font size
xlim([0, plotRange(end)]);
ylim([-1, 1]);
legendObject = legend('show');
legendObject.FontSize = legendFontSize;

%Plot the summary Sigma
figure;
%Conventional Psychometric Fit
plot(plotRange, meanInitialSigma, 'LineWidth', 3, 'Color', 'k', 'DisplayName', 'Psy');
hold on;
h = plot(plotRange, sdUpperInitialSigma, 'LineWidth', 1, 'Color', 'k');
set(get(get(h,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');%Turn off the legend for the SD line
hold on;
h = plot(plotRange, sdLowerInitialSigma, 'LineWidth', 1, 'Color', 'k');
set(get(get(h,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');%Turn off the legend for the extra SD line
hold on;
%CSD
plot(plotRange, meanFinalSigma, 'LineWidth', 3, 'Color', 'r', 'DisplayName', 'CSD');
hold on;
h = plot(plotRange, sdUpperFinalSigma, 'LineWidth', 1, 'Color', 'r');
set(get(get(h,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');%Turn off the legend for the SD line
hold on;
h = plot(plotRange, sdLowerFinalSigma, 'LineWidth', 1, 'Color', 'r');
set(get(get(h,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');%Turn off the legend for the extra SD line
hold off;
%Formatting
%ylabel('Sigma\_cap');
%xlabel('Number of trials');
%title('Summary Sigma\_cap');
xTicks = get(gca, 'XAxis'); %Get the Xaxis
yTicks = get(gca, 'YAxis'); %Get the Xaxis
set(xTicks, 'FontSize', tickFontSize); % Set the Xaxis font size
set(yTicks, 'FontSize', tickFontSize); % Set the Yaxis font size
xlim([0, plotRange(end)]);
ylim([-0.5, 1.5]);
legendObject = legend('show');
legendObject.FontSize = legendFontSize;

%Plot the summary K
figure;
%Conventional Psychometric Fit
% plot(plotRange, meanInitialK, 'LineWidth', 3, 'Color', 'k', 'DisplayName', 'Initial Mean');
% hold on;
% plot(plotRange, sdUpperInitialK, 'LineWidth', 1, 'Color', 'k');
% hold on;
% h = plot(plotRange, sdLowerInitialK, 'LineWidth', 1, 'Color', 'k');
% set(get(get(h,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');%Turn off the legend for the extra SD line
% hold on;
%CSD
plot(plotRange, meanFinalK, 'LineWidth', 3, 'Color', 'r', 'DisplayName', 'CSD');
hold on;
h = plot(plotRange, sdUpperFinalK, 'LineWidth', 1, 'Color', 'r');
set(get(get(h,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');%Turn off the legend for the SD line
hold on;
h = plot(plotRange, sdLowerFinalK, 'LineWidth', 1, 'Color', 'r');
set(get(get(h,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');%Turn off the legend for the extra SD line
hold off;
%Formatting
%ylabel('K\_cap');
%xlabel('Number of trials');
%title('Summary K\_cap');
xTicks = get(gca, 'XAxis'); %Get the Xaxis
yTicks = get(gca, 'YAxis'); %Get the Xaxis
set(xTicks, 'FontSize', tickFontSize); % Set the Xaxis font size
set(yTicks, 'FontSize', tickFontSize); % Set the Yaxis font size
xlim([0, plotRange(end)]);
ylim([0.5, 2.5]);
legendObject = legend('show');
legendObject.FontSize = legendFontSize;


%========================================
%Plot all the Summary SDs

%Sumary SD for Mu
figure;
%Conventional Psychometric Fit
plot(plotRange, sdInitialMu, 'LineWidth', 3, 'Color', 'k', 'DisplayName', 'Initial Mu');
hold on;
plot(plotRange, sdFinalMu, 'LineWidth', 3, 'Color', 'r', 'DisplayName', 'Final Mu');
hold off;
%Formatting
ylabel('SD Mu\_cap');
xlabel('Number of trials');
title('SD Mu\_cap');
xlim([0, plotRange(end)]);
ylim([0, 1]);
legend('show');

%Summary SD for Sigma
figure;
%Conventional Psychometric Fit
plot(plotRange, sdInitialSigma, 'LineWidth', 3, 'Color', 'k', 'DisplayName', 'Initial Sigma');
hold on;
plot(plotRange, sdFinalSigma, 'LineWidth', 3, 'Color', 'r', 'DisplayName', 'Final Sigma');
hold off;
%Formatting
ylabel('SD Sigma\_cap');
xlabel('Number of trials');
title('SD Sigma\_cap');
xlim([0, plotRange(end)]);
ylim([0, 1]);
legend('show');

%========================================
%Save all the variables
save(['data/' subject],'finalK','finalMu','finalSigma','initialK','initialMu','initialSigma')