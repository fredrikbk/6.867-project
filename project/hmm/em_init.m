function [ A_guess, B_guess ] = em_init( num_Z, numX, Adiag, Budiag)
    A_guess = zeros(num_Z);
    for i=1:num_Z
        for j=1:num_Z
            if i == j
                A_guess(i,j) = Adiag;
            else
                A_guess(i,j) = (1-Adiag) / (num_Z-1);
            end
        end
    end

    B_guess = zeros(num_Z, numX);
    % Fill out upper diagonal
    for i=1:numX
        for j=1:numX
            if i == j
                B_guess(i,j) = Budiag;
            else
                B_guess(i,j) = (1-Budiag) / (numX-1);
            end
        end
    end
    % Fill out the rest
    for i=numX+1:num_Z
        for j=1:numX
            B_guess(i,j) = 1/numX;
        end
    end
end
