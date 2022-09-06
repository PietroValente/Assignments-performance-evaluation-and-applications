clear all
N = 100;%number of employees
Sm = 0.05;
Sf = 0.15;
Sa = 0.025;
vm = 0.7;
vf = 0.2;
va = 1;
Z = 10; %think time

%%
%DEMANDS are computed as S * vk slide 33 L16
Dm = vm * Sm;
Df = vf * Sf;
Da = va * Sa;
D = [Dm, Df, Da]

%%
%THROUGHPUT is given by the following algorithm X = i/(Z + Rtot) slide 9
%L18
%Mean Value Analysis

Rk = zeros(1,3);%residence times of the three servers
X = 0;
Rtot = 0;

Nk = [0,0,0];

for i = 1 : N
    Rk = D.*(1+Nk); %slide 9 L18 where Qk is Nk
    Rtot = sum(Rk);
    X = i/(Z+Rtot);
    Nk = Rk *X; %Little's law
end

X
Rtot