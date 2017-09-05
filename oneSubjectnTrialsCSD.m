function output = oneSubjectnTrialsCSD(filename, nTrials)
    opts = optimset('fminsearch');
    opts.TolX = 1.e-4;
    opts.TolFun = 1.e-4;

    %Read in the data from the file
    allData = xlsread(filename);

    coherence = allData(:,14);
    coherent_direction = allData(:,13);
    % Get the indexes of those which are going left
    indexLeftDirection = (coherent_direction == 180);
    % Convert the coherences to negative if they are going left
    coherence(indexLeftDirection) = -(coherence(indexLeftDirection));
    % Get the indexes of the RDK trials
    indexRDK = ~isnan(coherence);

    %Distill the coherence out
    coherence = coherence(indexRDK);
    %Delete the practice trials
    coherence(1:10,:) = [];

    %Get the indexes of the similarity trials
    indexSimilarity = ~isnan(allData(:,26));
    %Distill the sim_score out
    sim_score = allData(indexSimilarity,26);
    %Delete the practice trials
    sim_score(1:10,:) = [];

    %Get the index of those that are chosen right
    rightChoice = (sim_score > 50);
    

    %Truncate the data based on how many trials there are
    rightChoice = rightChoice(1:nTrials,1);
    coherence = coherence(1:nTrials, 1);
    sim_score = sim_score(1:nTrials, 1);
    
    %Convert the confidence into percentage (y-axis)
    confidence = sim_score./100;

    
    % ==============================================
    % Step B: 

    %[mean1, slope1, guessRate1, lapseRate1] 
    % disp('-------------------------------------');
    % disp('Psychometric function on binomial data with free lapse and guess rates:');
    % disp('    mean      slope      guess      lapse');
    % parameters1 = psychometricFit(coherence,rightChoice,0,0,0);
    % disp(parameters1);


    %This is the Psychometric function that we will use
    disp('-------------------------------------');
    disp('Psychometric function on binomial data with 0 guess and 0 lapse rates:');
    disp('    mean      slope');
    parameters2 = psychometricFit2Parameters(coherence,rightChoice,0,0,0);
    disp(parameters2);

    %Store what we need in variables
    mu = parameters2(1);
    slope = parameters2(2);
    sigma = 1/slope;

    % ==============================================
    % Step C: 

    %This is irrelevant as only k will be the free parameter
    % disp('-------------------------------------');
    % disp('Confidence function with mean, slope, and k as free parameters:');
    % disp('    mean      slope      scalar');
    % parameters3 = psychometricFit3Parameters(coherence,confidence,0,0,0);
    % disp(parameters3);


    %This is the function that we will use
    disp('-------------------------------------');
    disp('Confidence function with only k as the free parameter');
    disp('    scalar');
    parameters4 = psychometricFit1Parameter(coherence,confidence,mu,slope,0,0,0);
    disp(parameters4);

    k = parameters4;

    % ==============================================
    % Step D: 

    %Preallocate for matrix to hold lower bin limit (col 1) and uper bin limit
    %(col 2)
    binLimits = nan(length(confidence),2);

    %Fill in the bin
    binLimits(:,1) = confidence(:,1) - 0.005;
    binLimits(:,2) = confidence(:,1) + 0.005;


    % ==============================================
    % Step E: 

    %Assignment has been done above in step C.
    % mu sigma k


    % ==============================================
    % Return the initial values in an array

    %The initial guessing values for fmincon, to be varied
    x0 = [mu, sigma, k]

    % ==============================================
    % Steps F to H: 

    %Create an anonymous function to be used in fmincon
    %This gets us around the problem where some variables need to be fixed (the 
    %original mu, sigma,and k) and others need to be changed to be optimized 
    %(those in x0).
    f = @(x) stepsFtoH(x,mu,sigma,confidence,binLimits,coherence);


    % ==============================================
    % Step G
    %[finalX,fval, exitflag, output, lambda, grad, hessian] = fmincon(f,x0,[],[],[],[],[-0.5 0 0],[0.5 3 30]);
    finalX = fminsearchbnd(f,x0,[-0.5 0 0],[0.5,3,10],opts);

    finalMu = finalX(1);
    finalSigma = finalX(2);
    finalK = finalX(3);

    output = [finalMu, finalSigma, finalK];
   

end