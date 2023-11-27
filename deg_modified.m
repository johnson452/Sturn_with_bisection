% function degree of the polynomial
function [res] = deg_modified(p)

% If everything is zero, the degree is zero
res = 0;

%  compute the degree
for i = 1:4
    if p(i) ~= 0
        res = i - 1; 
    end
end

end
