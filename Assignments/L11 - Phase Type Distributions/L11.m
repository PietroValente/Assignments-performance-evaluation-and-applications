clear all;

Q = [-5,  0,  1.125,  0.375, 3.5, 0, 0;
      0, -10,  2.25, 0.75, 7, 0, 0;
      0.4, 0.6,  -1, 0, 0, 0, 0;
      0.08, 0.12,  0, -0.2, 0, 0, 0;
      0, 0,  0, 0, -8, 8, 0;
      0, 0,  0, 0, 0, -8, 8;
      3.2, 4.8,  0, 0, 0, 0, -8;];

p0 = [0.4, 0.6, 0, 0, 0, 0, 0]; %1A = 0.4 e 1B = 0.6

[t, Sol] = ode45(@(t,x) Q'*x, [0 10000], p0');

%%
%transition matrix
TR = [0, 0, 0, 0, 0, 0, 0;
     0, 0, 0, 0, 0, 0, 0;
     1, 1, 0, 0, 0, 0, 0;
     1, 1, 0, 0, 0, 0, 0;
     0, 0, 0, 0, 0, 0, 0;
     0, 0, 0, 0, 0, 0, 0;
     1, 1, 0, 0, 0, 0, 0;]

X = 0;% formula on slide 21 L10
for i=1:7
    tmp = 0;
    for j=1:7 
        if i~=j
            tmp = tmp + Q(i,j)*TR(i,j);
        end
    end
    X = X + tmp*Sol(end,i);
end
X

%%
%probability of being Computing 

PC = Sol(end,1) + Sol(end,2)

%probability of being Wi-Fi 

PWF = Sol(end,3) + Sol(end,4) 

%probability of being 4G

P4G = Sol(end,5) + Sol(end,6) + Sol(end,7)







