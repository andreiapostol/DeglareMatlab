all_files = dir(fullfile("./Input/FuntEtAl/NIKON_D700_HDR_MATLAB_3x3", '*.hdr'));
all_files_names = all_files(~endsWith({all_files.name}, '_CC.hdr'));
no_of_images = length(all_files_names);
for i=1:no_of_images
    cur_file_name = fullfile("./Input/FuntEtAl/NIKON_D700_HDR_MATLAB_3x3", all_files_names(i).name);
    cur_img = hdrread(cur_file_name);
    cur_img = make_square(cur_img);
    cur_img_resized = imresize(cur_img, [512, 512], 'bilinear');
    imshow(tonemap(cur_img_resized));
    hdrwrite(cur_img_resized, sprintf("./SmallHdrDataset/%s",all_files_names(i).name));
end