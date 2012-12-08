%Z -> E
E = Y';

NUM_EMISSION_STATES = 2;
NUM_HIDDEN_STATES   = 2;

% Normalize Z to {1,2}
for i=1:length(E)
    E(i) = (E(i)+3)/2;
end

% Create initial guesses for the EM algorithm
Adiag  = 0.6;  % rand(1)/2 + 1/2;
Budiag = 0.6;  % rand(1)/2 + 1/2;
[A_guess, B_guess] = em_init(NUM_HIDDEN_STATES, NUM_EMISSION_STATES, Adiag, Budiag);

% Test and validate
predictions = length(E);
numpred = 0;
numcorrect = 0;
window = 30;
for i=window+1:length(E)-1
    fprintf('\n\nObserved %d:%d\n-------------\n', i-window, i);
    
    [A, B] = hmmtrain(E(i-window:i), A_guess, B_guess, 'Maxiterations',500)
    
    % Compute the posterior probabilities on Z for E(1:i)
    pr_Z = hmmdecode(E(i-window:i),A,B)';
    
    pr_zi   = pr_Z(length(pr_Z),:); 
    pr_zip1 = pr_zi * A;
    pr_xip1 = pr_zip1 * B

    numpred = numpred + 1;
    if pr_xip1(1) >= pr_xip1(2)  %pr_xip1(1)
        fprintf('predicted: -1. Correct: %d\n', Y(i+1));
        if Y(i+1) == -1
            numcorrect = numcorrect + 1;
        end
    else
        fprintf('predicted: 1. Correct: %d\n', Y(i+1));
        if Y(i+1) == 1
            numcorrect = numcorrect + 1;
        end
    end
    
    
    % Predict the next day
%    predictions[i+1] = 
end
fprintf('numcorrect: %d/%d (%.2f%%)\n', numcorrect, numpred, 100*numcorrect/numpred);

%numpred = length(E);
%[Epred,Zpred] = hmmgenerate(numpred,A,B);
%for i=1:length(E)
%    fprintf('%d, %d\n', E(i), Epred())
%end

%validate(@(x) x, predicted_E', Y)

fprintf('\n\n');
clear i A_guess B_guess Budiag Adiag NUM_EMISSION_STATES NUM_HIDDEN_STATES;
