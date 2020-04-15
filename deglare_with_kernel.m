function deglared = deglare_with_kernel(I, kernel, pad_val)
    sz = [size(I,1) size(I,2)];
    selected_gsf = @(R) camera_gsf( R, kernel);
    % Replace 1.0 with scale_factor
    GSF = gsf2filter( sz*2, 1.0, selected_gsf );
    MTF = abs(fft2( GSF ));
    
    if ~exist('pad_val', 'var')
%         pad_val = geomean(I(:));
        pad_val = 0.25;
    end
%     deglared = zeros(size(I));
    for cc=1:3
        deglared(:,:,cc) = fast_conv_fft( I(:,:,cc), MTF, pad_val, false );
    end
    
    if min(deglared, [], 'all') < 0
        deglared = deglared - min(deglared, [], 'all');
        deglared = deglared ./ max(deglared, [], 'all');
    end
    
end