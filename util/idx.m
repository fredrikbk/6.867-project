function [ idx ] = idx( coords, dims )
    coords = fliplr(coords);
    dims = fliplr(dims);

    idx = coords(1);
    for c=2:length(coords)     
        idx = idx + (coords(c)-1) * prod(dims(1:c-1));
    end
end

