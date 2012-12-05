A = [0.8, 0.2; ...
     0.2, 0.8]
 
phi = [0.9, 0.1; ...
       0.1, 0.9]

[seq,states] = hmmgenerate(10,A,phi)