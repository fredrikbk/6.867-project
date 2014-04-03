w = 2;
n = length(Y);

[pmc_cum, pmc_ratio] = sequential_pmc(Y);

lw = 1.001;

%set(figure, 'Position', [800 100 900 320])
lw = 1.001;
C = {'k', 'r', 'm','g', 'b', 'c', [0.5 0.5 0.5]};
plot(w:n, pmc_ratio(w:n), 'LineWidth', lw, 'color', C{1});
axis([1 250 0.3 0.8])
hold;

length(phmmnb_ratio(1,:))

%plot(w:n, pnb_ratio(w:n), 'LineWidth', lw, 'color', 'b');
%axis([1 250 0.3 0.8])

plot(w:n, phmmnb_ratio(w:n), 'LineWidth', lw, 'color', 'm');
axis([1 250 0.3 0.8])

plot(w:n, phmm_ratio(w:n), 'LineWidth', lw, 'color', 'r');
axis([1 250 0.3 0.8])

plot(w:n, pnbevpri_ratio(w:n), 'LineWidth', lw, 'color', 'c');
axis([1 250 0.3 0.8])



set(gca,'YAxisLocation','right');
set(gca, 'YTick', [0.3, 0.5,  0.5565, 0.5726, 0.8]);
set(gca, 'YTickLabel', {'30%', '50%', '55.7%', '57.3%' '80%'});
ylabel('Ratio of correct guesses.');
xlabel('Days');

ymax = max(Y_cum);
Y_cumt = zeros(1,length(Y_cum));
for i=1:length(Y_cum)
    Y_cumt(i) = (0.39 * Y_cum(i) / ymax) + 0.3;
end
plot(1:n, Y_cumt, '--g');

plot(w:n, pmc_ratio(w:n), 'LineWidth', lw, 'color', C{1});
axis([1 250 0.3 0.8])


legend('pick-most-common and Naive Bayes with Sample Prior', ...
    'Naive Bayes with Hidden Markov Model Prior', ...
    'Hidden Markov Model', ...
    'Naive Bayes with Uniform Prior', ...
    'Dow Jones Performance');

hold

clear C lw w n ymax ans i Y_cumt;