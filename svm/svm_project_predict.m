function [prediction] = svm_project_predict(x, context, fn, C)

    X = context{2};
    Y = context{3};
    alphas = context{1};

    % Define the predictSVM(x) function, which uses trained parameters
    Sidx = arrayfun(@(x) 0.001 < x         , alphas);
    Midx = arrayfun(@(x) 0.001 < x && x < C, alphas);

    w0 = 0;
    for j = 1:length(Midx)
        if Midx(j) == 1
            soln = 0;
            for i = 1:length(Sidx)
                soln = soln + alphas(i)*Y(i)*fn(X(j,:),X(i,:)); 
            end
            soln = Y(j) - soln;
            w0 = w0 + soln;
        end
    end

    w0 = w0 / sum(Midx);
    prediction = sign(sum(kern_map(x', X, fn) * diag(alphas) * diag(Y) * diag(Midx)) + w0);

end