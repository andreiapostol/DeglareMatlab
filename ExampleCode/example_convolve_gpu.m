% I = pfs_read_image( 'nancy_church.hdr' );

img_name = './Input/masked-coach-scene.png';
I = imread(img_name);
%%

tic

sz = [size(I,1) size(I,2)];
[xx,yy] = meshgrid( -sz(2):sz(2), -sz(1):sz(1) );
R = sqrt( xx.^2 + yy.^2 );

GSF = camera_gsf(R, [ 1.02412, 9.36422e-05, 0.999879, 1.99925, 12.64222e-06, 0.135824, 0.697524 ]);

I = im2double(I);
GSF = im2double(GSF);
I_g = zeros(size(I));

for cc=1:3
    I_g(:,:,cc) = conv_fft2(I(:,:,cc), GSF, 'reflect');
end

figure(1);
imshow(I);
figure(2);
imshow(I_g);
imwrite(I_g, strcat("glared-", img_name));
toc

% 94 x 99




