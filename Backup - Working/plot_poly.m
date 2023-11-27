% Plot the polynomial and domain
function plot_poly(p,domain,refined_domains,roots_via_ridders)

%Build the x-array
N = 10000;
x = linspace(domain(1),domain(2),N);
evaled_poly = zeros(1,N);
for i = 1:N
    evaled_poly(i) = eval_poly(p,x(i));
end

% Plot the polynomial
subplot(3, 2, [1, 2]);
plot(x,evaled_poly)
title("Polynomial, with root intervals")
xlabel("X")
ylabel("P(X)")


% Refined intervals
sz_all = size(refined_domains);
sz = sz_all(1);
y_range = [min(min(evaled_poly),-1),max(max(evaled_poly),1)];
for i = 1:sz
    for j = 1:2
        hold on
        plot([refined_domains(i,j),refined_domains(i,j)],y_range,"--red")
    end
end

ylim([-1,1])
grid on

% Iterate and plot the roots in zoomed in pannels
for i = 1:sz
    subplot(3,2,i+2)
    xmin = refined_domains(i,1);
    xmax = refined_domains(i,2);
    dx = (xmax - xmin);
    xmin = xmin - dx/4;
    xmax = xmax + dx/4;
    x_sub = linspace(xmin,xmax,N);
    for j = 1:N
        evaled_poly(j) = eval_poly(p,x_sub(j));
    end
    plot(x_sub,evaled_poly)
    title_str = sprintf("Real-Root %d",i);
    title(title_str)
    xlabel("X")
    ylabel("P(X)")
    grid on

    y_range = [min(min(evaled_poly)),max(max(evaled_poly))];
    for j = 1:2
        hold on
        plot([refined_domains(i,j),refined_domains(i,j)],y_range,"--red")
    end

    hold on
    plot([roots_via_ridders(i)],[0],"*",LineWidth=2)

end

end
