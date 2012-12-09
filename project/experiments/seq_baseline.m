Yn = Y;
% Normalize Yn to {1,2}
for i=1:length(Yn)
    Yn(i) = (Yn(i)+3)/2;
end

w = 2;
n = length(Yn);

pick_most_common = zeros(n,1);
pick_most_common_window = zeros(n,1);
pick_previous = zeros(n,1);

classes = zeros(1,2);
classes(Yn(w-1)) = 1;
prev = Yn(w-1);

for i=w:n
    if classes(2) > classes(1)
        pick_most_common(i) = (Y(i) ==  1);
    else
        pick_most_common(i) = (Y(i) == -1);
    end
    
    c1 = 0;
    c2 = 0;
    for j=max(i-window, 1):i-1
        if Y(j) == -1
            c1 = c1 + 1;
        else
            c2 = c2 + 1;
        end
    end
    if c2 > c1
        pick_most_common_window(i) = (Y(i) ==  1);
    else
        pick_most_common_window(i) = (Y(i) == -1);
    end
    
    pick_previous(i) =  (Y(i) == ((prev * 2)-3));
    
    classes(Yn(i)) = classes(Yn(i)) + 1;
    prev = Yn(i);
end


pick_most_common_cum = cumsum(pick_most_common);
pick_most_common_window_cum = cumsum(pick_most_common_window);
pick_previous_cum = cumsum(pick_previous);

pick_most_common_ratio = pick_most_common_cum ./ (0:248)';
pick_previous_ratio = pick_previous_cum ./ (0:248)';

% Plot
set(figure, 'Position', [800 100 600 150])
[AX,L1,L2] = plotyy(w:n, pick_most_common_cum(w:n), w:n, pick_most_common_ratio(w:n));
set(AX(1),'YLim',[0 248])
set(AX(2),'YLim',[0 1])
set(AX(2), 'YTick', [0, 0.5726, 1]);
set(AX(2), 'YTickLabel', {'0%' '57.3%' '100%'});
set(get(AX(1),'Ylabel'),'String','Number of correct guesses.') 
set(get(AX(2),'Ylabel'),'String','Ratio of correct guesses.') 

legend(L1, 'pick-most-common');

xlabel('Days')

hold;

[AX,L1,L2] = plotyy(w:n, pick_previous_cum(w:n), w:n, pick_previous_ratio(w:n));
set(AX(1),'YLim',[0 248]);
set(AX(1), 'YTick', [0 123 142 248]);
set(AX(2),'YLim',[0 1])
set(AX(2), 'YTick', [0.4960]);
set(AX(2), 'YTickLabel', {'49.6%'});
set(L1,'LineStyle','-.')
set(L2,'LineStyle','-.')

legend(L1, 'pick-previous');


hold;

clear labels labels_modif;
clear w n i prev Yn classes haxes hline1 hline2;
clear pick_most_common pick_previous;
%clear pick_most_common_cum pick_previous_cum;
%clear pick_most_common_ratio pick_previous_ratio;