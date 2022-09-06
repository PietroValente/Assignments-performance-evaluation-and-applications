function F = LH_HypoExp(x, l1, l2)
    %slide 35 L04
    F = (l1*l2/(l1-l2))*(exp(-l2*x)-exp(-l1*x));
end