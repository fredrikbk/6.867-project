%Z -> E
E = Y';

NUM_EMISSION_STATES = 2;
NUM_HIDDEN_STATES   = 3;

% Normalize Z to {1,2}
for i=1:length(E)
    E(i) = (E(i)+3)/2;
end

% Create initial guesses for the EM algorithm
Adiag  = 0.9;  % rand(1)/2 + 1/2;
Budiag = 0.5;  % rand(1)/2 + 1/2;
[A_guess, B_guess] = em_init(NUM_HIDDEN_STATES, NUM_EMISSION_STATES, Adiag, Budiag);
A_guess;
B_guess;
         
[A, B] = hmmtrain(E, A_guess, B_guess)

pr_Z = hmmdecode(E(1:i),A,B);

% Test and validate
predictions = length(E);
numcorrect = 0;
for i=1:length(E)-1
    
    
    
    % Compute the posterior probabilities on Z for E(1:i)
    pr_Z = hmmdecode(E(1:i),A,B)';
    
    pr_zi   = pr_Z(i,:); 
    pr_zip1 = pr_zi * A;
    E(i)
    pr_xip1 = pr_zip1 * B

    if pr_xip1(2) > 0.5743  %pr_xip1(1)
        %fprintf('predicted: 1. Correct: %d\n', Y(i+1));
        if Y(i+1) == 1
            numcorrect = numcorrect + 1;
        end
    else
        %fprintf('predicted: -1. Correct: %d\n', Y(i+1));
        if Y(i+1) == -1
            numcorrect = numcorrect + 1;
        end
    end
    
    
    % Predict the next day
%    predictions[i+1] = 
end
fprintf('numcorrect: %d\n', numcorrect);

%numpred = length(E);
%[Epred,Zpred] = hmmgenerate(numpred,A,B);
%for i=1:length(E)
%    fprintf('%d, %d\n', E(i), Epred())
%end

%validate(@(x) x, predicted_E', Y)

fprintf('\n\n');
clear i A_guess B_guess Budiag Adiag NUM_EMISSION_STATES NUM_HIDDEN_STATES;
