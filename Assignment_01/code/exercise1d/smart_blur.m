% SMART_BLUR - blur image to remove noise, but attempt to preserve
%  edge details where possible
%
% USAGE:
%   image_out = smart_blut( image_in , N , tolderance )
%
%    N         - size of NxN blur to apply to data (def. 5).
%    tolerance - estimate of gradient based on noise alone. Used to
%                contol weighting between oriignal and smoothed data
%                returned by function (def. 0.015)
%
% NOTE: all image data is converted to greyscale, with values in range 
%      0.0..1.0 before filtering is applied.

function B = smart_blur(I,N,tolerance)

  % convert to greyscale 0.0..1.0
  I =im2double(I);
  if (size(I,3)==3)
    I=rgb2gray(I);
  end

  % handle missing input parameters
  if (nargin<2)
    N=5;
    if (nargin<3)
      tolerance=0.015; % about 4 greylevels for 8bit data
    end
    if (nargin<1)
      error('This function requires an image as input');
    end
  end

  % ------ INSERT YOUR CODE BELOW ------

  % average filter
  ave_image = I;
  [rows, cols] = size(I);

  for row = 1:rows

    % Calculates the offset of the row for overflow
    if row + N > N
      offset_row = rows - row;
    else
      offset_row = N;
    end

    for col = 1:cols

      % Calculates the offset of the col for overflow
      if col + N > N
        offset_col = cols - col;
      else
        offset_col = N;
      end

      subset = I(row : row + offset_row, col : col + offset_col);
      ave_image(row, col) = sum(subset(:))/(offset_col * offset_row);

    end
  
  end

  Gx = (1/240) * [-4  -5   0  5   4;
                  -8  -10  0  10  8;
                  -10 -20  0  20  10;
                  -8  -10  0  10  8;
                  -4  -5   0  5   4];

  Gy = (1/240) * [ 4  8   10  8   4;
                   5  10  20  10  5;
                   0  0   0   0   0;
                  -5 -10 -20 -10 -5;
                  -4 -8  -10 -8  -4];

  Ix = conv2(double(I), Gx, "same");
  Iy = conv2(double(I), Gy, "same");

  G = zeros(size(I));

  for row = 1:rows
    for col = 1:cols
      G(row, col) = sqrt((Ix(row, col)^2) + (Iy(row, col)^2));
    end
  end

  w_func = zeros(size(I));

  for row = 1:rows
    for col = 1:cols
      weight = tolerance / G(row, col);
      if weight <= 1
        w_func(row, col) = weight;
      else
        w_func(row, col) = 1;
      end
    end
  end

  B = zeros(size(I));

  for row = 1:rows
    for col = 1:cols
      B(row, col) = (w_func(row, col) * ave_image(row, col)) + ((1 - w_func(row, col)) * I(row, col));
    end
  end

  % ------ INSERT YOUR CODE ABOVE ------

  return
end

