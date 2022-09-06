function F = LH_Erlang(x, l1)
    global k
    k = 12; %exponential stages
    F = ((l1^k)*(x.^(k-1)).*exp(-l1*x))/(factorial(k-1));
end
