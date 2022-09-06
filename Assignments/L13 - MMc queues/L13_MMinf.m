%Performance indices of an M/M/inf queue
lambda = 0.95;
Dinf = 9;

%Compute the average utilization slide 35 L13
Uinf = lambda*Dinf
pinf = Uinf;

%Compute the probability of having 4 jobs in the system slide 39 L13
pi_inf_4 = exp(-pinf)*(pinf^4/24)

%Compute the average number of jobs in the system slide 35 L13
Ninf = lambda*Dinf %equal to Uinf

%Compute the average response time R and the average time spent in the
%queue slide 35 L13
Rinf = Dinf
%Oinf = 0 because in infinite servers every arrival job has never to wait!;
Oinf = 0