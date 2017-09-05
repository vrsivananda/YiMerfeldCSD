close all;

%========================
%====Parameters Start====
%========================

%Set how many trials we would like to use
%nTrials = 100;
plotRange = 10:100;

%======================
%====Parameters End====
%======================


filename = 'sivaData2.xls';

%Preallocate the arrays to store the end variables
finalMu = nan(length(plotRange),1);
finalSigma = nan(length(plotRange),1);
finalK = nan(length(plotRange),1);


counter = 1;
for i = plotRange
    close all;
    
    % Returns the parameters after the maximation of log likelohood in the
    % form [finalMu, finalSigma, finalK]
    muSigmaK = oneSubjectnTrialsCSD(filename, i);
    
    %Parse it out and store it in our array store
    finalMu(counter,1)    = muSigmaK(1);
    finalSigma(counter,1) = muSigmaK(2);
    finalK(counter,1)     = muSigmaK(3);
    
    %Increment counter
    counter = counter + 1;
end


%Plot all the mu, sigmas, and Ks
figure;
plot(plotRange, finalMu);
ylabel('final Mu');
xlabel('Number of trials');
title('optimized Mu');
xlim([plotRange(1), plotRange(end)]);
ylim([-0.5, 0.5]);

figure;
plot(plotRange, finalSigma);
ylabel('final Sigma');
xlabel('Number of trials');
title('optimized Sigma');
xlim([plotRange(1), plotRange(end)]);
ylim([0, 0.5]);

figure;
plot(plotRange, finalK);
ylabel('final K');
xlabel('Number of trials');
title('optimized K');
xlim([plotRange(1), plotRange(end)]);
ylim([0, 10.1]);

