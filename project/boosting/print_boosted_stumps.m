function print_boosted_stumps( boosted_stumps )
    words = import_words();
    for i=1:length(boosted_stumps)
        alpha = boosted_stumps{i}.alpha;
        word = words{boosted_stumps{i}.stump.d};
        s = boosted_stumps{i}.stump.s;
        fprintf(1, 'alpha: %.3f\nstump: %s (%d)\n\n', alpha, word, s);
    end
end

