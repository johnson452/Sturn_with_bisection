% Evaluate the polynomial
function [res] = eval_poly(p,x)

%compute the polynomial evaluated at x
res = 0.0;

% If the bounds are finite, compute the polynomial
if isfinite(x)
    for i = 1:4
        res = res + p(i)*x^(i-1);
    end
    res = res + x^4; %p(5) coeff is def as 1.0

    % If the bounds are at infinity, we take the leading order behavior,
    % which is always for an even leading order quartic
else
    fprintf("Not suited to handle inf evaluations\n");
end
end