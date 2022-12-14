% eeg signal to 5 bands and applying fft to this bands 

clc
clear all
%close all
warning('off')
a = csvread('eeg_handmovement.csv');
fs = 100;
t = length(a)/fs;
t1 = 0:0.01:t-0.01;

figure;
plot(t1,a)
xlabel('Time (Seconds)');
ylabel('EEG Data');
title('EEG Signal')

% Sampling frequency
N=length(a);
figure;
freqz(a)  % freq V/S eeg signal 

% EXTRACTION OF BANDS FROM EEG SIGNAL 
waveletFunction = 'db8';
                [C,L] = wavedec(a,8,waveletFunction);
       
                cD1 = detcoef(C,L,1);
                cD2 = detcoef(C,L,2);
                cD3 = detcoef(C,L,3);
                cD4 = detcoef(C,L,4);
                cD5 = detcoef(C,L,5); %GAMA
                cD6 = detcoef(C,L,6); %BETA
                cD7 = detcoef(C,L,7); %ALPHA
                cD8 = detcoef(C,L,8); %THETA
                cA8 = appcoef(C,L,waveletFunction,8); %DELTA
                D1 = wrcoef('d',C,L,waveletFunction,1);
                D2 = wrcoef('d',C,L,waveletFunction,2);
                D3 = wrcoef('d',C,L,waveletFunction,3);
                D4 = wrcoef('d',C,L,waveletFunction,4);
                D5 = wrcoef('d',C,L,waveletFunction,5); %GAMMA
                D6 = wrcoef('d',C,L,waveletFunction,6); %BETA
                D7 = wrcoef('d',C,L,waveletFunction,7); %ALPHA
                D8 = wrcoef('d',C,L,waveletFunction,8); %THETA
                A8 = wrcoef('a',C,L,waveletFunction,8); %DELTA
                
                Gamma = D5;
                figure; subplot(5,1,1); plot(1:1:length(Gamma),Gamma);title('GAMMA');
               
                Beta = D6;
                subplot(5,1,2); plot(1:1:length(Beta), Beta); title('BETA');
                
                
                Alpha = D7;
                subplot(5,1,3); plot(1:1:length(Alpha),Alpha); title('ALPHA'); 
                
                Theta = D8;
                subplot(5,1,4); plot(1:1:length(Theta),Theta);title('THETA');
                D8 = detrend(D8,0);
                
                Delta = A8;
                subplot(5,1,5);plot(1:1:length(Delta),Delta);title('DELTA');
 
% GAMMA FFT
a = 350;
D5 = detrend(D5,0);
xdft = fft(D5);
freq = 0:N/length(D5):a/2;
xdft = xdft(1:a/2+1);
figure;subplot(511);plot(freq,abs(xdft));title('GAMMA-FREQUENCY');
[~,I] = max(abs(xdft));
fprintf('Gamma:Maximum occurs at %3.2f Hz.\n',freq(I));

%BETA FFT
D6 = detrend(D6,0);
xdft2 = fft(D6);
freq2 = 0:N/length(D6):a/2;
xdft2 = xdft2(1:a/2+1);
% figure;
subplot(512);plot(freq2,abs(xdft2));title('BETA-FREQUENCY');
[~,I] = max(abs(xdft2));
fprintf('Beta:Maximum occurs at %3.2f Hz.\n',freq2(I));

%ALPHA FFT
D7 = detrend(D7,0);
xdft3 = fft(D7);
freq3 = 0:N/length(D7):a/2;
xdft3 = xdft3(1:a/2+1);
% figure;
subplot(513);plot(freq3,abs(xdft3));title('ALPHA-FREQUENCY');
[~,I] = max(abs(xdft3));
fprintf('Alpha:Maximum occurs at %f Hz.\n',freq3(I));
           
%THETA FFT
xdft4 = fft(D8);
freq4 = 0:N/length(D8):a/2;
xdft4 = xdft4(1:a/2+1);
% figure;
subplot(514);plot(freq4,abs(xdft4));title('THETA-FREQUENCY');
[~,I] = max(abs(xdft4));
fprintf('Theta:Maximum occurs at %f Hz.\n',freq4(I));

% DETLA FFT
A8 = detrend(A8,0);
xdft5 = fft(A8);
freq5 = 0:N/length(A8):a/2;
xdft5 = xdft5(1:a/2+1);
% figure;
subplot(515);plot(freq3,abs(xdft5));title('DELTA-FREQUENCY');
[~,I] = max(abs(xdft5));
fprintf('Delta:Maximum occurs at %f Hz.\n',freq5(I));
