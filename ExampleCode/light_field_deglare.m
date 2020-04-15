rendered_name_folder = 'Glare/1';
filePattern = fullfile(rendered_name_folder, '*.png');
rendered_images = dir(filePattern);
[num_x, num_y, base_x, base_y] = parse_params(rendered_name_folder);
glared_images = zeros(1080,1920,3,num_x*num_y, 'uint8');
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
        img = imread(fileName);
        glared_images(:, :, :, i*num_x + j + 1) = img;
    end
end

imshow(glared_images(:, :, :, 25));