clear all

lambda = 3;
lambda1 = 1;
prob1 = 0.2;
lambda2 = 10;
prob2 = 0.8;

%%
%Performance indices of an M/G/1 queue
%The utilization of the system slide 20 L15
mean_hyper = prob1/lambda1 + prob2/lambda2;
D = mean_hyper; % D = average service time slide 16 L15
p1 = lambda*D; %traffic intensity
U1 = p1

%The average response time slide 21 L15
m2 = (2*prob1/lambda1^2 + 2*prob2/lambda2^2); % slide 16 L15
w1 = lambda*m2/2; % w = remaining service time slide 27 L15
R1 = D + w1/(1-p1)

%The average number of jobs in the system slide 19-20-21 L15
W = p1*w1/(1-p1); % slide 21 L15
A_prime1 = lambda*(w1+W); % slide 20 L15 A_prime = approximation
A1 = lambda*(D+w1+W); % slide 20 L15 A = number of jobs arrived
N1 = A1 % slide 19 L15

%%
%Approximate Performance indices of a G/G/2 queue

%The utilization of the system slide 35 L15
mean_uniform = (0.1+0.2)/2;
T = mean_uniform; % T = average inter-arrival time
p2 = D/(2*T); %slide 36 L15
U2 = p2

%The average response time slide 36 L15 Kingsman Formula
m2_uniform = (0.1^2+0.1*0.2+0.2^2)/3; %mean square slide 41 L04
var_uniform = m2_uniform - mean_uniform^2; %slide 17 L03
var_hyper = m2 - mean_hyper^2;
cv_uniform = sqrt(var_uniform)/mean_uniform;
cv_hyper = sqrt(var_hyper)/mean_hyper;
R2 = D + ((cv_uniform^2 + cv_hyper^2)/2) * p2^2*D/(1-p2^2)

%The average number of jobs in the system, Little's law X = 1/mean
N2 = (1/T)*R2
