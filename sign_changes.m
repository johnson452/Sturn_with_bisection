% Function: count the number of sign changes
function [res] = sign_changes(x)

% Remove zero elements
x = remove_zeros(x);

% For the length of x-1 see if there are sign changes
res = 0;
for i = 1:max(size(x)) - 1
    if x(i)*x(i+1) < 0 % x(i) ~= 0 && (x(i)*x(i+1) < 0 || x(i+1) == 0) %x(i)*x(i+1) < 0
        res = res + 1;
    end
end

end