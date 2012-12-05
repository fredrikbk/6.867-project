function [ d,s ] = adaboost_train( X, Y, M )
    X = uint32(full(X));
    
    N = length(X(:,1));
    D = length(X(1,:));
    
    W = ones(N) * 1/N;
    
    for m=1:M
        [d,s] = stump_train(X, Y, W);
    end
end
