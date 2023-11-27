function [new_dom_or_I] = check_poly(p,domain,str_type,tol)

% Check whether we test the full domain or just center
if str_type == "Full" 
    L = domain(1);
    R = domain(2);
    pL = eval_poly(p,L);
    pR = eval_poly(p,R);

    % If the edges are zero, then shift the boundary
    iter = 0;
    while(pL == 0 && iter <= 3)
        L = L - tol;
        pL = eval_poly(p,L);
        iter = iter + 1;
    end
    if iter == 3
        fprintf("Poly Cannot be fixed!\n");
    end
    iter = 0;
    while(pR == 0 && iter < 3)
        R = R - tol;
        pR = eval_poly(p,R);
        iter = iter + 1;
    end
    if iter == 3
        fprintf("Poly Cannot be fixed!\n");
    end

    new_dom_or_I = [L,R];

elseif str_type == "LIR"
    L = domain(1);
    I = domain(2);
    R = domain(3);
    pI = eval_poly(p,I);

    iter = 0;
    while(pI == 0 && iter <= 3)
        I = (R+L)/2.0 + (R-L)*(0.1*(iter+1));
        pI = eval_poly(p,I);
    end
    if iter == 3
        fprintf("Poly Cannot be fixed!\n");
    end

    %Check the new V
    if (L < I && I < R)
    else
        fprintf("New_value invalid\n");
    end

    new_dom_or_I = I;

else 
    fprintf("No-case-match in check-poly\n");
end

end