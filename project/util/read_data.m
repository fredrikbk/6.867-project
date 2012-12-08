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
        labels.textdata(i)
        removelabel(end+1) = i;
    end
end

months = cell(1,12);
dates = labels.rowheaders;
dates(removelabel, :) = [];

for i=1:length(dates)
    month = str2num(strtok(dates{i},'/'));
    months{month} = [months{month} i];
end
december = months(12);
months(12) = [];

X = sparse(words.data(indices, :));
Y = labels.data;
Y(removelabel, :) = [];

clear i j removelabel indices broken dates month;
clear words;
clear labels;
clear removelabel;
