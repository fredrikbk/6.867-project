function [ prediction, pr_yip1 ] = hmm_predict( E, A, B )
    E = hmm_norm(E);

    pr_Z = hmmdecode(E,A,B)';
    
    pr_zi   = pr_Z(end,:);
    pr_zip1 = pr_zi * A;
    pr_yip1 = pr_zip1 * B;
    
    if pr_yip1(2) >= pr_yip1(1)
        prediction = hmm_denorm(2);
    else
        prediction = hmm_denorm(1);
    end
    
    pr_yip1 = fliplr(pr_yip1);
end

