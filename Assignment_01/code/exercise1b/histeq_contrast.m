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

% Convert to uint8 if needed
fixed_image = im2uint8(img);

% Initialize lookup table
look_up_table_image_source = zeros(1, 256);

% Compute histogram
[image_n, image_values] = imhist(fixed_image);

% Cumulative sum of histogram
cumsum_image_n = cumsum(image_n);

% Normalize the cumulative sum to create the lookup table
sum_image_n = sum(image_n);
first_nonzero_value = find(image_n, 1, 'first');  % First non-zero index

for i = 1:256
    if image_n(i) ~= 0
        if i == first_nonzero_value
            look_up_table_image_source(i) = 0;
        else
            look_up_table_image_source(i) = (cumsum_image_n(i) - cumsum_image_n(first_nonzero_value)) / (sum_image_n - image_n(first_nonzero_value));
        end
    end
end

% Apply the equalization by mapping through the lookup table
[image_row, image_col] = size(fixed_image);
for ii = 1:image_row
    for jj = 1:image_col
        fixed_image(ii, jj) = look_up_table_image_source(fixed_image(ii, jj) + 1) * 255;
    end
end

% Convert back to double
eq_img = im2double(fixed_image);

% ----- INSERT YOUR CODE ABOVE -----

return