noisy_cur_image = cur_image ./ max(cur_image, [], 'all');
for i = 1:3
    noisy_cur_image(:,:,i) = imnoise(noisy_cur_image(:,:,i),'gaussian', 0, 0.000005);
end

subplot(1,2,1); imshow(tonemap(noisy_cur_image));
subplot(1,2,2); imshow(tonemap(cur_image));

estim_and_plot(noisy_cur_image, cur_kernel, cur_square_pos);

function estim_and_plot(image, kernel, square_pos)
    start_estim = kernel .* 1.25;
    new_kernel = estimate_kernel(image, square_pos, start_estim);
    subplot(2,2,1); imshow(tonemap(image));
    subplot(2,2,2); imshow(tonemap(deglare_with_kernel(image, kernel)));
    deglared_I = deglare_with_kernel(image, new_kernel);
    subplot(2,2,3); imshow(tonemap(deglared_I));
    subplot(2,2,4); imshow(tonemap(deglare_with_kernel(image, start_estim)));
end