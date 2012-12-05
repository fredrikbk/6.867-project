Ynorm = Y;
Ynorm=Ynorm(randperm(length(Ynorm)));

for i=1:length(Ynorm)
    Ynorm(i) = (Ynorm(i)+3)/2;
end

A1 = rand(1);
A2 = rand(1);
A_guess = [0.8, 0.1, 0.1; ...
           0.1, 0.8, 0.1; ...
           0.1, 0.1, 0.8]

B1 = rand(1);
B2 = rand(1);
B3 = rand(1);
B_guess = [B1, 1-B1; ...
           B2, 1-B2
           B3, 1-B3]
         
[A, B] = hmmtrain(Ynorm, A_guess, B_guess)


%[predicted_Y,states] = hmmgenerate(length(Ynorm),A,B);


clear i;