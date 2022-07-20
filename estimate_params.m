function [a_ml, e_d] = estimate_params(x, P)
%ESTIMATE_PARAMS Summary of this function goes here
%   Detailed explanation goes here
N = length(x);

% GENERAL LINEAR MODEL: x_hat = G_x * a + e
x_hat = x(P+1:N);

G_x = zeros(N-P,P);
for row = 1:size(G_x, 1)
    G_x(row, :) = x(P+row-1:-1:row);
end

% Maximum likelihood estimaion of the parameters
a_ml = pinv(G_x)*x_hat';

% Computing the prediction error
H_a = [1; -a_ml];
e_d = filter(H_a, 1, x);

% COMMENT FIGURE
% figure;
% stem(a_ml);
% title('a^{ML}')
% BREAKPOINT HERE
end

