%% Localize the camera in world coordinates
% calculating the rotation matrix R and the translation vector t.

invK = inv(Kman);
% invK = inv(K);

% rotation of the reference frame of the horizontal plane
Rpi = invK * H;

% isolate column vectors
r1 = Rpi(:,1);
r2 = Rpi(:,2);
r3 = cross(r1,r2);

opi = Rpi(:,3);

% R = [r1 r2 r3] is not orthogonal:
% use svd to approximate it.

[U,~,V] = svd([r1 r2 r3]);
R = U * V';

% camera position
C = -R'*opi;

% projection Matrix P = K[R t]
Rt = [R, opi];
P = K * Rt;

fprintf('Camera rotation matrix\nR:\n');
disp(R);

fprintf('Camera translation\nt:\n');
disp(opi);

fprintf('Projection matrix:\nP:\n');
disp(P);

fprintf('Camera coordinates:\n');
disp(C);