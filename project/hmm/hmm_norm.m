function [ Yn ] = hmm_norm( Y )
    Yn = Y;
    % Yn {-1, 1} -> {2,1}
    for i=1:length(Yn)
        if Yn(i) == -1
            Yn(i) = 2;
        end
    end
end

