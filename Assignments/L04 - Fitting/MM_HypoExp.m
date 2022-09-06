function F = MM_HypoExp(p)
    global M1
    global M2
    global k

    %p(1) -> lambda1
    %p(2) -> lambda2
    l_1 = p(1);
    l_2 = p(2);

    F = [];
    %slide 37 L04
    F(1)= ((1/l_1)+(1/l_2))/ M1(k) - 1;
    F(2) = (2*(1/l_1^2 + 1/l_2^2 + 1/(l_1*l_2)))/M2(k) - 1;
end    