clear; close all; clc;

rng('default')

% Reading audio input
[input, Fs] = audioread("input.wav");
input = input(:,1)'; % Considering only right channel


% Defining windowing
M = 2048 ;
hop = M/2;
win = hann(M);

% AR model order 
P = 20;

% Total number of analysis windows
n_windows = floor((length(input)-M)/hop + 1);

% Padding input to fit all the windows
padded_input = zeros(1, n_windows * hop + M);
padded_input(1:length(input)) = input;

% Defining restored signal
restored = zeros(1, length(padded_input));

% Iterating over the windows
for nth_wnd = 0:n_windows
    disp(nth_wnd/n_windows * 100);
    
    % Extracting frame and removing the mean (zero-mean signal)
    frame = padded_input(nth_wnd * hop + 1 : nth_wnd * hop + M);
    frame_mean = mean(frame);
    frame = frame - frame_mean;    


    % Iteraing algorithm (see pag. 130 Godsill-Reiner)
    for iterations = 1:3 
        % Estimating parameters and prediction error
        [a_ml, e_d] = estimate_params(frame, P);

    
        % Detecting clicks
        k = 4;
        i = click_detection(e_d, k, M, P);

    
        % LSAR interpolation
        frame = interpolation(frame, i, M, a_ml, P);
    end
  
    % Re-add mean
    frame = frame + frame_mean;

    % Windowing for OLA
    frame = frame .* win';

    % OLA
    restored(nth_wnd * hop + 1 : nth_wnd * hop + M) = ...
        restored(nth_wnd * hop + 1 : nth_wnd * hop + M) + frame; 
end

figure;
plot(padded_input(1:Fs*3));
hold on
plot(restored(1:Fs*3))
title('Comparison')
legend('original', 'restored')

audiowrite("restored.wav", restored, Fs);

% output audio playback
% output_player = audioplayer(s, Fs);
% play(output_player); 