function [min, index]=Get_MinAndIndex(arr)
% min - min value in arr
% index - min value index in arr

[m,n] = size(arr);

min=1e6;
for i=1:n
    if arr(i)<=min
       min=arr(i);
       index=i;
    end
  
end

end