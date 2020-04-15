function get512by512()
    all_files = dir(fullfile("./StanfordData", '*.hdr'));
    no_of_images = length(all_files);

    for i=1:no_of_images
        if all_files(i).bytes < 1544987
%             disp(all_files(i).name);
            hdrIn = hdrread(fullfile("./StanfordData", all_files(i).name));
            hdrOut = make_square(hdrIn);
            hdrwrite(hdrOut, sprintf("./SmallHdrDataset/%s", all_files(i).name));
            imshow(tonemap(hdrOut));
        end
    end
end

% 5244987