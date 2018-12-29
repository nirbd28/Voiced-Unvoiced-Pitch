function [max, index]=Get_MaxAndIndex(arr)
% max - max value in arr
% index - max value index in arr

[m,n] = size(arr);

max=0;
for i=1:n
    if arr(i)>=max
       max=arr(i);
       index=i;
    end
  
end

end