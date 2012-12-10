w = 2;
NUM_HIDDEN_STATES   = 2;
NUM_EMISSION_STATES = 2;
A_GUESS_DIAG  = 0.6;
B_GUESS_DIAG = 0.6;

n = length(Y);
phmm = zeros(n,1);
for i=2:n
    i
    [A B] = hmm_train(Y(1:i-1)', NUM_HIDDEN_STATES, NUM_EMISSION_STATES, A_GUESS_DIAG, B_GUESS_DIAG);
    phmm(i) = (Y(i) == hmm_predict(Y(1:i-1)', A, B));
end

phmm_cum = cumsum(phmm(:,1));
phmm_ratio = phmm_cum ./ [zeros(1,w-1) 1:n-(w-1)]';

clear w NUM_EMISSION_STATES NUM_HIDDEN_STATES A_GUESS_DIAG B_GUESS_DIAG i