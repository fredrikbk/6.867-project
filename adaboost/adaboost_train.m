function [ G ] = adaboost_train( X, Y, M )
    X = uint32(full(X));
    
    n = length(X(:,1));
    w = ones(1,n) * 1/n;
    
    G = cell(1,M);
    for m=1:M
        Gm = stump_train(X, Y, w);

        I = zeros(1,n);
        for i=1:n
            if stump_predict(X(i,:), Gm) ~= Y(i)
                I(i) = 1;
            end
        end

        Ew = sum(w .* I) / sum(w);
        alpha = log((1-Ew) / Ew);

        G{m} = struct('alpha', alpha, 'stump', Gm);

        % Update weigths
        w = w .* exp(alpha * I);
    end
end
