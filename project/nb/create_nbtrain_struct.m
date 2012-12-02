function [ example ] = create_nbtrain_struct( X, count )
    example = struct('num_training_vectors', count, 'training_vector_sums', sparse(1,length(X)));
    example.training_vector_sums = X
end

