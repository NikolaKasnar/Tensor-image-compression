clc; clear; close all;

%% Učitavanje slike
img = imread('cat.jpg');
img = im2double(img);
[I1, I2, I3] = size(img);

% Veličina originalne slike
original_size = whos('img');
original_size_MB = original_size.bytes / (1024 * 1024); % Pretvaranje u MB

%% Pretvaranje slike u tenzor
X = tensor(img);

%% CP dekompozicija
R = 500; % Rang kompresije (veći R = bolja rekonstrukcija)
[P, Uinit, output] = cp_als(X, R, 'tol', 1e-6, 'maxiters', 50, 'printitn', 1);

% Veličina faktorskih matrica nakon kompresije
A_size = whos('P');
A_bytes = numel(P.U{1}) * 8; % Svaki double zauzima 8 bajtova
B_bytes = numel(P.U{2}) * 8;
C_bytes = numel(P.U{3}) * 8;
lambda_bytes = numel(P.lambda) * 8;

% Ukupna veličina nakon kompresije (u MB)
compressed_size_MB = (A_bytes + B_bytes + C_bytes + lambda_bytes) / (1024 * 1024);

% Faktor kompresije
compression_ratio = original_size_MB / compressed_size_MB;

%% Rekonstrukcija slike iz CP dekompozicije
X_reconstructed = full(P);

%% Prikaz originalne i rekonstruirane slike
figure;
subplot(1,2,1);
imshow(img);
title('Originalna slika');

subplot(1,2,2);
imshow(double(X_reconstructed));
title(['Rekonstruirana slika, R = ', num2str(R)]);

%% Izračunavanje greške kompresije
rmse = sqrt(mean((img(:) - double(X_reconstructed(:))).^2));
disp(['RMSE greška rekonstrukcije: ', num2str(rmse)]);

