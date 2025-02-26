clear; clc;

% Step 1: Generate a synthetic 3D tensor
I = 10; J = 10; K = 10; % Dimensions of the tensor
X = randn(I, J, K);     % Random 3D tensor of size I x J x K

% Step 2: Perform Tucker Decomposition
% Specify the desired ranks for each mode
R1 = 5; % Rank for mode 1
R2 = 5; % Rank for mode 2
R3 = 5; % Rank for mode 3

% Perform Tucker decomposition using the Tensor Toolbox
[G, U1, U2, U3] = tucker_als(X, [R1, R2, R3]);

% Step 3: Reconstruct the tensor from the decomposition
X_reconstructed = ttm(G, {U1, U2, U3}, [1, 2, 3]);

% Step 4: Evaluate the reconstruction error
reconstruction_error = norm(X(:) - X_reconstructed(:)) / norm(X(:));
fprintf('Reconstruction Error: %.4f\n', reconstruction_error);

% Step 5: Visualize the original and reconstructed tensors (optional)
% Display a slice of the original and reconstructed tensors
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