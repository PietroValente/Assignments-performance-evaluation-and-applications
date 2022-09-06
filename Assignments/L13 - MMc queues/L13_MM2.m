%Performance indices of an M/M/2 queue
c2=2;
lambda = 0.95;
D2 = 1.8;

%Compute the average utilization slide 25 L13
U2 = lambda*D2;
averageU2 = U2/c2
p2 = averageU2;

%Compute the probability of having 4 jobs in the system slide 25 L13 
pi2_4 = 2*((1-p2)/(1+p2))*p2^4

%Compute the average number of jobs in the system slide 26 L13
N2 = 2*p2/(1-p2^2)

%Compute the average response time R and the average time spent in the
%queue slide 27 L13
%from little's law
R2 = D2/(1-p2^2)
O2 = p2^2*D2/(1-p2^2)
