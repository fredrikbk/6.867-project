function [ idx ] = mmidx( coords )
    coords = fliplr(coords);
    dims = 2*(ones(length(coords)));

    idx = coords(1);
    for c=2:length(coords)     
        idx = idx + (coords(c)-1) * prod(dims(1:c-1));
    end
end
