% HAND_SIGNATURE - estimate the signature of the given hand region
%
% S = HAND_SIGNATURE(B)
%
% S is a 1x260 element array of distances one for each angle between 0 and
% 359 degrees.

function S = hand_signature(B)
%
% 1.	Find the centroid of the hand and the coordinates of pixels on the hand boundary (this can be readily obtained using regionprops)
% 2.	Subtract the centroid position (cx,cy) from the boundary pixel coordinates to give a list of points centred on (0,0).
% 3.	For each rotation X from 0 to 359 degrees:
%   a.	Rotate the coordinates by angle X
%   b.	Find the edge points within approximately 2 pixels of the y-axis.
%   c.	Set the signature for angle X to be the maximum y value of the identified points. If the value is less than zero then set it to zero.

% ----- INSERT YOUR CODE HERE ---

 % Find properties: centroid and boundary
 props = regionprops(B, 'Centroid', 'BoundingBox');
 centroid = props.Centroid;

 % Get the boundary coordinates of the binary region
 boundary = bwboundaries(B);
 boundaryPixels = boundary{1};  % First object boundary

 % Center the boundary pixels around (0,0) by subtracting centroid
 x = boundaryPixels(:,2) - centroid(1);
 y = boundaryPixels(:,1) - centroid(2);

 % Preallocate space for signature
 S = zeros(1, 360);

 % Iterate over angles from 0 to 359 degrees
 for theta = 0:359
     % Convert angle to radians
     angleRad = deg2rad(theta);

     % Rotate coordinates using rotation matrix
     x_rot = x * cos(angleRad) + y * sin(angleRad);
     y_rot = -x * sin(angleRad) + y * cos(angleRad);

     % Find points near y-axis (within ~2 pixels of y-axis)
     y_axis_indices = abs(x_rot) < 2;  % Threshold for proximity to y-axis

     % If points exist near the y-axis, take the maximum y-value (distance)
     if any(y_axis_indices)
         S(theta + 1) = max(y_rot(y_axis_indices)); 
     else
         S(theta + 1) = 0;  % If no points, set to 0
     end

     % Ensure values are non-negative
     S(theta + 1) = max(S(theta + 1), 0);
 end

 % Normalize signature by dividing by the mean to handle scale variations
 S = S / mean(S);

% ----- INSERT YOUR CODE ABOVE ----

% % PLOT - use this for debugging as needed
%subplot(2,2,1);
%imagesc(B);
%title('Region');
%subplot(2,1,2);
%plot(S); title('Signature');
%xlabel('Angle (deg)');
%ylabel('Distance');
%drawnow;

return
