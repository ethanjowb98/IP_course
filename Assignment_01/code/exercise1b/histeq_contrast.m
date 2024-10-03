% HISTEQ_CONTRAST - histogram equalisation for contrast enhancement
%
% Usage:
%         eq_img = histeq_contrast(img)
%
%  input image data is assumed to be in range 0..1

function eq_img = histeq_contrast(img)

% ----- INSERT YOUR CODE BELOW -----

% OPTIONAL HINT to make it easier to index you can multiply the img 
%   values by 255 and use a 256 element histogram.

fixed_image = im2uint8(img);

look_up_table_image_source = zeros(size(1:256));
[image_n, image_values] = histcounts(fixed_image);
[size_row, size_column] = size(image_n);

image_values = abs(round(image_values));
hist_values = zeros(size(1:256));

for i = 1:size_column
    hist_values(image_values(i)) = image_n(i);
end

sum_image_n = sum(image_n);
cumsum_image_n = cumsum(hist_values);
first_nonzero_value = 0;

for i = 1:size_column
    if hist_values(image_values(i)) ~= 0
        if first_nonzero_value == 0
            first_nonzero_value = hist_values(image_values(i));
            look_up_table_image_source(image_values(i)) = 0;
        else
            look_up_table_image_source(image_values(i)) = (cumsum_image_n(image_values(i)) - first_nonzero_value) / sum_image_n;
        end
    end
end

[image_row, image_col] = size(fixed_image);

for ii = 1:image_row
    for jj = 1:image_col
        fixed_image(ii, jj) = look_up_table_image_source(fixed_image(ii, jj) + 1) * 255;
    end
end
eq_img = im2double(fixed_image);

% ----- INSERT YOUR CODE ABOVE -----

return