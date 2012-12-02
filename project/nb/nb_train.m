function [ theta ] = nb_train( examples )
    assert(length(examples{1}.training_vector_sums) == length(examples{2}.training_vector_sums));
    K = length(examples);
    D = length(examples{1}.training_vector_sums);
    
    theta = cell(K);
    for c=1:K
        theta{c} = zeros(1,D);
        num_yc = examples{c}.num_training_vectors;
        nz_idx = find(examples{c}.training_vector_sums);
        for tmp=1:length(nz_idx)
            j = nz_idx(tmp);
            num_xj1_yc = examples{c}.training_vector_sums(j);
            theta{c}(j) = (num_xj1_yc + 1) / (num_yc + 2);
        end
        
        theta{c}(theta{c} == 0) = 1 / (num_yc + 2);
    end
end
