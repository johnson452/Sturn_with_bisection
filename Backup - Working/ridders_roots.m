function [roots_via_ridders] = ridders_roots(poly_coeff,domains)

% Compute the roots via ridders from the domain
sz = size(domains,1);
roots_via_ridders = zeros(1,sz);
tol = 1e-15;
for i = 1:sz
    [roots_via_ridders(i),~,iter] = ridders(domains(i,1), domains(i,2), tol, poly_coeff);
end

end


% Find the root
function [sol,cond,iter] = ridders(bound1, bound2, tol, p)

%Select upper and lower
if bound1 > bound2
    upper = bound1;
    lower = bound2;
else
    upper = bound2;
    lower = bound1;
end

%Setup the variables
x0 = lower;
x1 = 0.5*(lower + upper);
x2 = upper;
d = x2 - x1;
F0 = eval_poly(p,x0);
F2 = eval_poly(p,x2);
iter = 0;

% condition 0 -> Okay, 1 -> Fail
cond = 0;

while( cond == 0 && iter < 15)  %abs(F3) > tol &&

    %Fails, multiple roots/no root etc, bad domain
    if F0*F2 >= 0
        cond = 1;
        fprintf("Ridders' algo. fails to have two same-signed ends!\n")
        sol = 0;

        if d > tol && tol > 1e-40
        % Create a figure in this case:
        %figure
        N = 100;
        x = linspace(lower,upper,N);
        f_x = zeros(1,N);
        for i = 1:N
            f_x(i) = eval_poly(p,x(i));
        end
        plot(x,f_x)
        title("Ridders Diag, x, f_x")
        xlabel("U")
        ylabel("f(U)")
        ylim([-max(abs(f_x)),max(abs(f_x))])

        else % fails but with condition 2, small domain might not be valid
            cond = 2;
        end


        % Otherwise continue
    else

        %Compute more variables
        F1 = eval_poly(p,x1);
        diff = d*(F1/F0)/sqrt( (F1/F0)^2 - F2/F0 );
        x3 = x1 + diff;

        % Setup the next interval
        F3 = eval_poly(p,x3);

        % Solution
        if x2 >= x3 && x3 >= x1
            if F1*F3 < 0
                upper = x3;
                lower = x1;
            elseif F2*F3 < 0
                upper = x2;
                lower = x3;
            else
                done = 1;
            end
        elseif x0 <= x3 && x3 <= x1
            if F1*F3 < 0
                upper = x1;
                lower = x3;
            elseif F0*F3 < 0
                upper = x3;
                lower = x0;
            else
                done = 1;
            end
        else
            done = 1;
        end

        % Save the new bounds, and new solution
        x2 = upper;
        x0 = lower;
        x1 = 0.5*(lower + upper);
        d = x2 - x1;
        F0 = eval_poly(p,x0);
        F2 = eval_poly(p,x2);
        sol = x3;
        iter = iter + 1;

        %fprintf("Iteration: %d, returns val: %1.16f, f(x3): %1.16f\n",iter,sol,F3)

    end

end
end



%%% COPIED FUNC - FOR READING IN DATA %%%
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


% function degree of the polynomial
function [res] = deg(p)
res = max(size(p));
end