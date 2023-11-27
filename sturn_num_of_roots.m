%Compute the derivatives and intervals of sturms sequence manually
function [man_res] = sturn_num_of_roots(p0,domain)

% Compute the derivatives
%p1 = [ 4*p0(1), 3*p0(2), 2*p0(3), p0(4) ];
p1 = [ p0(2), 2*p0(3), 3*p0(4), 4*1.0 ];

% Compute the Euclidean division of p0 by p1, return the
% remainder
r_p2 = euclidean_division_rem(p0,p1,4);
p2 = -r_p2;

% Compute the next division p1 by p2
r_p3 = euclidean_division_rem(p1,p2,0);
p3 = -r_p3;

% Compute the next division p2 by p3
r_p4 = euclidean_division_rem(p2,p3,0);
p4 = -r_p4;

% Evaluate at the interval edges
L = domain(1);
R = domain(2);
signs_L = sign( [eval_poly(p0,L),eval_poly_lo(p1,L),eval_poly_lo(p2,L),eval_poly_lo(p3,L),...
    eval_poly_lo(p4,L)] );
signs_R = sign( [eval_poly(p0,R),eval_poly_lo(p1,R),eval_poly_lo(p2,R),eval_poly_lo(p3,R),...
    eval_poly_lo(p4,R)] );

% Display signs
%fprintf("Signs (L): ");
%disp(signs_L)
%fprintf("Signs (R): ");
%disp(signs_R)

% compute the number of real roots
num_real_roots = sign_changes(signs_L) - sign_changes(signs_R);
man_res = num_real_roots;
%fprintf("*** Result ***\n")
%fprintf("There are %d-real roots",num_real_roots)
%fprintf("\n");
end




% Display the results
function display_res(title,q,r,error)

%print the title
fprintf("*** %s ***\n",title);

% q -results
fprintf("q-results:");
for i = 1:deg(q)
    fprintf(" %1.16e ",q(i));
end
fprintf("\n");

% remainder
fprintf("remainder:");
for i = 1:deg(r)
    fprintf(" %1.16e ",r(i));
end
fprintf("\n");

%error
fprintf("error:");
for i = 1:deg(error)
    fprintf(" %1.16e ",error(i));
end
fprintf("\n\n");

end
