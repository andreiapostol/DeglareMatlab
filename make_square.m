function newImg = make_square(hdrImg)
    img_shape = size(hdrImg);
    img_shape = img_shape(1:2);
    smaller = min(img_shape);
    bigger = max(img_shape);
%     across_which_dim = 0;
    start_point = floor((bigger - smaller) / 2);
    newImg = hdrImg(:, start_point:(start_point+smaller - 1), :);
    newImg = newImg / max(max(max(newImg))) * 2;
    firstDr = max(max(max(hdrImg))) / min(min(min(hdrImg)));
    newDr = max(max(max(newImg))) / min(min(min(newImg)));
    disp(sprintf("Initial dynamic range: %f.\nNew dynamic range: %f.\n", firstDr, newDr));
end