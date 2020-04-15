function Y = fast_conv_fft( X, fH, pad_value, mult )
% Convolve with a large support kernel in the Fourier domain.
%
% Y = fast_conv_fft( X, fH, pad_value )
%
% X - image to be convolved (in spatial domain)
% fH - filter to convolve with in the Fourier domain, idealy 2x size of X
% pad_value - value to use for padding when expanding X to the size of fH
%
% (C) Rafal Mantiuk <mantiuk@gmail.com>
% This is an experimental code for internal use. Do not redistribute.

    if mult
        pad_size = (size(fH)-size(X));

        %mX = mean( X(:) );

        padded = padarray( X, pad_size, pad_value, 'post' );
        fX = fft2( padded );

        if mult
            to_insert = fX.*fH;
        else
            to_insert = fX./fH;
        end


        Yl = real(ifft2( to_insert, size(fX,1), size(fX,2), 'symmetric' ));
        Y = Yl(1:size(X,1),1:size(X,2));
    else
%         Y = real(ifft2(X ./ fH, 'symmetric'));
%         Y = Y - min(min(min(Y)));
        Y = wiener_deconvolution(X, fH, pad_value, 25);
    end
end
