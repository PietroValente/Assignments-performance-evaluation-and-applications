clear all;

s = 1;
t = 0;

Tmax = 100000;

trace = [t, s];

Ts1 = 0;
Ts2 = 0;
Ts3 = 0;

roundTripTime = 0;
RTT = [];
roundIndex = 1;

while t < Tmax
    if s == 1
        ns = 2;
        dt = 50 + rand() * (100-50);
        Ts1 = Ts1 + dt;
        roundTripTime = roundTripTime + dt;
    end
    if s == 2;
        ns = 3;
        dt = 250 + rand() * (500-250); 
        Ts2 = Ts2 + dt;
        roundTripTime = roundTripTime + dt;
    end
    if s == 3;
        ns = 1;
        dt = 100 + rand() * (200-100);
        Ts3 = Ts3 + dt;
        roundTripTime = roundTripTime + dt;
        RTT(roundIndex,1) = roundTripTime;
        roundTripTime = 0;
        roundIndex = roundIndex + 1;
    end
    
    s = ns;
    t = t + dt;
    
    trace(end+1, :) = [t, s]; %end put at the end of the array
end

Ps1 = Ts1 / t %probability per each stage
Ps2 = Ts2 / t
Ps3 = Ts3 / t