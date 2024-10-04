% MEDIAN_FILTER
%
% Usage:
%         med_img = median_filter(img,M,N)
%
% M,N size of MxN median filter to employ. 

function med_img = median_filter(img,M,N)

% ensure img is 0..1 and greyscale
img = im2double(img);
if (size(img,3)==3)
  img=rgb2gray(img);
end

% ----- INSERT YOUR OWN CODE BELOW -----

orig_img = img;

  [rows, cols] = size(img);
  median_row = floor(M/2);
  median_col = floor(N/2);
  
  for row = 1:rows
      for col = 1:cols
          if rem(M, 2) == 0
              upper_median_row = median_row - 1;
          else
              upper_median_row = median_row;
          end
  
          if rem(N, 2) == 0
              upper_median_col =  median_col - 1;
          else
              upper_median_col = median_col;
          end
  
          lower_median_col = median_col;
          lower_median_row = median_row;
  
          if row - upper_median_row < 1
              upper_median_row = 0;
          end
          if col - upper_median_col < 1
              upper_median_col = 0;
          end
          if row + lower_median_row > rows
              lower_median_row = 0;
          end
          if col + lower_median_col > cols
              lower_median_col = 0;
          end
  
          median_subgroup_matrix = orig_img(row - upper_median_row: row + lower_median_row, col - upper_median_col: col + lower_median_col);
  
          sort_subgroup = median_subgroup_matrix(:);
          sort_subgroup = sort(sort_subgroup);
          [sort_subgroup_row, sort_subgroup_col] = size(sort_subgroup);
          mn_area = sort_subgroup_row * sort_subgroup_col;
  
          if rem(mn_area, 2) == 0
              median_value = mn_area / 2;
          else
              median_value = ceil(mn_area / 2);
          end
  
          median_value = sort_subgroup(median_value);
  
          img(row,col) = median_value;
      end
  end

  med_img = img;


% ----- INSERT YOUR OWN CODE ABOVE -----

return
end




