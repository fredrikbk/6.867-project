function [ theta ] = mm_train( X )
    K = 2;

    theta = zeros(K, K);

    % x values are normalized to {1,2}
    for i=2:length(X)
        x1 = normalize(X(i-1));
        x2 = normalize(X(i));

        theta(x1,x2) = theta(x1,x2)+1;
    end

    for i=1:K
        rowsum = sum(theta(i,:));
        for j=1:K
            theta(i,j) = theta(i,j) / rowsum;
        end

        assert(sum(theta(i,:)) == 1)
    end
end

