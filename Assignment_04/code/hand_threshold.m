% IMAGE_THRESH - estimate a suitable image threshold value using isothresh
%
function T = hand_threshold(I)

if (isa(I,'uint8'))
  I=double(I)/255;
end

% ---------- INSERT YOUR CODE BELOW ------------------------------------

% Initial threshold T (mean intensity)
T = mean(I(:));

% Iterative isothresh calculation (10 iterations)
for k = 1:10
  % Calculate mean intensities for pixels above and below the threshold
  I_above = I(I > T);
  I_below = I(I <= T);
  
  % Avoid empty regions by checking for non-empty sets
  mean_above = mean(I_above(:));
  mean_below = mean(I_below(:));

  % Update threshold using the isothresh formula
  T = (mean_above + mean_below) / 2;
end

% ---------- INSERT YOUR CODE ABOVE ------------------------------------

% END FO FILE
    


