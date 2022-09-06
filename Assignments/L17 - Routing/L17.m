clear all

%%
%The visits of the three stations slide 20 L17
l1 = 0.5;
lambda_0 = l1;

l = [l1/lambda_0, 0, 0];
P = [0.7 0.3 0; 
     0.5 0 0.3; 
     0 1 0;];
v = l * inv(eye(3)-P) %eye = identity matrix 

%%
%The demand of the three station slide 33 L16
S1 = 1;
S2 = 2;
S3 = 2.5;

D = v.*[S1,S2,S3]

%%
%Is the system stable?
%the system is stable if for every station utilization is less than one
%slide 43 L16

l1 = v(1) * lambda_0; %slide 16 L17 from Forced Flow Law
l2 = v(2) * lambda_0;
l3 = v(3) * lambda_0;
X1 = l1;
X2 = l2;
X3 = l3;
U1 = X1 * S1 %slide 40 L16
U2 = X2 * S2;
U3 = X3 * S3;

if (U1<1 && U2<1 && U3<1)
    disp("The system is stable")
else disp("The system is not stable")
end
