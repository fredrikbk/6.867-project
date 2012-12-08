function [ theta ] = mm_train( Y, M )
    % normalize Y values to {1,2}
    for i=1:length(Y)
        Y(i) = normalize(Y(i));
    end
    
    K = 2;
    theta = zeros(K * ones(1,M+1));
    for i=1+M:length(Y)
        theta(mmidx(Y(i-M:i))) = theta(mmidx(Y(i-M:i))) + 1;
    end
    
    return
    
    for i=1:K
        rowsum = sum(theta(i,:));
        for j=1:K
            theta(i,j) = theta(i,j) / rowsum;
        end

%        assert(sum(theta(i,:)) == 1)
    end
end

