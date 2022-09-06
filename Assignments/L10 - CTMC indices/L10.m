clear all;

MTEA = 8;
MTEB = 12;
MTWB = 5;
MTWA = 10;

l1 = 1/MTEA;%task a executing
l2 = 1/MTEB;%task b executing
u1 = 1/MTWB;%task b waiting
u2 = 1/MTWA;%task a waiting

Q = [-(l1/2)-(l2/2),  l1/2,  l2/2,  0;
        u2 , -u2-l2,  0, l2;
        u1 ,   0, -u1-l1, l1;
         0 ,  u1  ,  u2  ,-u1-u2];


p0 = [1, 0, 0, 0];%system starts with both tasks running

[t, Sol] = ode45(@(t,x) Q'*x, [1:1:100], p0');

%%
% througput transition matrix, quando da execution passa a waiting ha
% finito un job
TR = [0, 1, 1, 0
     0, 0 , 0, 1
     0, 0, 0, 1
     0, 0, 0, 0]

%slide 16 L10
%state rewards
a1 = [2, 1, 1, 0];% average number of tasks state rewards
a2 = [1, 1, 1, 0];% average utilization state rewards

U = Sol(end,:)*a2'% utilization

N = Sol(end,:)*a1'% average number of tasks

X = 0;

%throughput formula slide 21 L10
for i=1:4
    tmp = 0;
    for j=1:4
        if i~=j
            tmp = tmp + Q(i,j)*TR(i,j);
        end
    end
    X = X + tmp*Sol(end,i);
end
X

%%
%average number of jobs t=10s,20s,50,100s - slide 21
%prodotto vettoriale

N10 = Sol(10,:)*a1'
N20 = Sol(20,:)*a1'
N50 = Sol(50,:)*a1'
N100 = Sol(100,:)*a1'


            
