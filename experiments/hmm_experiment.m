win = 30;
w = 2;
NUM_HIDDEN_STATES   = 2;
NUM_EMISSION_STATES = 2;
A_GUESS_DIAG  = 0.6;
B_GUESS_DIAG = 0.6;

n = length(Y);
phmm = zeros(n,1);
prhmm = zeros(n,2);
for i=2:n
    i
    [A B] = hmm_train(Y(max(1,i-win):i-1)', NUM_HIDDEN_STATES, NUM_EMISSION_STATES, A_GUESS_DIAG, B_GUESS_DIAG);
    [pred, pr] = hmm_predict(Y(max(1,i-win):i-1)', A, B);
    
    phmm(i) = (Y(i) == pred);
    prhmm(i,:) = pr;
end

phmm_cum = cumsum(phmm(:,1));
phmm_ratio = phmm_cum ./ [zeros(1,w-1) 1:n-(w-1)]';

clear A B pred pr n w win NUM_EMISSION_STATES NUM_HIDDEN_STATES A_GUESS_DIAG B_GUESS_DIAG i