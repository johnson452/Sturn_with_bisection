% Evaluate the polynomial
function [res] = eval_poly(p,x)

%compute the polynomial evaluated at x
res = 0.0;
dp = deg(p);

% If the bounds are finite, compute the polynomial
if isfinite(x)
    for i = 1:dp
        res = res + p(i)*x^(dp-i);
    end

    % If the bounds are at infinity, we take the leading order behavior
elseif (x > 0)
    res = sign(p(1))*inf;
elseif (x < 0)
    % Even
    if mod(deg(p)-1,2) == 0
        res = sign(p(1))*inf;
        % odd
    else
        res = -sign(p(1))*inf;
    end
end

end