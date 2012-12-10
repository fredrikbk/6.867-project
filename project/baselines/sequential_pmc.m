function [ pmc_cum, pmc_ratio  ] = sequential_pmc( Y )
% Pick most common
    n = length(Y);
    w = 37;
    
    Yn = Y;
    for i=1:length(Yn)
        Yn(i) = (Yn(i)+3)/2;
    end
    
    pmc = zeros(n,1);
    
    classes = zeros(1,2);
    classes(Yn(w-1)) = 1;
    
    for i=w:n
        if classes(2) > classes(1)
            pmc(i) = (Y(i) ==  1);
        else
            pmc(i) = (Y(i) == -1);
        end
        classes(Yn(i)) = classes(Yn(i)) + 1;
    end
    
    pmc_cum = cumsum(pmc);
    pmc_ratio = pmc_cum ./ [zeros(1,w-1) 1:n-(w-1)]';
end

