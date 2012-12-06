M = 20;
N = length(X(:,1));

boosted_stumps = adaboost_train(X, Y, M);

print_boosted_stumps(boosted_stumps);

for m=1:M
    mfirst_boosted_stumps = boosted_stumps(1:m);

    numcorrect = 0;
    for n=1:N
        if adaboost_predict(X(n,:), mfirst_boosted_stumps) == Y(n)
            numcorrect = numcorrect + 1;
        end
    end

    fprintf(1, 'Predictor on first %d stumps got %d/%d (%.2f%%) correct\n\n', ...
            m, numcorrect, N, 100*numcorrect/N);
end

clear M N m n
clear boosted_stumps
clear numcorrect
clear mfirst_boosted_stumps