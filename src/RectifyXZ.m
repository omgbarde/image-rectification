%% Compute Euclidean transformation for the XZ plane
% having calibrated the camera,
% we can use the absolute conic and the vanishing line

% comment next line to use K computed
omega = inv(Kman * Kman');

syms 'x';
syms 'y';

% ax^2 + 2bxy + cy^2 + 2dx + 2ey + f = 0
% equation of the image absolute conic
eq1 = omega(1,1)*x^2 + 2*omega(1,2)*x*y + omega(2,2)*y^2 + 2*omega(1,3)*x + 2*omega(2,3)*y + omega(3,3);

% equation of the image of the line at the infinity of the XZ plane
eq2 = linf2(1)*x + linf2(2) * y + linf2(3);

% solving the system
eqns = [eq1 == 0, eq2 == 0];
sol = solve(eqns, [x,y]);

%solutions (image of circular points)
II = [double(sol.x(1));double(sol.y(1));1];
JJ = [double(sol.x(2));double(sol.y(2));1];

% image of dual conic to circular points
imDCCP = II*JJ.' + JJ*II.';
imDCCP = imDCCP./norm(imDCCP);

%compute the rectifying homography
[U,D,V] = svd(imDCCP);
D(3,3) = 1;
Hr = inv(U * sqrt(D));

fprintf('Rectification matrix for the XZ plane\nHr:\n');
disp(Hr);

% apply the homography to the image
tform = projective2d(Hr');
Rect = imwarp(im,tform);

% for display purposes only
Rect = flip(Rect, 1); % vertical flip
Rect = flip(Rect, 2); % horizontal + vertical flip

figure;
imshow(Rect);
title('Metric rectification of XZ plane.');

%apply transform to lines
width_rect = Hr * hl1;
height_rect = Hr * vl1;

% metric transform preserves ratio of lengths
h = norm(height_rect) / norm(width_rect);

fprintf('computed height:')
disp(h);