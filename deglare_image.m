function deglared = deglare_image(I, mask_plus, mask_minus)
    g = create_g(mask_minus, I, 25);
    deglared = create_s(mask_plus, I, g);
end