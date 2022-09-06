clear all

lambda_e = 0.1;
lambda_c = 10;
d_1e = 2;
d_2e = 5;
d_1c = 0.06;
d_2c = 0.04;

%%
% The utilization of the two NAS slide 39 L19
% Because it is a open system lambda_c = X_c (slide 16 L17)
X_e = lambda_e;
X_c = lambda_c;

U_1e = X_e * d_1e;
U_2e = X_e * d_2e;
U_1c = X_c * d_1c;
U_2c = X_c * d_2c;

U_1 = U_1e + U_1c %slide 40 L19
U_2 = U_2e + U_2c

%%
%If the considered system is stable
if (U_1<1 && U_2<1)
    disp("The system is stable")
else disp("The system is not stable")
end

%%
%The residence time of the two NAS
X = X_e + X_c;

R_1e = d_1e/(1-U_1); %slide 54 L19
R_2e = d_2e/(1-U_2);
R_1c = d_1c/(1-U_1);
R_2c = d_2c/(1-U_2);

%from little's law Nk = sum Nkc, Nkc = Xc * Rkc
R_1 = (X_e/X) * R_1e + (X_c/X) * R_1c %slide 43
R_2 = (X_e/X) * R_2e + (X_c/X) * R_2c

%%
% The system response time slide 45 L19
R = R_1 + R_2

