img_name = './Input/masked-coach-scene.png';
% img_name = './Input/hdr-with-square.hdr';
is_hdr = img_name(end-2:end) == 'hdr';
if ~is_hdr
    I = im2double(imread(img_name));
else
    I = hdrread(img_name);
end

scale_factor = 1.0; % How much the resolution of the image was reduced (relative to the original image captured by the camera)
I = imresize( I, scale_factor, 'box' );
% figure; imshow(tonemap(I));
dispImg(I, is_hdr);

[I_g, MTF, pad_val] = glare_image(I, [ 45.4842, 3.09977e+15, 0.0195372, 99.24992499 ]);
% figure; imshow(tonemap(I_g));
dispImg(I_g, is_hdr);
disp("Convolved successfully.");

I_f = zeros(size(I));
for cc=1:3
    I_f(:,:,cc) = fast_conv_fft(I_g(:,:,cc), MTF, pad_val, false);
end

dispImg(I_f, is_hdr);
% figure; imshow(tonemap(I_f));

function dispImg(I, is_hdr)
    figure;
    if ~is_hdr
        imshow(I);
    else
        imshow(tonemap(I));
    end
end
