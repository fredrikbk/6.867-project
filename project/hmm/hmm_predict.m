function [ prediction ] = hmm_predict( E, A, B )
    E = hmm_norm(E);

    pr_Z = hmmdecode(E,A,B)';
    
    pr_zi   = pr_Z(end,:);
    pr_zip1 = pr_zi * A;
    pr_xip1 = pr_zip1 * B;
    
    if pr_xip1(2) >= pr_xip1(1)
        prediction = hmm_denorm(2);
    else
        prediction = hmm_denorm(1);
    end
end

