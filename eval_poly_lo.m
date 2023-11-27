% Evaluate the polynomial
function [res] = eval_poly_lo(p,x)

%compute the polynomial evaluated at x
res = 0.0;

% If the bounds are finite, compute the polynomial
if isfinite(x)
    for i = 1:4
        res = res + p(i)*x^(i-1);
    end

    % If the bounds are at infinity, we take the leading order behavior,
    % which is always for an even leading order quartic
else
    fprintf("Not suited to handle inf evaluations\n");
end
end