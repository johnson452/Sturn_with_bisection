% Find the root intervals
function [domains] = find_root_intervals(p,domain,tol)

% Verify we aren't exactly at a root:
domain = check_poly(p,domain,"Full",tol);

% Compute on the entire domain
total_roots = sturn_num_of_roots(p,domain);

if total_roots == 1

    % Complete
    domains = [domain(1),domain(2)];

elseif total_roots == 0

    % complete
    domains = [];

elseif total_roots > 1

    % Roots isolated
    roots_isolated = 0;
    return_to_this_domain = zeros(2,1);

    % build domains to the appropriate size
    domains = zeros(total_roots,2);

    % Break the domain into two parts
    L = domain(1);
    R = domain(2);
    I = (L+R)/2.0;
    I = check_poly(p,[L,I,R],"LIR",tol);
    not_converged = 1;
    isolated_num_roots = 0;

    % Iterate the domains while not converged
    while(not_converged)

        % Compute the roots (L)
        domainL = [L,I];
        left_num_roots = sturn_num_of_roots(p,domainL);

        % Compute the roots (R)
        domainR = [I,R];
        right_num_roots = sturn_num_of_roots(p,domainR);


        % Cases of different number of roots in each side
        if left_num_roots == total_roots - isolated_num_roots

            % update to the left domain
            R = I;
            I = (L+R)/2.0;
            I = check_poly(p,[L,I,R],"LIR",tol);

        elseif right_num_roots == total_roots - isolated_num_roots

            %update to the right domain
            L = I;
            I = (L+R)/2.0;
            I = check_poly(p,[L,I,R],"LIR",tol);

        else % We succussfully split the domain to some degree

            % if the left or right is 1 then we can add a domain to our
            % result
            if left_num_roots == 1 || right_num_roots == 1

                if left_num_roots == 1
                    roots_isolated = roots_isolated + 1;
                    domains(roots_isolated,:) =  [L,I];
                    isolated_num_roots = roots_isolated;

                end

                if right_num_roots == 1
                    roots_isolated = roots_isolated + 1;
                    domains(roots_isolated,:) =  [I,R];
                    isolated_num_roots = roots_isolated;

                end

                if left_num_roots == 1


                    %update to the right domain
                    L = I;
                    I = (L+R)/2.0;
                    I = check_poly(p,[L,I,R],"LIR",tol);
                end

                if right_num_roots == 1

                    % update to the left domain
                    R = I;
                    I = (L+R)/2.0;
                    I = check_poly(p,[L,I,R],"LIR",tol);
                end

                if right_num_roots == 1 && left_num_roots == 1

                    % We're done
                    if total_roots == roots_isolated
                        not_converged = 0;
                    else

                        % Otherwise, load the second domain
                        L = return_to_this_domain(1);
                        R = return_to_this_domain(2);
                        I = (L+R)/2.0;
                        I = check_poly(p,[L,I,R],"LIR",tol);
                        isolated_num_roots = roots_isolated;

                    end

                end

            else % we've exactly split 2v2 in the domains

                if right_num_roots == 2 && left_num_roots == 2

                    % Save a domain to return to then
                    return_to_this_domain(:) = [I,R];
                    isolated_num_roots = right_num_roots;

                    % update to the left domain
                    R = I;
                    I = (L+R)/2.0;
                    I = check_poly(p,[L,I,R],"LIR",tol);

                else

                    fprintf("Something went wrong, and we don't have four real roots at this point\n");

                end

            end

        end

    end

else
    fprintf("Negative number of roots!!\n");
end

end