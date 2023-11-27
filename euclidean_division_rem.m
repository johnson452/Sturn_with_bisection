function r = euclidean_division_rem(p0,p1,p0_deg)
% Compute the Euclidean remainder

% Initialize the problem 
r = p0;
if p0_deg == 0
    r_deg = deg_modified(r);
    rmax = r(r_deg+1);
else
    r_deg = p0_deg;
    rmax = 1.0;
end
p1_deg = deg_modified(p1);
iter_max = r_deg-p1_deg+1;
q = zeros(1,iter_max);
p1g = zeros(1,r_deg+1);
iter = 0;


% Iterate while the degree is still higher
while(r_deg >= p1_deg)

    % compute the quotient
    q(iter_max - iter) = rmax/p1(p1_deg+1);

    % Multiply p1 by q
    for i = 1:p1_deg+1
        p1g(i+(iter_max - iter - 1)) = p1(i)*q(iter_max - iter);
    end

    % Subtract p1g from r
    for i = 1:min(r_deg+1,4)
        r(i) = r(i) - p1g(i);
    end

    %update the iter, degree of the remaining poly
    iter = iter + 1;
    r_deg = r_deg-1;
    rmax = r(r_deg+1);

    % set p1g to zero
    p1g = 0.0*p1g;
end
end