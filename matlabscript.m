n = 1e6;  % n samples
data = randn(1e6, 1); % Generate n Random Gaussian samples. 
nbins = 50; % bins in your histogram
[cnt, x_hist] = hist(data, nbins); % not to plot, only to get emperical distribution.
figure;
cnt = cnt / n / (x_hist(2) - x_hist(1)); % normalization, be careful :)
bar(x_hist, cnt); % plot the hist using bar()
hold on;
x = -5 : 0.1 : 5;
plot(x, normpdf(x), 'r', 'linewidth', 2);
legend({'$\hat{p}_{\sf{x}}(x)$', '$p_{\sf{x}}(x)$'}, 'Interpreter', 'LaTeX', 'fontsize', 15);
xlabel('$x$', 'Interpreter', 'LaTeX', 'fontsize', 15); % You may change the size accordingly
ylabel('$p_{\sf{x}}(x)$', 'Interpreter', 'LaTeX', 'fontsize', 15);
title("\mlplaceholder{your-title-here}")