clear all;

filename = 'DataSet1';
source = readmatrix(filename);%extracts the data, to see the other dataset result simply modify the file name

%%
%Arrival rate and throughput
number_arrivals = size(source,1); %number of arrivals = number of departures
total_time = source(number_arrivals,2); %last completion time

lambda = number_arrivals / total_time %arrival rate (frequency at which jobs arrives at a given station)
throughput= number_arrivals / total_time %throughput because the system is supposed to not have losses (rate at which jobs are served and depart from station)
%slide 27 L01

%%
%Average Response Time
response_times = source(:,2)-source(:,1);% response times calculated as difference between completion time and arrival time since the jobs are not interrupted
W= sum(response_times(:)) %sum all the vector
average_response_time = W/ number_arrivals %average response time

%%
%Average Number of Jobs
average_number_jobs = throughput * average_response_time % average number of jobs, little's law
%slide 38 L01

%%
%Busy time, utilization, Average service time
service_times(1:number_arrivals,1) = 0;
for i = 1:number_arrivals %for that calculates the service_times vector, HP: Assuming that jobs are served in the order of arrival, one at a time, and not interrupted
    if i==1 || source(i-1,2)<= source(i,1) %case in which there is no queue
        service_times(i) = source(i,2) - source(i,1); %finish-start
    else
        service_times(i) = source(i,2) - source(i-1,2); %finish-finish job before
    end
end
busy_time = sum(service_times(1:number_arrivals,1))
utilization = busy_time/total_time
average_service_time = busy_time/number_arrivals %number arrivals = number departures

%%
%Probability of having a response time less than t, (with t = 1, 10, 50)
probability_response_times =sum([response_times < 1, response_times < 10, response_times < 50])/number_arrivals

%%
%Probability of having m jobs in the station (with m = 0, 1, 2, 3)

%first we create two matrix, one for arrivals and the other for completions,
%on the (:,2) we have 1 for the arrivals and -1 for the completions
arrival_samples = zeros(number_arrivals,2);
completion_samples = zeros(number_arrivals,2);
for i = 1:number_arrivals
    arrival_samples(i,1) = source(i,1);
    arrival_samples(i,2) = 1;
    completion_samples(i,1) = source(i,2);
    completion_samples(i,2) = -1;
end
%concatenation of the two matrix
concatenated = [arrival_samples;completion_samples];
concatenated = sortrows(concatenated);%sortrows(A) sorts the rows of a matrix in ascending order based on the elements in the first column
final_matrix = zeros(2*number_arrivals,2);
final_matrix(:,1) = concatenated(:,1);
final_matrix(1,2) = concatenated(1,2);%final matrix, where in the (:,2) we have the exact number of jobs for that arrival/completion instant
for i = 2:2*number_arrivals
    final_matrix(i,2) = final_matrix(i-1,2) + concatenated(i,2);
end

%finally for each number of jobs (0,1,2,3), for each row we sum the number
%of seconds the system had that number of jobs, which is
%matrix(i,1)-matrix(i-1,1)
n_0 =0;%number of seconds for which the system had 0 jobs
n_1=0;%number of seconds for which the system had 1 jobs
n_2=0;%number of seconds for which the system had 2 jobs
n_3=0;%number of seconds for which the system had 3 jobs
n_0= final_matrix(1,1); %initialization, before the first arrival the system had 0 job

for i = 2:(2*number_arrivals)-1
    if final_matrix(i,2)==0
        n_0= n_0 + final_matrix(i+1,1) - final_matrix(i,1);
    elseif final_matrix(i,2)==1
        n_1= n_1 + final_matrix(i+1,1) - final_matrix(i,1);
    elseif final_matrix(i,2)==2
        n_2= n_2 + final_matrix(i+1,1) - final_matrix(i,1);
    elseif final_matrix(i,2)==3
        n_3= n_3 + final_matrix(i+1,1) - final_matrix(i,1);
    end
end 
%probability of having 0,1,2,3 jobs
p_n0 = n_0/total_time
p_n1 = n_1/total_time
p_n2 = n_2/total_time
p_n3 = n_3/total_time

  