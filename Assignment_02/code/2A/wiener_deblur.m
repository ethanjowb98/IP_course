function I_deblur = wiener_deblur(I,B,k)
 
if ( isa(I,'uint8') || isa(B,'uint8') )
  error('deblur: Image and blur data should be of type double.');
end

I = edgetaper(I,B);
Fi = fft2(I);
% modify the code below ------------------------------------------------

  B_padded = zeros(size(I));

  [len_x_blur, len_y_blur] = size(B);

  x_offset = 0;
  y_offset = 0;

  for i = 1:len_x_blur
    for j = 1:len_y_blur
      B_padded(x_offset+i, y_offset+j) = B(i,j);
    end
  end

  % Compute FFT of the zero-padded blur kernel
  Fb = fft2(B_padded);

  % Compute the Wiener filter in the frequency domain

  [len_x_f, len_y_f] = size(Fb);

  F_deblur = zeros(size(I));
  F_deblur = fft2(F_deblur);

  for i = 1:len_x_f
    for j = 1:len_y_f
      F_deblur(i,j) = (Fi(i,j)/Fb(i,j))*(abs(Fb(i,j)^2)/(abs(Fb(i,j)^2)+k));
    end
  end

  % Convert back to spatial domain
  I_deblur = real(ifft2(F_deblur));

  % Optional: Crop or shift the result if there is spatial delay
  % (Only necessary if padding affects spatial alignment)

  % In this case, it’s likely not required as padding is centered in FFT.

return

