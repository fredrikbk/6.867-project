Y_cum = cumsum(Y);

figure('Position', [800 100 500 200]);
plot(1:n, Y_cum);
axis([1 250 0 40])
xlabel('Days');
ylabel('Movement since January 1');
set(gca,'YAxisLocation','right');
set(gca, 'YTick', [0 10 20 30 38]);