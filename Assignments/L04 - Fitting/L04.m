clear all
format longG
source = csvread('Traces.csv');

global M1
global M2
global M3
global var
global k

k = 1; %to calculate other traces results, simply modify k
M1 = mean(source); %first moment
M2 = mean(source.^2); %second moment
M3 = mean(source.^3); %third moment
M4 = mean(source.^4); %fourth moment
exp_param = 1 / M1(k);
var = mean((source-M1).^2)


x = [0:40]/0.9; %vettore con 40 campioni distanziati 1.1 (solo per visualizzare meglio graficamente)

%%
%exponential function
exp_function = 1 - exp(-1*exp_param*x);

%%
%Method of moments - deterministic %slide 46 L04
Unif_a_MM = M1 - sqrt(12*(M2 - M1.^2))/2;
Unif_b_MM = M1 + sqrt(12*(M2 - M1.^2))/2;

%%
%uniform distribution with method of moments
xUnif = linspace(Unif_a_MM(k), Unif_b_MM(k), 20); %Create a vector of 20 evenly spaced points in the interval [a,b]

%%
%hyper-exponential with method of moments % slide 56 L04

HE_pars_MM = fsolve(@MM_HyperExp, [0.5, 0.5, 0.5]) %Solve system of nonlinear equations
hyper_function = 1 - HE_pars_MM(3)*exp(-x*HE_pars_MM(1)) - (1-HE_pars_MM(3))*exp(-x*HE_pars_MM(2)); %CDF

%%
%hypo-exponential with method of moments

HY_pars_MM = fsolve(@MM_HypoExp, [0.5, 0.5]);
hypo_function = 1 - (HY_pars_MM(2)*exp(-HY_pars_MM(1)*x)/(HY_pars_MM(2)-HY_pars_MM(1)))+(HY_pars_MM(1)*exp(-HY_pars_MM(2)*x)/(HY_pars_MM(2)-HY_pars_MM(1))); %CDF

%%
%likelihood exponential

%mle = Maximum likelihood estimates
lambda_exp_mle = mle(source(:,k), 'pdf', @LH_ExpFunction, 'start', 0.1, 'LowerBound', 0, 'UpperBound', Inf); % returns maximum likelihood estimates 
exp_function_mle = 1 - exp(-1*lambda_exp_mle*x); %CDF

%%
% hyper-exponential with likelihood

HE_pars_MLE = mle(source(:,k), 'pdf', @LH_HyperExp, 'start', [0.5, 0.5, 0.5], 'LowerBound', [0, 0, 0], 'UpperBound', [Inf, Inf, 1]);
hyper_function_mle = 1 - HE_pars_MLE(3)*exp(-x*HE_pars_MLE(1)) - (1-HE_pars_MLE(3))*exp(-x*HE_pars_MLE(2)); %CDF

%%
% hypo-exponential with likelihood

HY_pars_MLE = mle(source(:,k), 'pdf', @LH_HypoExp, 'start', [0.5, 0.51], 'LowerBound', [0, 0], 'UpperBound', [Inf, Inf]);
hypo_function_mle = 1 - (HY_pars_MLE(2)*exp(-HY_pars_MLE(1)*x)/(HY_pars_MLE(2)-HY_pars_MLE(1)))+(HY_pars_MLE(1)*exp(-HY_pars_MLE(2)*x)/(HY_pars_MLE(2)-HY_pars_MLE(1))); %CDF

%%
%Method of moments plot 
figure(1); hold on
uniform = plot( xUnif, [0:19]/19,"*");
trace = plot(sort(source(:,k)),[1:1000]/1000,"-");
exponential = plot(x, exp_function,"+");
hyper = plot(x, hyper_function,"-");
hypo = plot(x, hypo_function,"-");

legend ([uniform,exponential,trace,hyper,hypo],["uniform","exponential","trace","hyper","hypo"]);
title("Method of moments")

%%
%maximum likelyhood in general produces very nice looking fitting of the
%considered trace, but momoments can be very different from the original 
%maximum likelihood plot 
figure(2); hold on
trace = plot(sort(source(:,k)),[1:1000]/1000,"-");
exponential = plot(x, exp_function_mle,"+");
hyper = plot(x, hyper_function_mle,"-");
hypo = plot(x, hypo_function_mle,"-");

legend ([exponential,trace,hyper,hypo],["exponential","trace","hyper","hypo"]);
title("Maximum Likelihood")
