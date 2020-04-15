function create_deglared_dataset(folder, out_dir_glared, out_dir_deglared)
    coord_boundaries = zeros(4, 2);
    coord_boundaries(1, :) = [39, 46];
    coord_boundaries(2, :) = [2.0e+15, 15.0e+15];
    coord_boundaries(3, :) = [0.012, 0.020];
    coord_boundaries(4, :) = [10, 100];
    
    all_files = dir(fullfile(folder, '*.hdr'));
%     all_files_names = all_files.name;
    all_files_names = all_files(~endsWith({all_files.name}, '_CC.hdr'));
    max_sizes = [512, 512, 3];
    no_of_images = length(all_files_names);
    x_max = max_sizes(1); y_max = max_sizes(2);
    for i=1:no_of_images
        cur_file_name = fullfile(folder, all_files_names(i).name);
        cur_img = hdrread(cur_file_name);
        cur_img = cur_img(1:x_max, 1:y_max, :);
        normalised = cur_img ./ max(cur_img, [], 'all');
%         normalised = normalize(cur_img);
        glaring_kernel = get_random_kernel(coord_boundaries);
        [cur_glared, ~, ~] = glare_image(normalised, glaring_kernel);
        random_nums = rand(1,4);
        cur_glared = cur_glared / max(cur_glared, [], 'all');
%         cur_glared = normalize(cur_glared);
        deglaring_kernel = glaring_kernel;
        deglaring_kernel = glaring_kernel + glaring_kernel .* (random_nums - 0.5) * 0.05;
        deglared = deglare_with_kernel(cur_glared, deglaring_kernel);
        write_glared_file_name = sprintf("%s/%s", out_dir_glared, all_files_names(i).name);
        write_deglared_file_name = sprintf("%s/%s", out_dir_deglared, all_files_names(i).name);
        deglared = deglared / max(deglared, [], 'all');
%         deglared = normalize(deglared);
        hdrwrite(cur_glared, write_glared_file_name);
        hdrwrite(deglared, write_deglared_file_name);
        deglared = hdrread(write_deglared_file_name);
        subplot(1,3,1); imshow(tonemap(normalised));
        subplot(1,3,2); imshow(tonemap(cur_glared));
        subplot(1,3,3); imshow(tonemap(deglared)); shg;
    end
end

function kernel = get_random_kernel(coord_boundaries)
    kernel = [];
    for i=1:4
        kernel(i) = get_rand_between_vals(coord_boundaries(i,1), coord_boundaries(i,2));
    end
end

function rand_val = get_rand_between_vals(bottom, top)
    rand_val = (top - bottom) * rand + bottom;
end

function I = normalize(I)
    I = I - min(I, [], 'all');
    I = I / max(I, [], 'all');
end