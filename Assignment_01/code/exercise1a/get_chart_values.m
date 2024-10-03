% GET_CHART_VALUES(chart_image) - extract the 6x4 color values from the
% supplied colour chart image.
%
% Usage:
%         RGB_list = get_chart_values(chart_image)
%
% chart_image - NxMx3 array of uint8
% RGB_list - 24x3 element list of rgb values


function RGB_list = get_chart_values(chart_image)

% chart_image is assumed to be an RGB (0..255) image of the color test
% chart. The chart should consist of 4 rows of 6 color patches equally
% spaced. Here you simply need to obtain an RGB value for each patch and
% store it in an Nx3 table

% ---- INSERT YOUR CODE BELOW -----

RGB_list = zeros(24,3);
m = 4; %rows
n = 6; %columns

offLeft = 55; %offset from left border
offTop = 64; %offset from top border
patchWidth = 238;
patchHeight = 232;
gap = 14; %gap between patches

patchCenter = patchWidth/2;
patchMid = patchHeight/2;
color_counter = 1;

for row = 0:m-1
    for col = 0:n-1
        RGB_list(color_counter, 1) = chart_image(offTop + (patchHeight*row) ...
            + (gap * row) + patchMid, offLeft + (patchWidth*col) ...
            + (gap * col) + patchCenter, 1);

        RGB_list(color_counter, 2) = chart_image(offTop + (patchHeight*row) ...
            + (gap * row) + patchMid, offLeft + (patchWidth*col) ...
            + (gap * col) + patchCenter, 2);
        
        RGB_list(color_counter, 3) = chart_image(offTop + (patchHeight*row) ...
            + (gap * row) + patchMid, offLeft + (patchWidth*col) ...
            + (gap * col) + patchCenter, 3);

        color_counter = color_counter + 1;
    end
end

% ---- INSERT YOUR CODE ABOVE -----

return
end






