close all;

%========================
%====Parameters Start====
%========================

%Set how many trials we would like to use
plotRange = 15:5:100;
nDataSets = 6;
subject = 'siva';

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
    
    %The filename for this dataset/ this experiment run
    filename = [subject 'Data' num2str(i) '.xls'];
    
    %========================================
    %For loop for each iteration of the plot range
    counter = 1;
    for j = plotRange
        close all;
        
        % Returns the parameters after the maximation of log likelohood in the
        % form [finalMu, finalSigma, finalK]
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
figure; %New figure

for i = 1:nDataSets
    
    plot(plotRange, finalMu(:,i), 'LineWidth', 2);
    ylabel('final Mu');
    xlabel('Number of trials');
    title('optimized Mu');
    xlim([0, plotRange(end)]);
    ylim([-1, 1]);
    hold on;

end

%Plot the Sigma's
hold off;
figure;
for i = 1:nDataSets
    
    plot(plotRange, finalSigma(:,i), 'LineWidth', 2);
    ylabel('final Sigma');
    xlabel('Number of trials');
    title('optimized Sigma');
    xlim([0 plotRange(end)]);
    ylim([-0.5, 1.5]);
    hold on;
  
end


%Plot the K's
hold off;
figure;
for i = 1:nDataSets
    
    plot(plotRange, finalK(:,i), 'LineWidth', 2);
    ylabel('final K');
    xlabel('Number of trials');
    title('optimized K');
    xlim([0, plotRange(end)]);
    ylim([0.5, 2.5]);
    hold on;
    
end %End of for loop for each dataset

%========================================