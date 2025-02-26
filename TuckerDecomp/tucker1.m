clear; clc;

% Generiramo 3D tenzor
I = 10; J = 10; K = 10; % Dimensions of the tensor
X = randn(I, J, K);     % Random 3D tensor of size I x J x K

% Napravimo Tucker dekompoziciju
% Specificiramo rankove
R1 = 5; % Rank for mode 1
R2 = 5; % Rank for mode 2
R3 = 5; % Rank for mode 3

% Napravimo Tucker dekompoziciju koristeci Tensor toolbox
[G, U1, U2, U3] = tucker_als(X, [R1, R2, R3]);

% Rekonstuiramo tenzor iz dekompozicije
X_reconstructed = ttm(G, {U1, U2, U3}, [1, 2, 3]);

% Evaluiramo gresku
reconstruction_error = norm(X(:) - X_reconstructed(:)) / norm(X(:));
fprintf('Reconstruction Error: %.4f\n', reconstruction_error);

% Vizualiziramo originalni i rekonstruirani tenzor
slice_original = X(:, :, 1); % First slice of the original tensor
slice_reconstructed = X_reconstructed(:, :, 1); % First slice of the reconstructed tensor

figure;
subplot(1, 2, 1);
imagesc(slice_original);
title('Original Tensor Slice');
colorbar;

subplot(1, 2, 2);
imagesc(slice_reconstructed);
title('Reconstructed Tensor Slice');
colorbar;