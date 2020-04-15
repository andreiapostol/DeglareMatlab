img_name = 'masked-coach-scene.png';
img = im2double(imread(img_name));

[length, width, channels] = size(img);

if ~exist('mask_plus', 'var')
    mask_plus = double(ones(size(img)));
    for i=1:length
        for j=1:width
            if img(i, j, :) == 0.0
                mask_plus(i,j,:) = 0.0;
            end
        end 
    end
end
fprintf("First\n");
bw = im2bw(mask_plus);
diff = length / 20;

% new_mask_plus = double(ones(size(img)));
for i=1:length
    for j=1:width
        if bw(i,j) == 0.0
            left_i = max(i-diff,1);
            right_i = min(i+diff,length);
            left_j = max(j-diff,1);
            right_j = min(j+diff,width);
            
            horizontal = bw(left_i:right_i, j);
            vertical = bw(i,left_j:right_j);
            if ~(all(horizontal(:) == 0.0) || all(vertical(:) == 0.0))
                mask_plus(i,j,:) = 1.0;
            end
        end
    end
end

mask_minus = 1.0 - mask_plus;
imwrite(mask_plus, 'Masks/plus.png');
imwrite(mask_minus, 'Masks/minus.png');