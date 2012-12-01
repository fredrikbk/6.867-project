function [ prediction ] = nb_predict( wordcounts, theta )
    k = length(theta(:,1));
    D = length(theta(1,:));

    pr = zeros(k, 1);
    for c=1:k
        for j=1:D
            x_j = wordcounts(j);
            t_cj = theta(c,j);
            prxj = (x_j*log(t_cj) + (1 - x_j)*log(1-t_cj));
            pr(c) = pr(c) + prxj;
        end
    end
    
    if pr(1) > pr(2)
        prediction = 0;
    else
        prediction = 1;
    end 
end

