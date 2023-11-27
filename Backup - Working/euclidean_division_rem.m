
% Compute the Euclidean remainder
function [q,r,rounding_error] = euclidean_division_rem(p0,p1)

% Find degree, trim poly if zero starting coef
r = p0;
r_deg = deg(r);
p1_deg = deg(p1);
q = zeros(1,r_deg-p1_deg+1);
iter = 1;
rounding_error = zeros(1,r_deg-p1_deg+1);

% Iterate while the degree is still higher
while(r_deg >= p1_deg)

    %initialize to zeros the subtraction
    p1g = zeros(1,r_deg);

    % compute the quotient
    q(iter) = r(1)/p1(1);

    % Multiply p1 by q
    for i = 1:p1_deg
        p1g(i) = p1(i)*q(iter);
    end

    % Subtract p1g from r
    for i = 1:r_deg
        r(i) = r(i) - p1g(i);
    end

    % Compute the rounding error
    rounding_error(iter) = r(1);
    r = r(2:r_deg);

    %update the iter, degree of the remaining poly
    iter = iter + 1;
    r_deg = r_deg-1;
end

end
