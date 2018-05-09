% To conduct a meta-analyses on all the subject's data

cd ('/Users/cml2/Desktop/YiMerfeldCSD')
path = pwd;

subject1 = load([path '/data/subject1']);
subject2 = load([path '/data/subject2']);
subject3 = load([path '/data/subject3']);
subject4 = load([path '/data/subject4']);

%20 vs 100 trials comparison

%--------------------------------------
%Sigma for the repeated measures anova
%20 trials CSD vs 100 trials CSD

%Create the matrix for data storage, where subjects are rows
allSubjects_Sigma_20CSD_100CSD = nan(4,12);

%Store the data from each subject
% subject1
allSubjects_Sigma_20CSD_100CSD(1,1:6) = subject1.finalSigma(2,:); %20 trials
allSubjects_Sigma_20CSD_100CSD(1,7:12) = subject1.finalSigma(18,:); %100 trials
% subject2
allSubjects_Sigma_20CSD_100CSD(2,1:6) = subject2.finalSigma(2,:); %20 trials
allSubjects_Sigma_20CSD_100CSD(2,7:12) = subject2.finalSigma(18,:); %100 trials
% subject3
allSubjects_Sigma_20CSD_100CSD(3,1:6) = subject3.finalSigma(2,:); %20 trials
allSubjects_Sigma_20CSD_100CSD(3,7:12) = subject3.finalSigma(18,:); %100 trials
% subject4
allSubjects_Sigma_20CSD_100CSD(4,1:6) = subject4.finalSigma(2,:); %20 trials
allSubjects_Sigma_20CSD_100CSD(4,7:12) = subject4.finalSigma(18,:); %100 trials

%--------------------------------------
%Sigma for the repeated measures anova
%20 trials CSD vs 100 trials psy

%Create the matrix for data storage, where subjects are rows
allSubjects_Sigma_20CSD_100psy = nan(4,12);

%Store the data from each subject
% subject1
allSubjects_Sigma_20CSD_100psy(1,1:6) = subject1.finalSigma(2,:); %20 trials, CSD
allSubjects_Sigma_20CSD_100psy(1,7:12) = subject1.initialSigma(18,:); %100 trials, psy
% subject2
allSubjects_Sigma_20CSD_100psy(2,1:6) = subject2.finalSigma(2,:); %20 trials, CSD
allSubjects_Sigma_20CSD_100psy(2,7:12) = subject2.initialSigma(18,:); %100 trials, psy
% subject3
allSubjects_Sigma_20CSD_100psy(3,1:6) = subject3.finalSigma(2,:); %20 trials, CSD
allSubjects_Sigma_20CSD_100psy(3,7:12) = subject3.initialSigma(18,:); %100 trials, psy
% subject4
allSubjects_Sigma_20CSD_100psy(4,1:6) = subject4.finalSigma(2,:); %20 trials, CSD
allSubjects_Sigma_20CSD_100psy(4,7:12) = subject4.initialSigma(18,:); %100 trials, psy

%--------------------------------------
%Sigma for the repeated measures anova
%20 trials psy vs 100 trials psy

%Create the matrix for data storage, where subjects are rows
allSubjects_Sigma_20psy_100psy = nan(4,12);

%Store the data from each subject
% subject1
allSubjects_Sigma_20psy_100psy(1,1:6) = subject1.initialSigma(2,:); %20 trials, psy
allSubjects_Sigma_20psy_100psy(1,7:12) = subject1.initialSigma(18,:); %100 trials, psy
% subject2
allSubjects_Sigma_20psy_100psy(2,1:6) = subject2.initialSigma(2,:); %20 trials, psy
allSubjects_Sigma_20psy_100psy(2,7:12) = subject2.initialSigma(18,:); %100 trials, psy
% subject3
allSubjects_Sigma_20psy_100psy(3,1:6) = subject3.initialSigma(2,:); %20 trials, psy
allSubjects_Sigma_20psy_100psy(3,7:12) = subject3.initialSigma(18,:); %100 trials, psy
% subject4
allSubjects_Sigma_20psy_100psy(4,1:6) = subject4.initialSigma(2,:); %20 trials, psy
allSubjects_Sigma_20psy_100psy(4,7:12) = subject4.initialSigma(18,:); %100 trials, psy

%--------------------------------------
%Sigma for the within-subjects t-test (This is unused)
%20 trials  vs 100 trials psy

%Create the matrix for data storage, where subjects are rows
allSubjects_AverageSigma_20psy_100psy = nan(4,2);

