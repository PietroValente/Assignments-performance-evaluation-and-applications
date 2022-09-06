clear all
t_working = 0;
t_r = 0;
t_m = 0;
t_tot = 1000000;
s_working = 1;
s_m = 2;
s_r = 3;
s_curr = 1;
s_next = 1;
e_r = 0;
e_m = 0;
dt = 0;
t = 0;
n_report = 0;

%%
while t < t_tot
    if (s_curr == s_working)
        e_r = -(log(rand()))/0.05;
        e_m = -(log(rand()))/0.001;
        if(e_m <e_r) %prendo l'evento che avviene prima
            s_next = s_m;
            dt = e_m;
        else
            s_next = s_r;
            dt = e_r;
        end
        t_working = t_working + dt;
    end
    if(s_curr == s_m)
        dt =  -(log(rand()))/0.05;
        s_next = s_working;
        t_m = t_m + dt;
    end
    
    if(s_curr == s_r)
        e_m = -(log(rand()))/0.001;
        e_w =  -(log(rand()))/1;
        if(e_w > e_m)%case in which maintenace occur while reporting
            dt = e_m;
            s_next = s_m;
        else
            n_report= n_report +1;%full report exported
            s_next = s_working;
            dt = e_w;
        end
        t_r = t_r + dt; 
    end
    t = t + dt;
    s_curr = s_next;
end
p_working = t_working / t_tot %prabability of being working
p_r = t_r / t_tot %reporting frequency
p_m = t_m / t_tot %probability of maintenance
r_per_hour = n_report/ t_tot %reporting frequency

