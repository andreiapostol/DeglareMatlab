function glare_all(folder, out_dir, no_diff_squares, no_diff_kernels)
    all_files = dir(fullfile(folder, '*.hdr'));
%     all_files_names = all_files.name;
    all_files_names = all_files(~endsWith({all_files.name}, '_CC.hdr'));
    x0=10; y0=100; width=1200; height=1200;
    set(gcf,'position',[x0,y0,width,height])
    f = waitbar(0,'1','Name','Creating dataset...',...
    'CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
    load('./GlaredData/image_sizes.mat', 'image_sizes');
%     max_sizes = min(image_sizes);
    max_sizes = [512, 512, 3];
    no_of_images = length(all_files_names);
    x_max = max_sizes(1); y_max = max_sizes(2);
    steps = no_of_images * no_diff_squares * no_diff_kernels;
    
    % For the large ones:
    coord_boundaries = zeros(4, 2);
    coord_boundaries(1, :) = [42.5, 49.5];
    coord_boundaries(2, :) = [2.0e+15, 15.0e+15];
    coord_boundaries(3, :) = [0.012, 0.020];
    coord_boundaries(4, :) = [10, 100];

    for i=1:no_of_images
        cur_file_name = fullfile(folder, all_files_names(i).name);
        cur_img = hdrread(cur_file_name);
        cur_img = cur_img(1:x_max, 1:y_max, :);
        all_glared = zeros(no_diff_squares * no_diff_kernels, x_max, y_max, 3);
        all_square_pos = zeros(no_diff_squares * no_diff_kernels, 2, 2);
        all_kernels = zeros(no_diff_squares * no_diff_kernels, 4);
        for j=1:no_diff_squares
            [cur_square_img, square_coords] = add_random_square(cur_img, true);
            tonemapped_cur = tonemap(cur_square_img);
            subplot(2,1,1); imshow(tonemapped_cur);
            for z=1:no_diff_kernels
                waitbar(((i-1)*no_diff_squares * no_diff_kernels + (j-1) * no_diff_kernels + z)/steps, ...
                    f,sprintf('%s', all_files_names(i).name));
                kernel = get_random_kernel(coord_boundaries);
                [cur_glared, ~, ~] = glare_image(cur_square_img, kernel);
                cur_index = (j-1)*no_diff_kernels + z;
                all_glared(cur_index, :, :, :) = cur_glared;
                all_square_pos(cur_index, :, :) = square_coords;
                all_kernels(cur_index, :) = kernel;
                subplot(2,1,2); imshow(tonemap(squeeze(all_glared(cur_index, :, :, :)))); shg;
                
            end
        end
        save(sprintf('%s/%s.mat', out_dir, all_files_names(i).name), 'all_glared', 'all_square_pos', 'all_kernels');
    end
    
    
    save(sprintf('%s/coord_boundaries.mat', out_dir), 'coord_boundaries');
    
%     example = fullfile(folder, all_files_names(1))
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