maxM = 50;

w = maxM+1;

n = length(Y);
Yn = Y;
% Normalize Yn to {1,2}
for i=1:length(Yn)
    Yn(i) = (Yn(i)+3)/2;
end
pmm = zeros(n,maxM);
pmm_cum = zeros(n, maxM);
pmm_ratio = zeros(n, maxM);
for M=1:maxM
    tic
    
    for i=M+1:n
        theta = mm_train( Y(1:i-1), M );
        pmm(i,M) = Y(i) == mm_predict(Y(i-M:i-1), theta);
    end
    
    pmm_cum(:,M) = cumsum(pmm(:,M));
    pmm_ratio(:,M) = pmm_cum(:,M) ./ [zeros(1,M) 1:n-M]';
    
	fprintf('%d: %f\n', M, pmm_ratio(end,M));
    
    toc
end

return

[pmc_cum, pmc_ratio] = sequential_pmc(Y);

% Plot
set(figure, 'Position', [800 100 900 320])
lw = 1.001;
C = {'k', 'r', 'm','g', 'b', 'c', [0.5 0.5 0.5]};
plot(2:n, pmc_ratio(2:n), 'LineWidth', lw, 'color', C{1});
axis([1 250 0.3 0.8])
hold;
for M=1:maxM
    plot(M+1:n, pmm_ratio(M+1:n,M), 'LineWidth', lw, 'color', C{M+1});
    axis([1 250 0.3 0.8])
end

set(gca,'YAxisLocation','right');
set(gca, 'YTick', [0.3, 0.5, 0.5385, 0.5726, 0.8]);
set(gca, 'YTickLabel', {'30%', '50%', '53.9%', '57.3%' '80%'});
ylabel('Ratio of correct guesses.');
xlabel('Days')


legend('pick-most-common','M=1', 'M=2', 'M=3', 'M=4', 'M=5', 'M=6');

hold;

%clear i n w Yn maxM theta theta pmc_cum pmc_ratio pmm_cum pmm_ratio;