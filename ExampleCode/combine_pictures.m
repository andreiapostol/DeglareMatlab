rendered_name_folder = 'Glare/2';
[num_x, num_y, base_x, base_y] = parse_params(rendered_name_folder);
x_length = 32;
y_length = 32;
glared_images = zeros(x_length*num_x,y_length*num_y,3,'uint8');
% tic;
for i = 0:(num_x-1)
    for j = 0:(num_y-1)
        readLeft = int2str(i);
        if i < 10
            readLeft = strcat("0",readLeft);
        end
        readRight = int2str(j);
        if j < 10
            readRight = strcat("0",readRight);
        end
        fileName = strcat(rendered_name_folder, "/", readLeft, "_", readRight, ".png");
        img = rot90(imread(fileName),2);
%         imshow(img);
        glared_images(i*x_length + 1:(i+1)*x_length,(j*y_length+1):(j+1)*y_length,:) = img(:,:,:);
    end
end
% toc
glared_images = rot90(glared_images, 2);
imshow(glared_images);