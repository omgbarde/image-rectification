%% Compute Euclidean transformation for the XY plane
% stratified method with geometric constraints

% start by building the affine reconstruction matrix 
% with the line at infinity of the XY plane
H = [eye(2),zeros(2,1); linf1(:)'];

% affine transform
tform = projective2d(H');
Affine = imwarp(im,tform);

% get algebraic parameters of the ellipse
par_geo = [ellipse.Center, ellipse.SemiAxes, -ellipse.RotationAngle]';
par_alg = conic_param_geo2alg(par_geo);
[a, b, c, d, e, f] = deal(par_alg(1),par_alg(2),par_alg(3),par_alg(4),par_alg(5),par_alg(6));

% build the conic matrix
C1=[a b/2 d/2;
    b/2 c e/2;
    d/2 e/2 f];

C1 = C1./C1(3,3);

% geometric approach to avoid numerical instability: 
% map the ellipse image back to a circle
Q = inv(H)'*C1*inv(H);
Q = Q./Q(3,3);

% ax^2 + bxy + cy^2 + dx + ey + f = 0
par_geo = AtoG([Q(1,1),2*Q(1,2),Q(2,2),2*Q(1,3),2*Q(2,3),Q(3,3)]);
center = par_geo(1:2);
axes = par_geo(3:4);
angle = par_geo(5);

% The affinity is composed by a rotation a scaling and the inverse rotation
alpha = angle;
a = axes(1);
b = axes(2);

% rotation
U = [cos(alpha), -sin(alpha); sin(alpha), cos(alpha)];

% rescaling the axis to be unitary
S = diag([1, a/b]);
K = U*S*U';
A = [K zeros(2,1); zeros(1,2),1];

% compose the transformations
Hrect = A*H;
fprintf('Rectification matrix for the XY plane\nHrect:\n');
disp(Hrect);

% apply the transformation
tform = projective2d(Hrect');
Rect = imwarp(im,tform);
figure;
imshow(Rect);
title('Metric rectification of XY plane.')

% apply transform to lines
% (we use hl2 becaue it's more accurate but still longer)
width_rect = Hrect * hl2;
depth_rect = Hrect * dl1;

% metric transform preserves ratio of lengths
m = norm(depth_rect) / norm(width_rect); % *1

fprintf('computed depth:');
disp(m);