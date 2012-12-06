function [ theta ] = nb_train( X, Y )
    classes = classify_data(X, Y);

    assert(length(classes{1}.class) == length(classes{2}.class));
    K = length(classes);
    D = length(classes{1}.class);
    
    theta = cell(K);
    for c=1:K
        theta{c} = zeros(1,D);
        num_yc = classes{c}.count;
        for j=1:length(classes{c}.class)
            num_xj1_yc = classes{c}.class(j);
            theta{c}(j) = (num_xj1_yc + 1) / (num_yc + 2);
        end
    end
end
