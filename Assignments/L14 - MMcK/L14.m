clear all

%%
%Performance indices of an M/M/1/6 queue
lambda1 = 0.9;
D1 = 1; 
p1 = lambda1*D1;

%%
%Performance indices of an M/M/2/6 queue
lambda2 = 1.8;
D2 = 1; 
p2 = lambda2*D2/2;

%%
%Compute the probability of having 4 jobs in the system
% p0 = empty system probability slide 22 L14
p_01 = (1-p1)/(1-p1^7); %one core, c=1
p_41 = ((1-p1)/(1-p1^7))*p1^4;

%slide 26 L14
p_02 = (((2*(p2^2)*(1-p2^5))/(1-p2))+1+2*p2)^(-1); %two cores, c=2
p_42 = p_02*(2^2)*p2^4/(2);

%%
%Compute the average number of jobs in the system slide 27 L14
p_11 = ((1-p1)/(1-p1^7))*p1^1; % one core
p_21 = ((1-p1)/(1-p1^7))*p1^2; 
p_31 = ((1-p1)/(1-p1^7))*p1^3; 
p_51 = ((1-p1)/(1-p1^7))*p1^5; 
p_61 = ((1-p1)/(1-p1^7))*p1^6; 
N1 = 1*p_11 + 2*p_21 + 3*p_31 + 4*p_41 + 5*p_51 + 6*p_61;


p_12 = p_02*2*p2; % two cores
p_22 = p_02*(2^2)*p2^2/(2);
p_32 = p_02*(2^2)*p2^3/(2);
p_52 = p_02*(2^2)*p2^5/(2);
p_62 = p_02*(2^2)*p2^6/(2);
N2 = 1*p_12 + 2*p_22 + 3*p_32 + 4*p_42 + 5*p_52 + 6*p_62;

%%
%Compute the average utilization
%slide 23 L14
average_U1 = 1-p_01; %one core

%slide 27 L14
average_U2 = (1*p_12 + 2*p_22 + 2*(p_32 + p_42 + p_52 + p_62))/2; %two cores

%%
%Compute the throughput and the drop rate slide 27 L14
DR1 = lambda1*p_61; 
DR2 = lambda2*p_62;

X1 = lambda1*(1-p_61);
X2 = lambda2*(1-p_62);

%Compute the average response time and the average time spent in the queue
%slide 27 L14
R1 = N1/X1;
R2 = N2/X2;

O1 = R1-D1;
O2 = R2-D2;

%%
disp('M/M/1/6')
average_U1
p_41
N1
DR1
X1
R1
O1

%%
%compute the comparison with M/M/1
disp('M/M/1')
%Performance indices of an M/M/1 queue
pM1 = lambda1*D1; % U1 = p1 and also the average utilization slide 35 L12
UM1 = pM1

%Compute the probability of having 4 jobs in the system slide 32 L12
pM1_4 = (1-pM1)*pM1^4

DRM1 = 0 %no finite capacity

%Compute the average number of jobs in the system slide 35 L12
NM1 = (pM1)/(1-pM1)

%Compute the average response time R and the average time spent in the
%queue O slide 36 L12
RM1 = D1/(1-pM1);
XM1 = NM1 / RM1% which is equal to lamda1 because we don't have losses
RM1
OM1 = pM1*D1/(1-pM1)

%%
disp('M/M/2/6')
average_U2
p_42
N2
DR2
X2
R2
O2