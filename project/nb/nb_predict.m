function [ prediction ] = nb_predict( X, theta, pi )
    K = length(theta);
    D = length(theta{1});

    pr = zeros(K, 1);
    for c=1:K
        for j=1:D
            t_cj = theta{c}(j);
            pr_xj = (X(j)*log(t_cj) + (1 - X(j))*log(1-t_cj));
            pr_cj = pr_xj + log(pi(c));
            pr(c) = pr(c) + pr_cj;
        end
    end
    
    if pr(1) > pr(2)
        prediction = -1;
    else
        prediction = 1;
    end 
end

