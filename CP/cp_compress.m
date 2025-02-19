clc; clear; close all;

%% Učitavanje slike
img = imread('cat.jpg');
img = im2double(img);
[I1, I2, I3] = size(img);

%% Pretvaranje slike u tenzor
X = tensor(img);

%% CP dekompozicija
R = 50; % Rang kompresije (veći R = bolja rekonstrukcija)
[P, Uinit, output] = cp_als(X, R, 'tol', 1e-6, 'maxiters', 50, 'printitn', 1);

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

