function [words] = import_words()
    words = importdata('text/results.counts');
    words = words.rowheaders;
end