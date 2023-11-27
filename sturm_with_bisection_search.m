%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grant Johnson
% 11/25/2023
% Polynomial long division algorithm, manual
% 4-th order polynomials only

% Wiki: https://en.wikipedia.org/wiki/Sturm%27s_theorem

% TODO: 1. Check what happens when the solution to a root lies at the
% boundary

% NOTES:
% A: In the case of a non-square-free polynomial, if neither a nor b 
% is a multiple root of p, then V(a) − V(b) is the number of distinct real roots of P.
% B: If a root is hit exactly during the search routines, the bounds are
% slightly altered to fix this 
% C: First coeff. is not allowed to be zero
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear
close all


% Structure to save the data
gkyl_root_intervals = struct('root_bound_lower', zeros(1, 4), ...
                              'root_bound_upper', zeros(1, 4), ...
                              'status', 0, ... % 0 - success.
                              'niter', 0, ...
                              'nroots', 0);

% Overall tolerance
tol = 1e-13;

% Take an example polynomial
% f(x) = a[1]*x^4 + a[2]*x^3 + a[3]*x^2 + a[4]*x + a[5];
%poly_coeff = [1.5, -12.4, 0.5, 0.0, 5/6];
%poly_coeff = [1.0, 1.0, 0.0, -1.0, -1.0]; % From wiki example
%poly_coeff = [1.0, 0.0, -1.0, 0.0, 0.1]; % 4-real roots
%poly_coeff = [3.85758, -6.77435, 0.136634, 4.77435, -1.99421]; % Test case working with Ammar
% Results known to be: [v=-0.8385439363175684, v=0.6586252361470675, v=0.936058474752778, v=0.999974162134524]
%poly_coeff = [1.0, 0.0, -1.0, 0.0, 0.0]; % 3-distinct roots
%poly_coeff = [1e20, 0.0, -1.0, 0.0, 0.0]; % 3-distinct roots, large ordering
poly_coeff = [1.0, 22/5, 313/50, 781/250, 2541/10000]; %3-distict roots, Shifted -1.1 to the left
domain = [-3,3];

% To match C implementation:
poly_coeff = flip(poly_coeff);
poly_coeff = poly_coeff/poly_coeff(5);
poly_coeff = poly_coeff(1:4);

% Check that the first coefficient is not zero

% Compute manually
domains = find_root_intervals(poly_coeff,domain,tol);

%Compute the roots via ridders
roots_via_ridders = ridders_roots(poly_coeff,domains);

% Refine domains
refined_domains = compute_refine_domains(poly_coeff,domains,tol);
fprintf("\nRefined Domains result:\n")
disp(refined_domains);

% Print the resulting polynomial and plot
plot_poly(poly_coeff,domain,refined_domains,roots_via_ridders);





