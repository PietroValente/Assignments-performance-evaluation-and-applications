clear all

lambda = 10;
D = 85/1000;   %from ms to s

%%
% utilization U = p, p is traffic intensity slide 33/35 L12
p = lambda*D

%%
% probability of having exactly one job in the system slide 32 L12
p_n1 = p - p^2 %probability of n>0 minus probability of n>1

%%
%probability of having more than 5 jobs in the system slide 34 L12
p_n5 = p^6

%%
%average queue length (job in system, but not in service) slide 37 L12
Nq = (p^2)/(1-p)

%%
%average response time slide 36 L12
%from little's law
R = D/(1-p)

%%
%probability that the response time is greater than 0.5 s slide 39 L12
mu = 1/D;
p_r05 = exp(-0.5*(mu-lambda))
p_ro5_2 = exp(-0.5/R) %are the same

%%
%90 percentile of the response time distribution slide 39 L12
p_90 = -log(1-90/100)*R