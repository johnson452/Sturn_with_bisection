
% Refine the domains
function [ref_doms] = compute_refine_domains(p,domains,tol)

% Compute the number of domains to refine
sz_all = size(domains);
sz = sz_all(1);
ref_doms = domains*0.0;

% For all domains, refine the result
for i = 1:sz

    % Grab the domain
    domain = domains(i,:);
    error = 2*tol;
    L = domain(1);
    R = domain(2);
    iter = 0;

    % Iterate on the domain for some tolerance
    while(error > tol && iter < 100)

        % Grab middle location in the domain
        I = (L+R)/2.0;
        I = check_poly(p,[L,I,R],"LIR",tol);

        % Compute the roots (L)
        domainL = [L,I];
        left_num_roots = sturn_num_of_roots(p,domainL);

        % Compute the roots (R)
        domainR = [I,R];
        right_num_roots = sturn_num_of_roots(p,domainR);


        % Cases of different number of roots in each side
        if left_num_roots == 1

            % update to the left domain
            R = I;

        elseif right_num_roots == 1

            %update to the right domain
            L = I;

        else

            fprintf("No roots found in the subdomain?\n");

        end

        %update the error
        error = abs(L - R);
        iter = iter + 1;


    end

    fprintf("Total iterations: %d\n",iter);
    % Save the restricted domain
    ref_doms(i,:) = [L,R];

end


end