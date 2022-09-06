clear all;

s = 1;
t = 0;

Tmax = 100;

trace = [t, s];

Ts1 = 0;
Ts2 = 0;
Ts3 = 0;
C = 0;

while t < Tmax
	if s == 1
		dt = -(log(rand()) + log(rand()) + log(rand()) + log(rand())) / 5;
		Ts1 = Ts1 + dt;
		if rand() < 0.3
			ns = 2;
		else
			ns = 3;
		end 
	end
	if s == 2
		ns = 1;
		dt = -(log(rand()) + log(rand())) / 10; 
		Ts2 = Ts2 + dt;
		C = C + 1;
	end
	if s == 3
		ns = 1;
		dt = -(log(rand()) + log(rand()) + log(rand())) / 8; 
		Ts3 = Ts3 + dt;
		C = C + 1;
	end

	s = ns;
	t = t + dt;
	
	trace(end + 1, :) = [t, s];
end

Ps1 = Ts1 / t
Ps2 = Ts2 / t
Ps3 = Ts3 / t
X = C / t
plot(trace(:,1),trace(:,2),"*");

