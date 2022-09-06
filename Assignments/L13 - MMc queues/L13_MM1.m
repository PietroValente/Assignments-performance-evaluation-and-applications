%Performance indices of an M/M/1 queue
lambda = 0.95;
D1 = 0.9; 
p1 = lambda*D1; %traffic intensity

U1=p1 % U1 = p1 and also the average utilization

%Compute the probability of having 4 jobs in the system slide 32 L12
pi1_4 = (1-p1)*p1^4

%Compute the average number of jobs in the system slide 35 L12
N1 = (p1)/(1-p1)

%Compute the average response time R and the average time spent in the
%queue slide 36 L12
R1 = D1/(1-p1)
O1 = p1*D1/(1-p1)