function [i] = click_detection(e_d, k, M, P)
%CLICK_DETECTION Summary of this function goes here
%   Detailed explanation goes here

% Robust estimate of sigma_e using the Median Absolute Deviation
sigma_e = mad(abs(e_d(P+1:end)));
sigma_e = 1.4826 * sigma_e;

% Tresholding    
treshold = k * sigma_e;
i = zeros(1, M);

for n = 1:M
    if abs(e_d(n)) > treshold
        % Saving the index of the detected click 
        % in order to cluster their duration
        i(n) = n; 
    end
end

i(1:P) = 0;

% COMMENT FIGURE
% figure;
% plot(abs(e_d(P+1:end)))
% hold on
% plot(ones(1,M-P)*treshold);
% a = i;
% a (a>0) = 1;
% stem(a(P+1:end)*treshold)
% legend('Prediction error', 'Treshold','i(n)')
% title('Click detection')
% BREAKPOINT HERE
end

