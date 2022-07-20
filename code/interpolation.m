function [interpolated_frame] = interpolation(x, i, M, a_ml, P)
%INTERPOLATION Summary of this function goes here
%   Detailed explanation goes here

% Clustering detections: ensuring that we have at 
% least P samples on either side
i_true_mask = i(i>0);
for n = 2:length(i_true_mask)
    if i(i_true_mask(n)) - i(i_true_mask(n-1)) < P
        i(i_true_mask(n-1):i_true_mask(n)) = i_true_mask(n-1):i_true_mask(n);
    end
end
i(i>0) = 1;

% Counting the duration of each detected click
currentElem = i(1);
counts = [];
count = 0;
for n = 1:M
    if i(n) == currentElem
        count = count + 1;
    else 
        counts(end+1) = count;
        count = 1;
        currentElem = 1 - currentElem;
    end
end
% Last count not included in for loop
counts(end+1) = count;

% INTERPOLATING
% First iteration out of the loop
counts_indexes = [[1,counts(1)]];
for n = 1:length(counts)-1
    current_start = counts_indexes(n,2) + 1;
    current_end = current_start + counts(n+1) - 1;
    counts_indexes(n+1,:) = [current_start, current_end];
end


interpolated_frame = x;
for n = 2:2:length(counts)-1
    x_l = x(counts_indexes(n-1,1):counts_indexes(n-1,2));
    x_hat = x(counts_indexes(n,1):counts_indexes(n,2));
    x_r = x(counts_indexes(n+1,1):counts_indexes(n+1,2));
    
    x_ls = LSAR(x_l, x_hat, x_r, a_ml)';
    interpolated_frame(counts_indexes(n,1):counts_indexes(n,2)) = x_ls;

    % COMMENT FIGURE
%     figure;
%     plot(counts_indexes(n-1,1):counts_indexes(n-1,2), x_l)
%     hold on
%     plot(counts_indexes(n,1)-1:counts_indexes(n,2)+1, [x_l(end); x_hat'; x_r(1)])
%     plot(counts_indexes(n+1,1):counts_indexes(n+1,2), x_r)
%     plot(counts_indexes(n,1)-1:counts_indexes(n,2)+1, [x_l(end); x_ls'; x_r(1)])
%     legend('x_L', 'x_{HAT}', 'x_R', 'x_{LS}')
%     title('LSAR interpolation')
    %BRAKEPOINT HERE
end

end

