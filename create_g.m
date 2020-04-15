function g = create_g(m_minus, r, size)
    occluded = m_minus .* r;

    numerator = imgaussfilt(occluded, size);
    denominator = imgaussfilt(m_minus, size);

    g = numerator ./ denominator;
end