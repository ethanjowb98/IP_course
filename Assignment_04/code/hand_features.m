% HAND_FEATURES - extract shape features for the supplied region of
%  interest suitable for classification.
%
% F = hand_features(B)
% 
% B = binary image mask
%
% F - an 1xN row-vector of feature measurement (real numbers)

function F = hand_features(B)

% Extract features related to shape. Make use of the concepts covered
% in the lectures. MATLAB has a number of useful pre-existing feature 
% measures to try out but I suggest you also create some of your own
% if you wish to get good results.

% ---------- INSERT YOUR CODE BELOW ------------------------------------
% Ensure B is a binary image
B = logical(B);

% Feature 1: Area (number of pixels in the region)
area = sum(B(:));

% Feature 2: Perimeter (length of the boundary)
perimeter = sum(sum(bwperim(B)));

% Feature 3: Eccentricity (how elongated the region is)
props = regionprops(B, 'Eccentricity', 'Centroid', 'MajorAxisLength', 'MinorAxisLength', 'Extent');
eccentricity = props.Eccentricity;

% Feature 4: Aspect Ratio (MajorAxisLength / MinorAxisLength)
aspectRatio = props.MajorAxisLength / props.MinorAxisLength;

% Feature 5: Extent (ratio of area to bounding box area)
extent = props.Extent;

% Feature 6: Circularity (4 * pi * Area / Perimeter^2)
% circularity = (4 * pi * area) / (perimeter ^ 2);
signature = hand_signature(B);

% Feature 7: Solidity (area / convex hull area)
bwB = bwboundaries(B);
bwB = bwB{1};
solidity = fitellipse(bwB(:,2), bwB(:,1));

% Feature 8: Hu Moments (7 invariant moments)
huMoments = hu(B, false);

% Combine features into a feature vector
F = [area, perimeter, eccentricity, aspectRatio, extent, signature, solidity, huMoments];

% Optional: Normalize features (if desired)
% F = F / norm(F);

% ---------- INSERT YOUR CODE ABOVE ------------------------------------

return

% END OF FILE
