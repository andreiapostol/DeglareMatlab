function Y = wiener_deconvolution( X, fH, pad_value, K)
    fH = fH ./ sum(fH, 'all');
    pad_size = (size(fH)-size(X));

    padded = padarray( X, pad_size, pad_value, 'post' );
    fX = fft2( padded );
    kernel = conj(fH) ./ (abs(fH) .^ 2 + K);
    Y = real(ifft2(fX ./ kernel));
%     Y = real(ifft2( fX ./ fH, size(fX,1), size(fX,2), 'symmetric' ));
    Y = Y(1:size(X,1),1:size(X,2));
    
%     result_pad_value = geomean(Y(:));
%     result_padded = padarray(Y, pad_size, result_pad_value, 'post');
%     result_padded_fft = fft2(result_padded);
%     result_padded_real = real(ifft2( result_padded_fft .* fH, size(fX,1), size(fX,2), 'symmetric' ));
%     subplot(1,2,1);
%     imshow(tonemap(result_padded_real(1:size(X,1),1:size(X,2))));
%     
%     result_padded_real(1:size(X,1),1:size(X,2)) = X(1:size(X,1),1:size(X,2));
%     subplot(1,2,2);
%     imshow(tonemap(result_padded_real(1:size(X,1),1:size(X,2))));
%     pause;
%     
%     padded = result_padded_real;
%     fX = fft2( padded );
%     kernel = conj(fH) ./ (abs(fH) .^ 2 + K);
%     Y = real(ifft2(fX ./ kernel));
%     Y = Y(1:size(X,1),1:size(X,2));
end

%     Y = Y - min(Y, [], 'all');
%     Y = Y ./ max(Y, [], 'all');
%     Y = Y .* Y;
%     Y(Y<0) = 0;
