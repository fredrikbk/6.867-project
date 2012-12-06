function [ accuracy ] = validate( predictor, X, Y )
    N = length(Y);

    numcorrect = 0;
    for i=1:N
        if predictor(X(i,:)) == Y(i)
            numcorrect = numcorrect + 1;
        end
    end
    accuracy = numcorrect / N;
end

