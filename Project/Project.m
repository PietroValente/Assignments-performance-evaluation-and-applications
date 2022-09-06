clear all
format longG
source = csvread('Trace15.txt');

global k %exponential stages
k = 1;
x = [0:10000]/2000; %samples

%https://www.sciencedirect.com/topics/mathematics/erlang-distribution
%mle = Maximum likelihood estimates
earlang_lamba_mle = mle(source(:,1), 'pdf', @LH_Erlang, 'start', 0.01, 'LowerBound', 0, 'UpperBound', Inf); % returns maximum likelihood estimates 
earlang_function_mle = 1;
for i = 0:k-1
    earlang_function_mle = earlang_function_mle - (((earlang_lamba_mle.*x).^i) .* exp(-1*earlang_lamba_mle.*x))/factorial(i); %CDF
end

%%
%means
trace_mean = mean(source);

trace_cv = std(source)/trace_mean
earlang_mean = k/earlang_lamba_mle
trace_mean
k
earlang_lamba_mle

%%
%Plot
figure(1); hold on
trace_mean = plot(sort(source(:,1)),[1:10000]/10000,"-");
earlang = plot(x, earlang_function_mle,"-");
legend ([trace_mean,earlang],["trace","earlang"]);