%Store the data from each subject
% subject1
allSubjects_AverageSigma_20psy_100psy(1,1) = mean(subject1.initialSigma(2,:)); %20 trials, psy
allSubjects_AverageSigma_20psy_100psy(1,2) = mean(subject1.initialSigma(18,:)); %100 trials, psy
% subject2
allSubjects_AverageSigma_20psy_100psy(2,1) = mean(subject2.initialSigma(2,:)); %20 trials, psy
allSubjects_AverageSigma_20psy_100psy(2,2) = mean(subject2.initialSigma(18,:)); %100 trials, psy
% subject3
allSubjects_AverageSigma_20psy_100psy(3,1) = mean(subject3.initialSigma(2,:)); %20 trials, psy
allSubjects_AverageSigma_20psy_100psy(3,2) = mean(subject3.initialSigma(18,:)); %100 trials, psy
% subject4
allSubjects_AverageSigma_20psy_100psy(4,1) = mean(subject4.initialSigma(2,:)); %20 trials, psy
allSubjects_AverageSigma_20psy_100psy(4,2) = mean(subject4.initialSigma(18,:)); %100 trials, psy

%--------------------------------------
%------------     Mu     --------------
%--------------------------------------

%Mus for the repeated measures anova
%20 trials CSD vs 100 trials CSD

%Create the matrix for data storage, where subjects are rows
allSubjects_Mu_20CSD_100CSD = nan(4,12);

%Store the data from each subject
% subject1
allSubjects_Mu_20CSD_100CSD(1,1:6) = subject1.finalMu(2,:); %20 trials, CSD
allSubjects_Mu_20CSD_100CSD(1,7:12) = subject1.finalMu(18,:); %100 trials, CSD
% subject2
allSubjects_Mu_20CSD_100CSD(2,1:6) = subject2.finalMu(2,:); %20 trials, CSD
allSubjects_Mu_20CSD_100CSD(2,7:12) = subject2.finalMu(18,:); %100 trials, CSD
% subject3
allSubjects_Mu_20CSD_100CSD(3,1:6) = subject3.finalMu(2,:); %20 trials, CSD
allSubjects_Mu_20CSD_100CSD(3,7:12) = subject3.finalMu(18,:); %100 trials, CSD
% subject4
allSubjects_Mu_20CSD_100CSD(4,1:6) = subject4.finalMu(2,:); %20 trials, CSD
allSubjects_Mu_20CSD_100CSD(4,7:12) = subject4.finalMu(18,:); %100 trials, CSD


%--------------------------------------
%Mus for the repeated measures anova
%20 trials CSD vs 100 trials psy

%Create the matrix for data storage, where subjects are rows
allSubjects_Mu_20CSD_100psy = nan(4,12);

%Store the data from each subject
% subject1
allSubjects_Mu_20CSD_100psy(1,1:6) = subject1.finalMu(2,:); %20 trials, CSD
allSubjects_Mu_20CSD_100psy(1,7:12) = subject1.initialMu(18,:); %100 trials, psy
% subject2
allSubjects_Mu_20CSD_100psy(2,1:6) = subject2.finalMu(2,:); %20 trials, CSD
allSubjects_Mu_20CSD_100psy(2,7:12) = subject2.initialMu(18,:); %100 trials, psy
% subject3
allSubjects_Mu_20CSD_100psy(3,1:6) = subject3.finalMu(2,:); %20 trials, CSD
allSubjects_Mu_20CSD_100psy(3,7:12) = subject3.initialMu(18,:); %100 trials, psy
% subject4
allSubjects_Mu_20CSD_100psy(4,1:6) = subject4.finalMu(2,:); %20 trials, CSD
allSubjects_Mu_20CSD_100psy(4,7:12) = subject4.initialMu(18,:); %100 trials, psy

%--------------------------------------
%Mu for the repeated measures anova
%20 trials psy vs 100 trials psy

%Create the matrix for data storage, where subjects are rows
allSubjects_Mu_20psy_100psy = nan(4,12);

%Store the data from each subject
% subject1
allSubjects_Mu_20psy_100psy(1,1:6) = subject1.initialMu(2,:); %20 trials, psy
allSubjects_Mu_20psy_100psy(1,7:12) = subject1.initialMu(18,:); %100 trials, psy
% subject2
allSubjects_Mu_20psy_100psy(2,1:6) = subject2.initialMu(2,:); %20 trials, psy
allSubjects_Mu_20psy_100psy(2,7:12) = subject2.initialMu(18,:); %100 trials, psy
% subject3
allSubjects_Mu_20psy_100psy(3,1:6) = subject3.initialMu(2,:); %20 trials, psy
allSubjects_Mu_20psy_100psy(3,7:12) = subject3.initialMu(18,:); %100 trials, psy
% subject4
allSubjects_Mu_20psy_100psy(4,1:6) = subject4.initialMu(2,:); %20 trials, psy
allSubjects_Mu_20psy_100psy(4,7:12) = subject4.initialMu(18,:); %100 trials, psy