function [ nb ] = nb_train( X, Y )
    X(X>1) = 1;
    
    nb = struct();
    classes = classify_data(X, Y);
    
    K = length(classes);
    D = length(classes{1}.class);
    
    % pi
    nb.pi = zeros(1,K);
    for c=1:K
        nb.pi(c) = classes{c}.count/length(Y);
    end
    
    % theta
    nb.theta = cell(1,K);
    for c=1:K
        nb.theta{c} = zeros(1,D);
        num_yc = classes{c}.count;
        for j=1:length(classes{c}.class)
            num_xj1_yc = classes{c}.class(j);
            nb.theta{c}(j) = (num_xj1_yc + 1) / (num_yc + 2);
        end
    end
end
