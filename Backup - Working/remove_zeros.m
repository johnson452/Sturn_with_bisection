% Remove zeros
function [x_no_zeros] = remove_zeros(x)

% New array size
size_new = sum(abs(x));
x_no_zeros = zeros(1,size_new);

% For the full range
iter = 1;
for i = 1:max(size(x))
    if x(i) ~= 0 
        x_no_zeros(iter) = x(i);
        iter = iter + 1;
    end
end

end