function F = MM_HyperExp(p)
    global M1
    global M2
    global M3
    global k
    % p(1) -> lambda_1
    % p(2) -> lambda_2
    % p(3) -> p_1
    l1 = p(1);
    l2 = p(2);
    p1 = p(3);
    
    F = [];
    %slide 31 L04
    F(1) = (p1 / l1 + (1-p1) / l2) / M1(k) - 1;
    F(2) = 2*(p1 / l1^2 + (1-p1) / l2^2) / M2(k) - 1;
    F(3) = 6*(p1 / l1^3 + (1-p1) / l2^3) / M3(k) - 1;

end    