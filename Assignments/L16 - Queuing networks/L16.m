clear all
%The system is stable because for every tier lambda is minor than
%1/D(service demand) so X = lambda

lambda = 10;
X = lambda;
D1 = 0.085;
D2 = 0.075;
D3 = 0.050;

%%
%The utilization of the three stations slide 40 L16
U1 = X*D1
U2 = X*D2
U3 = X*D3

%%
%The average number of jobs in the three stations slide 56 L16
%Nk = lambda * Rk
N1 = U1/(1-U1)
N2 = U2/(1-U2)
N3 = U3/(1-U3)

%%
%The average system response time slide 55-45 L16
R = D1/(1-U1)+D2/(1-U2)+D3/(1-U3)