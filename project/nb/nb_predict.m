function [ prediction ] = nb_predict( X, nb )
    pi = nb.pi;
    theta = nb.theta;

    K = length(theta(:,1));
    D = length(theta(1,:));

    pr = zeros(K, 1);
    for c=1:K
        for j=1:D
            t_cj = theta(c,j);
            xj = X(j) > 0;
            pr_xj = (xj*log(t_cj) + (1 - xj)*log(1-t_cj));
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

