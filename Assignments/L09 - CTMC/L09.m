clear all;

MTTF1 = 100; %mean time to fail one of the two disks
MTTR1 = 5; %mean time to repair one of the two disks
MTTR0 = 15; %mean time to repair two disks

l1 = 1/MTTF1;
m1 = 1/MTTR1;
m0= 1/MTTR0;

Q = [-l1-l1,  l1  ,  l1  ,  0;
        m1 ,-m1-l1,   0  , l1;
        m1 ,   0  ,-m1-l1, l1;
         m0 ,  0  ,  0  ,-m0];

p0 = [1, 0, 0, 0];

%ode45 = Solve nonstiff differential equations — medium order method
%slide 24 L09
%return time (t) that is a vector [0 10000] and probability to
%be in each step (Sol)
[t, Sol] = ode45(@(t,x) Q'*x, [0 10000], p0');


%%
%plot
plot(t,Sol(:,1),'-',t,Sol(:,2),'-',t,Sol(:,3),'-',t,Sol(:,4),'-');
figure(1); hold on
s_1 = plot(t,Sol(:,1),"-");
s_2 = plot(t, Sol(:,2),'-');
s_3 = plot(t, Sol(:,3),'-');
s_4 = plot(t, Sol(:,4),'-');

legend ([s_1,s_2,s_3,s_4],["both working","1A working","1B working","fault state"]);
Sol(end,:)