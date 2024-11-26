function Imatch = hitormiss_3x3(I,M)

  if (ndims(I)==3)
    I=I(:,:,2);
  end
  if (isa(I,'uint8'))
    I=double(I)/255;
  end

  % --------------- INSERT YOUR CODE BELOW -----------------

  [i_x, i_y] = size(I); 
  Imatch = zeros(size(I));

  % 0 - black - unset - (-1)
  % 255 - white - set - (1)

  % Iterate through each pixel in the original image
  for j = 2:i_y-1
    for i = 2:i_x-1
      % Extract the 3x3 neighborhood around the pixel
      subset_img = I(i-1:i+1, j-1:j+1);
      
      % Apply erosion with the 3x3 structuring element M
      Imatch(i, j) = erode_3x3(subset_img, M);
    end
  end
% --------------- INSERT YOUR CODE ABOVE -----------------

return


% erode_3x3(I,S) - apply erosion using the 3x3 structure element S

function E = erode_3x3(I,S)
  
  E = 1;
  
  for j = 1:3
    for i = 1:3
      if S(i, j) == 0 % 'Don't care' case
        continue;
      end
      if S(i,j) == -1
        S(i,j) = 0;
      end
      % Check for mismatch
      if I(i, j) ~= S(i, j)
        E = 0; % Mismatch found
        return;
      end
    end
  end
return
