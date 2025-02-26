clc; clear; close all;

% 1️⃣ Učitavanje slike
img = imread('pas2.jpg');
img = double(img);

% Ako je slika RGB, razdvoji kanale
if ndims(img) == 3
    R = img(:,:,1);
    G = img(:,:,2);
    B = img(:,:,3);
else
    R = img;  % Ako je već crno-bijela, koristi samo jedan kanal
    G = R;
    B = R;
end

% 2️⃣ Tucker dekompozicija po kanalima
R1 = 50;  % Rank za redukciju
R2 = 50;

% Funkcija za Tucker dekompoziciju jednog kanala
function reconstructed = tucker_decomp(X, R1, R2)
    [U, S, V] = svd(X, 'econ');
    U = U(:, 1:R1);
    S = S(1:R1, 1:R1);
    V = V(:, 1:R2);
    G = U' * X * V;
    reconstructed = U * G * V';
end

% Primjena Tucker dekompozicije na svaki kanal
R_rec = tucker_decomp(R, R1, R2);
G_rec = tucker_decomp(G, R1, R2);
B_rec = tucker_decomp(B, R1, R2);

% 3️⃣ Rekonstrukcija slike
reconstructed_img = cat(3, R_rec, G_rec, B_rec);

% 4️⃣ Prikaz rezultata
subplot(1,2,1);
imshow(uint8(img)), title('Originalna slika');

subplot(1,2,2);
imshow(uint8(reconstructed_img)), title('Rekonstruirana slika');

imwrite(uint8(reconstructed_img), 'rekonstruirana_slika2.jpg');

