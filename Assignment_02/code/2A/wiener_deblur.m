function I_deblur = wiener_deblur(I,B,k)
 
if ( isa(I,'uint8') || isa(B,'uint8') )
  error('deblur: Image and blur data should be of type double.');
end

I = edgetaper(I,B);
Fi = fft2(I);
% modify the code below ------------------------------------------------

  B_padded = zeros(size(I));

  [len_x_img, len_y_img] = size(I);
  [len_x_blur, len_y_blur] = size(B);
  
  x_offset = ceil((len_x_img-len_x_blur)/2);
  y_offset = ceil((len_y_img-len_y_blur)/2);

  for i = 1:len_x_blur
    for j = 1:len_y_blur
      B_padded(x_offset+i, y_offset+j) = B(i,j);
    end
  end
  imshow(B_padded);
  % Compute FFT of the zero-padded blur kernel
  Fb = fft2(B_padded);

  % Compute the Wiener filter in the frequency domain
  H_conj = conj(Fb);  % Conjugate of the FFT of the blur kernel
  F_deblur = (H_conj ./ (Fb .* H_conj + k)) .* Fi;

  % Convert back to spatial domain
  I_deblur = real(ifft2(F_deblur));

  % Optional: Crop or shift the result if there is spatial delay
  % (Only necessary if padding affects spatial alignment)

  % In this case, it’s likely not required as padding is centered in FFT.

return

