%% Rectify points on S
% since S is parallel to the XY plane,
% apply the rectification homography of the XY plane.

numPoints = 12;

P = [xi yi ones(1,numPoints)']';
P_rect = zeros(numPoints,3);

count = 1;

%apply transform to points and normalize
while (count <= numPoints)
    P_rect(count,:) = Hrect * P(:,count);
    P_rect(count,1) = P_rect(count,1)/P_rect(count,3);
    P_rect(count,2) = P_rect(count,2)/P_rect(count,3);
    P_rect(count,3) = P_rect(count,3)/P_rect(count,3);
    count = count + 1;
end

fprintf('rectified coordinates of 12 points on S:\n');
disp(P_rect);

figure
plot(P_rect(:,1),P_rect(:,2),Color='blue');
% in the rectified image the Y axis is downwards
set(gca, 'YDir','reverse');
title('Rectified S curve.');