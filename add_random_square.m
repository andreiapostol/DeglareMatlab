function [I, coords] = add_random_square(I, is_hdr)
    sz = [size(I, 1), size(I, 2)];
    bottom_width = floor(sz(1) / 16); top_width = floor(sz(1) / 6);
    bottom_height = floor(sz(2) / 16); top_height = floor(sz(2) / 6);
    width = randi([bottom_width top_width]);
    height = randi([bottom_height top_height]);
    x_coord = randi([1 sz(1)-width]);
    y_coord = randi([1 sz(2)-height]);
    coords = [x_coord, y_coord; (x_coord+width), (y_coord+height)];
    var_to_set = 1.0;
    if exist( 'is_hdr', 'var' ) && is_hdr
        var_to_set = 0.0;
    end
    I(x_coord:(x_coord+width), y_coord:(y_coord+height), :) = var_to_set;
end