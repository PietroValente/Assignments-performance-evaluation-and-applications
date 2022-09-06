%Performance indices of an M/M/3 queue
c3=3;
lambda = 0.95;
D3 = 2.7;

%Compute the average utilization slide 30 L13
U3 = lambda*D3;
averageU3 = U3/c3
p3 = averageU3;

%Compute the probability of having 4 jobs in the system slide 30 L13
pi_03 = (((c3*p3).^c3/6) * (1 / (1-p3)) + 1 + c3*p3 + (((c3.^2)*(p3.^2)) / 2)).^(-1);
pi3_4 = pi_03*(c3^c3)*p3^4/6

%Compute the average number of jobs in the system slide 31 L13
N3 = c3*p3+(p3/(1-p3))/(1+((1-p3)*(6/(c3*p3)^c3)*(1+c3*p3+(c3^2)*p3^2/2)))

%Compute the average response time R and the average time spent in the
%queue slide 31 L13
R3 = D3+(D3/(c3*(1-p3)))/(1+((1-p3)*(6/(c3*p3)^c3)*(1+c3*p3+(c3^2)*p3^2/2)))
O3 = (D3/(c3*(1-p3)))/(1+((1-p3)*(6/(c3*p3)^c3)*(1+c3*p3+(c3^2)*p3^2/2)))
