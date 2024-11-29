function RT = extract_lines(H,rhos,thetas,N)

% H - hough transforms
% rhos - related rho values
% thetas - related theta values
% N - number of peaks to identify
%
% RT - a N rows by 2 columns array of the peak rho and theta values

RT = zeros(N,2);

% -------------------- put your code in below ---------------------------

% NOTES: the peaks appear as elongated reagions of large values in the
% hough data. Simply identifying local maxima may not be enough as the
% central peak is sometimes slightly reduced if the lines are not exactly
% straight. You will also need to make sure you do not pick multiple
% peaks which are associated with the same line estimate.

% The suggested method of approach is to look for a global maxima over a
% region LARGER than a simple 5x5 neighbourhood. This maxima is then
% treated as the strongest line and the rho,theta value recorded. The
% region around this point is then zeroed, and the process repeated for
% the next brightest line. ie.
%
% for i=1 to N
%    1. find brightest maxima using local neigbourhood estimates (this will 
%        probably require a double for loop etc)
%    2. record the rho,theta value
%    3. blank out the neighbourhood around the identified maxima
%

% Temporary copy of H for modifying during peak detection
temp_H = H;

% Size of the suppression neighborhood (5x5)
suppression_size = 5;
half_suppression = floor(suppression_size / 2);

[num_rhos, num_thetas] = size(H);

for i = 1:N
    % Step 1: Find the global maximum in temp_H
    [max_val, linear_idx] = max(temp_H(:));  % Global max and linear index
    if max_val == 0
        break;  % Exit if no more peaks
    end

    % Step 2: Compute row and column indices manually without ind2sub
    max_rho_idx = mod(linear_idx - 1, num_rhos) + 1;  % Row index
    max_theta_idx = floor((linear_idx - 1) / num_rhos) + 1;  % Column index

    % Step 3: Record the rho and theta values for the peak
    RT(i, 1) = rhos(max_rho_idx);      % Store rho
    RT(i, 2) = thetas(max_theta_idx);  % Store theta

    % Step 4: Suppress the neighborhood around the detected peak
    rho_min = max(max_rho_idx - half_suppression, 1);
    rho_max = min(max_rho_idx + half_suppression, num_rhos);
    theta_min = max(max_theta_idx - half_suppression, 1);
    theta_max = min(max_theta_idx + half_suppression, num_thetas);

    % Zero out the neighborhood in temp_H
    temp_H(rho_min:rho_max, theta_min:theta_max) = 0;
end

% ---------------------put your code in above ---------------------------

figure;

imagesc(thetas,rhos,H); %axis equal tight;
colormap(gray);
title('Hough Transform - Detected Maximas');
xlabel('Theta');
ylabel('Rho');
hold on;
plot(RT(:,2),RT(:,1),'bo');
hold off;
drawnow;

return

% -----------
% END OF FILE
