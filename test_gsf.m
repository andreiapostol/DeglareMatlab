selected_gsf = @(R) camera_gsf( R, [35,1.75e+15,0.015,50]);
GSF = gsf2filter( [512,512], 1.0, selected_gsf );
GSF = GSF - min(GSF, [], 'all');
GSF = GSF ./ max(GSF, [], 'all');
sum_rows = sum(GSF, 1);
mid_row = GSF(256, :);

filt = -255:256;
filt = selected_gsf(filt);

% subplot(2,1,1);
% plot(log(mid_row));
subplot(2,1,2);
imshow(GSF / 2 * 10000);
figure;
plot(log(filt));