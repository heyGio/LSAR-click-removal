function [x_ls] = LSAR(x_l, x_hat, x_r, a)
%LSAR Summary of this function goes here
%   Detailed explanation goes here
m = length(x_l);
l = length(x_hat);
n = length(x_r);
N = m + l + n;


U = [zeros(m,l); eye(l,l); zeros(n,l)];
K = [eye(m,m), zeros(m,n);
     zeros(l,m), zeros(l,n);
     zeros(n,m), eye(n,n)];

P = length(a);
A = zeros(N-P, N);
a_sgn = [-flip(a') 1];
for i = 1:N-P 
    A(i, i:i+P) = a_sgn;
end

A_hat = A*U;
A_sgn = A*K;

x_sgn = [x_l,x_r]';

x_ls = -pinv(A_hat)*A_sgn*x_sgn;
end

