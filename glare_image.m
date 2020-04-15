function [glared, MTF, pad_val] = glare_image(I, params)
    sz = [size(I,1) size(I,2)];
    selected_gsf = @(R) camera_gsf( R, params);
    % Replace 1.0 with scale_factor
    GSF = gsf2filter( sz*2, 1.0, selected_gsf );
    MTF = abs(fft2( GSF ));
    pad_val = geomean(I(:));
    glared = zeros(size(I));
    for cc=1:3
        glared(:,:,cc) = fast_conv_fft( I(:,:,cc), MTF, pad_val, true );
    end
end