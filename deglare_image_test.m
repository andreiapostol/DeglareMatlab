imname = "3.png";
glared = im2double(imread(sprintf('Glare/Coach/%s', imname)));
mask_plus = im2double(imread('Masks/1_plus.png'));
mask_minus = im2double(imread('Masks/1_minus.png'));

deglared = deglare_image(glared, mask_plus, mask_minus);
imshow(deglared);
imwrite(deglared, sprintf('Deglared/Coach/%s', imname));