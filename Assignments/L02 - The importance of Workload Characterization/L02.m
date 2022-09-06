%first with an ide we have formatted the date and times int the log files
%to this format dd--mmm--yyyy HH:MM:SS and deleted everithing else
clear all
format='dd-mmm-yyyy HH:MM:SS';
for j= 1 : 4 %to have all dataset simply change the value of j
    str = 'Log';
    num = string(j);
    str2 = '.txt';
    str_f = strcat(str,num)
    str = strcat(str_f,str2);
source = readtable(str);
source = char(table2array(source));
source = datevec(source,format);
disp(str_f);

%%
%Arrival rate
number_arrivals = size(source,1); % number of jobs arrived
%etime(t2,t1) returns the number of seconds between two date vectors or matrices of date vectors
total_time = etime(source(number_arrivals,:), source(1,:)); %total time difference beetween last arrival and first arrival (rows)
lambda = number_arrivals / total_time % arrival rate per second

%%
%Average inter arrival time

nInter_arrivals = number_arrivals-1;%number of inter arrival samples
interarrival_times(1:number_arrivals,1) = 0;
for i = 2: number_arrivals %loop that calculates every interarrival time
    interarrival_times(i-1,1) = etime(source(i,:), source(i-1,:));
end
average_interarrival_time = sum(interarrival_times)/(nInter_arrivals) % per seconds

%%
%plot figure
figure(j)
for i = 1 : nInter_arrivals-1
  plot(interarrival_times(i,1), interarrival_times(i+1,1), 'r-*')
  title('Correlation plot');
  xlabel('i interarrival');
  ylabel('i+1 interarrival');
  hold on;
  drawnow;
end

%%
%variability
mean = sum(interarrival_times) / (nInter_arrivals);
dev_std = sqrt(sum((interarrival_times - mean).^2)/(nInter_arrivals));
cv_variability = dev_std/mean %slide 18 L03

%%
%correlation calculation
correlation = 0;
for i =1:nInter_arrivals-1
    correlation = correlation + (interarrival_times(i)-mean)*(interarrival_times(i+1)-mean); %slide 29 L03
end
correlation = correlation/(nInter_arrivals)
end

%%
%lowest variability: dataset 2 (best performance)
%highest correlation: datset 3
