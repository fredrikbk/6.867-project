w = 2;

[pmc_cum, pmc_ratio] = sequential_pmc(Y);

lw = 1.001;

%set(figure, 'Position', [800 100 900 320])
lw = 1.001;
C = {'k', 'r', 'm','g', 'b', 'c', [0.5 0.5 0.5]};
plot(w:n, pmc_ratio(w:n), 'LineWidth', lw, 'color', C{1});
axis([1 250 0.3 0.8])
hold;

length(phmm_ratio(1,:))
for i=1:length(phmm_ratio(1,:))
    plot(w:n, phmm_ratio(w:n,i), 'LineWidth', lw, 'color', C{i+1});
    axis([1 250 0.3 0.8])
end

set(gca,'YAxisLocation','right');
set(gca, 'YTick', [0.3, 0.5, 0.5484, 0.5726, 0.8]);
set(gca, 'YTickLabel', {'30%', '50%', '54.8%', '57.3%' '80%'});
ylabel('Ratio of correct guesses.');
xlabel('Days')


ymax = max(Y_cum);
Y_cumt = zeros(1,length(Y_cum));
for i=1:length(Y_cum)
    Y_cumt(i) = (0.42 * Y_cum(i) / ymax) + 0.3;
end
plot(1:n, Y_cumt, '--g');

legend('pick-most-common','Hidden Markov Model', 'Dow Jones Performance');

hold