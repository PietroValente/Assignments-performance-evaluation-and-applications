clear all
format long

lambda_1_hyper = 0.1;
lambda_2_hyper = 0.05;
k = 50;%k runs of m jobs
m = 200;

N = zeros(k,1);
T = zeros(k,1);
U = zeros(k,1);
X = zeros(k,1);

response_times = zeros(m,1);
inter_arrivals_samples= zeros(m,1);
arrivals_samples = zeros(m,1);
completions_samples = zeros(m,1);

%%

for i = 1:k
    %generation of hypo-exponential service samples (200 rows, 1 column)
    service_samples = -log(rand(m,1))/0.1 - log(rand(m,1))/0.5;

    %generetaion of hyper-exponential interarrival samples
    for j= 1:m
        if(rand()<0.5)
            inter_arrivals_samples(j) = -(log(rand())/lambda_1_hyper);
        else
            inter_arrivals_samples(j) = -(log(rand())/lambda_2_hyper);
        end
    end

    completions_samples(1) = service_samples(1); %temporaneo
    response_times(1) = service_samples(1); %temporaneo

    %response_times calculation 
    for j = 2:m
        arrivals_samples(j) = arrivals_samples(j-1) + inter_arrivals_samples(j);

        %completion samples calculation
        if(arrivals_samples(j)>= completions_samples(j-1))%no queue case 
            completions_samples(j) = arrivals_samples(j) + service_samples(j);
        else%queue case
            completions_samples(j) = completions_samples(j-1) + service_samples(j);
        end
        response_times(j) = completions_samples(j) - arrivals_samples(j);
    end
    
    W = sum(response_times);
    R = W/m;
    B = sum(service_samples);
    S = B/m;
    X(i,1) = m / completions_samples(m); %total time = time of last completion C(t)/tempo tot
    U(i,1) = X(i,1)*S; %utilization law
    N(i,1)= X(i,1)*R; %little's law
    
end

%%
%confidence intervals calculation, slide 42 L06

d_gamma = 1.96; %percentile of the standard normal distribution slide 44 L06

mean_R = mean(response_times);%last run is considered for simplicity
var_R = mean(response_times.^2)- mean_R^2;

R_lower_bound = mean_R - d_gamma * sqrt(var_R/m)
R_upper_bound = mean_R + d_gamma * sqrt(var_R/m)

mean_N = mean(N);
var_N = mean(N.^2) - mean_N^2;

N_lower_bound = mean_N - d_gamma * sqrt(var_N/k)
N_upper_bound = mean_N + d_gamma * sqrt(var_N/k)

mean_U = mean(U);
var_U = mean(U.^2) - mean_U^2;

U_lower_bound = mean_U - d_gamma * sqrt(var_U/k)
U_upper_bound = mean_U + d_gamma * sqrt(var_U/k)

mean_X = mean(X);
var_X = mean(X.^2) - mean_X^2;

X_lower_bound = mean_X - d_gamma * sqrt(var_X/k)
X_upper_bound = mean_X + d_gamma * sqrt(var_X/k)

%%
%plots of arrival and completion curves, x axis = ith number of
%arrival/completion , y axis time of ieth arrival
figure(1)
plot([1:m],arrivals_samples,"-");
title("arrivals")
figure(2)
plot([1:m],completions_samples,"-");
title("completions")