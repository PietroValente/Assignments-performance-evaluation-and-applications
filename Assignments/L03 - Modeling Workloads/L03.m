clear all 
format long g % to set the output format
source = readtable('Data1.txt');%to see the other dataset just change the file name
nA = size(source,1);%size of the first column
source = table2array(source);

%%
%first four moments - slide 25 L03 - equiprobable
mean = sum(source) / nA %first moment 
moment_2 = sum(source.^2) / nA
moment_3 = sum(source.^3) / nA
moment_4 = sum(source.^4) / nA

%%
%central moments - slide 15 L03
central_moment_2 = sum((source - mean).^2)/nA
central_moment_3 = sum((source - mean).^3)/nA
central_moment_4 = sum((source - mean).^4)/nA

var = central_moment_2;
dev_standard_1 = sqrt(var)

%%
%standardized moments - slide 15 L03
std_central_moment_3 = sum(((source - mean)/dev_standard_1).^3)/nA
std_central_moment_4 = sum(((source - mean)/dev_standard_1).^4)/nA

%%
%kurtosis - slide 21 L03
kurtosis = std_central_moment_4 - 3

%%
%coeafficient of variation - slide 18 L03
coefficient_variation = dev_standard_1 / mean

%%
%cross covariance of lag 1,2 slide 29 L03 (correlation)
cross_covariance_1 = sum((source(1:nA-1) - mean).*(source(2:nA)-mean))/(nA-1)
cross_covariance_2 = sum((source(1:nA-2) - mean).*(source(3:nA)-mean))/(nA-2)
cross_covariance_3 = sum((source(1:nA-3) - mean).*(source(4:nA)-mean))/(nA-3)

%%
%percentile calculation: the percentile is the value for which the cdf is
%equal to k%
%slide 38 L03
sort_1= sort(source);

h_10 = 0.1*(nA-1) + 1;
p_10 = sort_1(floor(h_10)) + (  floor(h_10) - h_10)*(sort_1(floor(h_10)+1)- sort_1(floor(h_10)))

h_25 = 0.25*(nA-1) + 1;
p_25 = sort_1(floor(h_25)) + (  floor(h_25) - h_25)*(sort_1(floor(h_25)+1)- sort_1(floor(h_25)))

h_50 = 0.5*(nA-1) + 1;
p_50 = sort_1(floor(h_50)) + (  floor(h_50) - h_50)*(sort_1(floor(h_50)+1)- sort_1(floor(h_50)))

h_75 = 0.75*(nA-1) + 1;
p_75 = sort_1(floor(h_75)) + (  floor(h_75) - h_75)*(sort_1(floor(h_75)+1)- sort_1(floor(h_75)))

h_90 = 0.9*(nA-1) + 1;
p_90 = sort_1(floor(h_90)) + (  floor(h_90) - h_90)*(sort_1(floor(h_90)+1)- sort_1(floor(h_90)))

%%
%plot - slide 35 L03
plot(sort_1,[1:nA]/nA,"+")
title('cdf plot')