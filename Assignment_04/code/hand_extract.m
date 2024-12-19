% HAND_EXTRACT - auto extract the "hand" region of interest from the training
%   image using thresholding, morphological cleaning etc.
%
%  B = hand_extract(I);
%
% I = an NxM gresyscale image (values range 0..1)
% B = Binary mask of extracted region

function B = hand_extract(I)

if (nargin<1)
  error('This function requires an image as input');
end
if (isa(I,'uint8'))
  I = double(I(:,:,1))/255;
end

% estimate a threshold using the isothresh function you have created.
threshold = hand_threshold(I); 

% 1. Threshold the image based on the isothresh estimate. Given that the
%    hand contains significant shadowing uou may need to scale up/down the
%    threshold estimate given by image_thresh(). 
%
% 2. Clean up the thresholded image. Remove isolated points, fill holes
%    in the etc... You can use any of the function in the image processing
%    toolbox to do this such as imerode,imdilate,imopen,imclose,imfill etc.
%    Make sure you test this on serval images from the dataset to be sure it works.
%    Again shadowing across the hand is likely to be an issue.
%
% 3. Return a binary image containing only the "hand", preferably as a single region. 
%    If you have multiple regions in the output (caused by fragmentation of the hand or
%    from noise not removed during the clean up stage) some of the feature estimation 
%    functions which you will use later on may return odd results. 
%
% IMPORTANT - the better this section is at cleaning up the imagery the better the 
% feature estimates are likely to be and hence the performance of the classifier. Also
% make sure you discuss how you came up with these steps in your report and include
% examples etc.
% ----------- FILL IN THE SECTION BELOW ------------------------------

 % Optional: Apply a scaling factor to the threshold if shadows exist
 scale_factor = 0.23; % Adjust this value as needed to handle shadows
 threshold = scale_factor * threshold;

 % Step 2: Threshold the image to create a binary mask
 B = I > threshold; % Binary image after thresholding

 % Step 3: Morphological operations for cleaning up the binary image

 % Fill holes inside the hand region
 B = imfill(B, 'holes');
 
 % Remove small isolated noise using opening
 B = imopen(B, strel('disk', 5)); % You can adjust the disk size

 % Step 4: Keep only the largest connected component (the hand)
% Label connected components in the binary image
[L, num] = bwlabel(B);

% Measure the area of each connected component
stats = regionprops(L, 'Area');
areas = [stats.Area];

% Find the largest connected component
[~, largest_idx] = max(areas);

% Keep only the largest connected component
B = (L == largest_idx);
 
% ----------- FILL IN THE SECTION ABOVE ------------------------------

return

% -------------------------------------------------------------------
% END OF FILE