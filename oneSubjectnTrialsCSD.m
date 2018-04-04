function output = oneSubjectnTrialsCSD(filename, nTrials)

    %Read in the data from the file
    allData = xlsread(filename);
    
    %Get all data in the coherence column
    coherence = allData(:,14);
    %Get all the data in the coherent_direction column
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
    indexSimilarity = ~isnan(allData(:,28));
    %Distill the sim_score out
    sim_score = allData(indexSimilarity,28);
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


    % Initiate CSD
    output = startCSD(coherence, rightChoice, confidence);


end