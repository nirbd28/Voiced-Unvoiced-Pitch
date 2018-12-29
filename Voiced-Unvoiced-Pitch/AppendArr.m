function arr_out = AppendArr(arr_1, arr_2) % arr_out = arr_1 & arr_2

n1=length(arr_1);
n2=length(arr_2);

if n1==0
   arr_out=arr_2;
else
    arr_out=arr_1;
    index=n1+1;
    for i=1:n2
        arr_out(index)=arr_2(i);
        index=index+1;
    end
end

end