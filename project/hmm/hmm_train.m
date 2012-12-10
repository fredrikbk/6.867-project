function [ A B ] = hmm_train( E, numZ, numE, Adiag, Budiag )
    E = hmm_norm(E);

    [A_guess, B_guess] = hmm_em_init(numZ, numE, Adiag, Budiag);
    [A, B] = hmmtrain(E, A_guess, B_guess, 'Maxiterations', 500);
end

