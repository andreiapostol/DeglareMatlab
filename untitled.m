clear glared;
clear I_f;
I = aisle;
sz = [size(I,1) size(I,2)];
selected_gsf = @(R) camera_gsf( R, k);
% Replace 1.0 with scale_factor
GSF = gsf2filter( sz*2, 1.0, selected_gsf );
GSF_deconv = gsf2filter( sz*2, 1.0, selected_gsf );
MTF = abs(fft2( GSF ));
MTF_deconv = abs(fft2( GSF_deconv ));
pad_val = geomean(I(:));
I = I ./ max(I, [], 'all');
for cc=1:3
    glared(:,:,cc) = fast_conv_fft( I(:,:,cc), MTF, pad_val, true );
end
glared = glared ./ max(glared, [], 'all');

pad_val_deconv = geomean(glared(:));
for cc=1:3
    I_f(:,:,cc) = fast_conv_fft(glared(:,:,cc), MTF_deconv, pad_val, false);
end
% I_f = abs(I_f);
if min(I_f, [], 'all') < 0
    I_f = I_f - min(I_f, [], 'all');
end
I_f = I_f ./ max(I_f, [], 'all');
subplot(1,3,1);
imshow(tonemap(I));
subplot(1,3,2);
imshow(tonemap(glared));
subplot(1,3,3);
imshow(tonemap(I_f));
% imshow(tonemap(I_f(1:512,1:512,:)));
% I_f(:,:,2) = I_f(:,:,2) + 0.01;

% I_f = deglare_with_kernel(glared, k)
% I(100,100,:)
% I_f(100,100,:)
% min(min(I_f))
% subplot(1,3,1);
% imshow(tonemap(I));
% subplot(1,3,2);
% imshow(tonemap(glared));
% subplot(1,3,3);
% imshow(tonemap(I_f));