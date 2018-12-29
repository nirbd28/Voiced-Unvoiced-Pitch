function zcr = CalcZCR(arr)
    zcr = mean(abs(diff(sign(arr))));
end