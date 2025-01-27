%% Reconstruct the 3d scene using data extrapolated from image rectification

% the reference point (front lower left corner of the image) is at 0,0.
% use reconstructed lenght and depth to plot the others
p1 = [0,0,0];
p2 = [1, 0, 0];
p3 = [1, h, 0];
p4 = [0, h, 0];

p5 = [0,0,m];
p6 = [1, 0, m];
p7 = [1, h, m];
p8 = [0, h, m];

pts = [p1; p2; p3; p4; p5; p6; p7; p8];
ptCloud = pointCloud(pts,Color='blue');

figure;
hold on
pcshow(ptCloud,MarkerSize=500);
plotCamera('Location', C, 'Orientation', R, 'Size', 0.1);