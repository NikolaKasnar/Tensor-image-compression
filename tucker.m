clc; clear; close all;
%addpath('tensor_toolbox'); % Library koji nam treba za tenzore

% Pretvorimo sliku u tenzor
img = im2double(imread('your_image.jpg')); % Load an image
tensor_img = tensor(img); % Convert image to tensor

% Definiramo dimenzije jezgre dimensions (rank reduction)
core_dims = [size(img, 1) * 0.5, size(img, 2) * 0.5, size(img, 3)];

% napravimo Tucker dekompoziciju
[G, U] = tucker(tensor_img, round(core_dims));

% Rekonstruiramo sliku
reconstructed_img = full(ttensor(G, U));

% Prikazemo originalnu sliku i sliku dobivenu dekompresijom
figure;
subplot(1, 2, 1); imshow(img); title('Original Image');
subplot(1, 2, 2); imshow(double(reconstructed_img)); title('Reconstructed Image');

% Prikazemo omjer
original_size = numel(img);
compressed_size = numel(G) + sum(cellfun(@numel, U));
compression_ratio = compressed_size / original_size;
disp(['Compression Ratio: ', num2str(compression_ratio)]);
