words = importdata('text/results.txt');



labels = importdata('dow_2007.txt');

removelabel = [];

indices = [];
for i=1:length(labels.textdata)
    broken = 0;
    for j=1:length(words.textdata)
        if(strcmp(words.textdata(j), labels.textdata(i)))
            indices(end+1) = j;
            broken = 1;
            break
        end
    end
    if ~broken
        fprintf(2, 'No WSJ for %d\n', i);
        removelabel(end+1) = i;
    end
end

sparseX = sparse(words.data(indices, :));
Y = labels.data;
Y(removelabel, :) = [];

clear words;
clear labels;