function new_kernel = estimate_kernel(I, square_pos, estimation)
    options = optimset('PlotFcns',@optimplotfval, 'MaxIter', 100, 'MaxFunEvals', 2000);
%     added_padding = estimation(:);
%     added_padding(end+1) = 10;
    new_kernel = fminsearch(@(x) calculate_loss(I, square_pos, x), estimation, options);
%     new_kernel = new_kernel(1:end-1);
end

function loss = calculate_loss(I, square_pos, estimation)
    deglared_I = deglare_with_kernel(I, estimation);
    square = deglared_I(square_pos(1,1):square_pos(2,1), square_pos(1,2):square_pos(2,2), :);
%     contr = max(deglared_I, [], 'all') - min(deglared_I, [], 'all');
    loss = sum(square, 'all');
end

function a = f(a)
    a = a * a - 25 + a;
end