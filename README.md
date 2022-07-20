# LSAR-click-removal
For an explanation of the algorithm, refer to this [presentation](https://github.com/heyGio/LSAR-click-removal/blob/c9008de91fb51302c6f3a325462df7d4df84865c/LSAR%20click%20removal.pdf).

Project for the course of Sound Analysis, Synthesis and Processing.

**Before restoration:**


https://user-images.githubusercontent.com/39062949/179970671-ea618adf-d98c-4ec9-9f85-5ec5601631ba.mov

**After:**

https://user-images.githubusercontent.com/39062949/179972169-85ec5d0f-98cf-4200-b4a0-6fa3b29052dc.mov

In the *results* folder you can find other restored sound files.

## How to use
- Clone the repository
- Open the *main.m* file in MATLAB
- Change line 6 `[input, Fs] = audioread("input.wav");` by replacing `input.wav` with the path of the file you want to restore
- The restored version will be written in `restored.wav` 
