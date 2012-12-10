w = 2;
n = length(Y);

phmmnb = zeros(n,1);
pnb = zeros(n,1);
pnbevpri = zeros(n,1);
for i=w:n
    i
    nb = nb_train_prior(X(1:i-1,:), Y(1:i-1), prhmm(i,:));
    phmmnb(i) = (Y(i) == nb_predict(X(i,:), nb));
    
    numcm1 = length(find(Y(1:i-1)-1));
    numcp1 = length(find(Y(1:i-1)+1));
    pcm1 = numcm1 / (numcm1 + numcp1);
    pcp1 = numcp1 / (numcm1 + numcp1);
    
    nb = nb_train_prior(X(1:i-1,:), Y(1:i-1), [pcm1 pcp1]);
    pnb(i) = (Y(i) == nb_predict(X(i,:), nb));
    
    nb = nb_train_prior(X(1:i-1,:), Y(1:i-1), [0.5 0.5]);
    pnbevpri(i) = (Y(i) == nb_predict(X(i,:), nb));
    
end

phmmnb_cum = cumsum(phmmnb(:,1));
phmmnb_ratio = phmmnb_cum ./ [zeros(1,w-1) 1:n-(w-1)]';

pnb_cum = cumsum(pnb(:,1));
pnb_ratio = pnb_cum ./ [zeros(1,w-1) 1:n-(w-1)]';

pnbevpri_cum = cumsum(pnbevpri(:,1));
pnbevpri_ratio = pnbevpri_cum ./ [zeros(1,w-1) 1:n-(w-1)]';

clear n i w nb;