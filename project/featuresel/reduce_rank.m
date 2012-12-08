function [ outcell, outputX ] = reduce_rank( sparseX, rank )

% Initialize with counts
outputX = sparseX;

% Log
    %outputX = sparse(arrayfun(@(x) log(x+1), full(sparseX)));
% Boolean
    %outputX(outputX > 0) = 1;

%outputX = memory_data(outputX, 20);
    
outputX = outputX';
    
% Log Entropy (currently will take about 6 days for compile cutoff=500)

%temp = sparse(length(outputX(:,1)), length(outputX(1,:)));
%[r,c]=find(outputX);
%for i=1:length(r)
%    tic
%    lrc = log(outputX(r(i),c(i)) + 1);
%    gfr = full(sum(outputX(r(i),:)));
%    gr = 1;
%    newcols = find(outputX(r(i),:));
%    for jidx=1:length(newcols)
%        j = newcols(jidx);
%        prc = outputX(r(i),j)/gfr;
%        gr = gr + (prc * log(prc))/log(length(outputX(1,:)));
%    end
%    temp(r(i),c(i)) = gr * lrc;
%    toc
%    i/length(r)*100face
%end
%outputX = temp;


[U,S,V] = svds(outputX, rank);

outcell = cell(3);
outcell{1} = U;
outcell{2} = S;
outcell{3} = V;


end

