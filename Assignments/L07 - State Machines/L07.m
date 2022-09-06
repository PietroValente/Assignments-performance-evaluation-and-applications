clear all
s_enter = 1;%first stage
s_service = 2;%second stage
s_waiting = 3;%third stage
t_enter = 0;
t_service = 0;
t_waiting = 0;
s_curr = 1; %current state
s_next = 1;% next state 
t_tot = 1000000; %total time
t = 0;

%%
while t < t_tot
    if(s_curr == s_enter)
        dt = -(log(rand()) + log(rand()) + log(rand())) / 0.1; %slide 2 L05
        t_enter = t_enter + dt;
        if(rand()<0.2) %prob 20%
            if(rand()<0.5)
                s_next = s_enter;
            else
                s_next = s_waiting;
            end
        else
            s_next = s_service;
        end
    elseif(s_curr == s_service)
        dt = -log(rand())/0.01;
        t_service = t_service +dt;
        if(rand()<0.5)
            s_next = s_enter;
        else
            s_next = s_waiting;
        end
    elseif(s_curr == s_waiting)
        dt = -log(rand())/0.005;
        t_waiting = t_waiting + dt;
        s_next = s_enter;
    end
    s_curr = s_next;
    t = t + dt;
end
p_enter = t_enter / t_tot
p_service = t_service / t_tot
p_waiting = t_waiting / t_tot
U = (t_enter + t_service) / t_tot %busy time/tempo tot

