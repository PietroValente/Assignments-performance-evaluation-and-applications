clear all

%%
%distributions
%rand() = Uniformly distributed random numbers

%uniform distriution parameters
uniform_a = 10;
uniform_b = 20;

N = 500;

uniform_samples = zeros(N,1);
avg_exponential = 15;

discrete_p = [5,15,20;0.2,0.6,0.2;0.2,0.8,1]; %third column is the cumulative probability
hyper_samples = zeros(N,1);
discrete_samples = zeros(N,1);
hyper_erlang_samples = zeros(N,1);

for i = 1:N
    %uniform generation slide 39 L04 inverse formula of CDF
    %X = rand returns a random scalar drawn from the uniform distribution in the interval (0,1).
    x_unif = rand()*(uniform_b - uniform_a) + uniform_a;
    uniform_samples(i,1) = x_unif; %colonna 1 riga i
    
    %discrete generation
    r = rand();
    if(r<0.2)
        discrete_samples(i,1) = 5;
    else
        if(r<0.8)
            discrete_samples(i,1) = 15;
        else 
            discrete_samples(i,1) = 20;
        end
    end
    
    %hyper-exponential generation - slide 32 L05
    if (rand()<0.5) %probability 0.5
        hyper_samples(i) = -(log(rand()))/ 0.1;
    else
        hyper_samples(i) = -(log(rand()))/ 0.05;
    end

    %hyper erlang generation - slide 30 L05
    if(rand()<0.1)
        hyper_erlang_samples(i) = -(log(rand()))/ 0.02; % 1 stage erlang
    else
        if(rand()<0.5)
            hyper_erlang_samples(i) = -(log(rand()))/ 0.2 -(log(rand()))/ 0.2; % 2 stage erlang
        else
            hyper_erlang_samples(i) = -(log(rand()))/ 0.25 -(log(rand()))/ 0.25 -(log(rand()))/ 0.25; % 3 stage erlang
        end
    end
    
end
%exponential generation - slide 14 L05
exponential_samples =  -(log(rand(N,1)))*avg_exponential;

%hypo generation - slide 31 L05
hypo_samples = -(log(rand(N,1)))/0.1 -(log(rand(N,1)))/0.2;

%%
%plot
y = [0:N-1]/(N-1);
figure; hold on
uniform = plot(sort(uniform_samples()),y);
exponential = plot(sort(exponential_samples()),y,"-");
discrete = plot(sort(discrete_samples()),y,"-");
hyper = plot(sort(hyper_samples()),y,"-");
hypo = plot(sort(hypo_samples()),y,"-");
hyper_erlang = plot(sort(hyper_erlang_samples()),y,"-");

%%
%mean, cv - L03
mean_uniform = mean(uniform_samples)
mean_discrete = mean(discrete_samples)
mean_hy_erlang = mean(hyper_erlang_samples)
mean_exponential = mean(exponential_samples)
mean_hypo = mean(hypo_samples)
mean_hyper_exp = mean (hyper_samples)

dev_std_exponential =sqrt(mean_exponential^2);
dev_std_discrete = sqrt(mean(discrete_samples.^2)-mean_discrete^2);
dev_std_uniform = sqrt(mean(uniform_samples.^2)-mean_uniform^2);
dev_std_hypo = sqrt(mean(hypo_samples.^2)-mean_hypo^2);
dev_std_hyper = sqrt(mean(hyper_samples.^2)-mean_hyper_exp^2);
dev_std_hy_erlang = sqrt(mean(hyper_erlang_samples.^2)-mean_hy_erlang^.2);

cv_exponential = dev_std_exponential / mean_exponential
cv_discrete = dev_std_discrete / mean_discrete
cv_uniform = dev_std_uniform / mean_uniform
cv_hypo = dev_std_hypo / mean_hypo
cv_hyper = dev_std_hyper / mean_hyper_exp
cv_hy_erlang = dev_std_hy_erlang / mean_hy_erlang

legend ([uniform,exponential,discrete,hyper,hypo,hyper_erlang],["uniform","exponential","discrete","hyper","hypo","hyperErlang"]);