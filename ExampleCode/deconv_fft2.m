function y = deconv_fft2(x, m, shape)

narginchk(2,3);
if nargin < 3
    shape = 'full';    % shape default as for CONV2
end
[x, m, fsize] = padarrays(x, m, shape);
y = ifft2(fft2(x) ./ fft2(m));   % central operation, basic form
if ~isequal(fsize, size(y))
    y = y(1:fsize(1), 1:fsize(2));
end
end
