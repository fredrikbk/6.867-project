function [ prediction ] = nb_predict( X, theta )
    X

    K = length(theta(:,1));
    D = length(theta(1,:));

    pr = zeros(K, 1);
    for c=1:K
        for j=1:D
            t_cj = theta{c}(j);
            prxj = (X(j)*log(t_cj) + (1 - X(j))*log(1-t_cj));
            pr(c) = pr(c) + prxj;
        end
    end
    
    if pr(1) > pr(2)
        prediction = 0;
    else
        prediction = 1;
    end 
end

