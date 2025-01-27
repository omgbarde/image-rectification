%% Calibrate the camera using geometric constraints

% inverse of the rectifying homography
H = inv(Hrect);
syms a b c d real;

% build the matrix for the absolute conic
omega = [a, 0, b; 
         0, 1, c; 
         b, c, d];

% isolate column vectors of Hrect
h1 = H(:, 1);
h2 = H(:, 2);
h3 = H(:, 3);

% impose orthogonlity and same module for columns of H
eq1 = h1' * omega * h2 == 0;
eq2 = h1' * omega * h1 - h2' * omega * h2 == 0;

% impose orthogonality with vanishing point of the normal direction (Z)
eq3 = vz' * omega * h1 == 0;
eq4 = vz' * omega * h2 == 0;

% solve the system
params = solve([eq1, eq2, eq3, eq4], [a, b, c, d]);
omega = double([params.a, 0, params.b; 
                0, 1, params.c; 
                params.b, params.c, params.d]);

fprintf('Absolute conic matrix\nw:\n');
disp(omega);

K = chol(inv(omega)); % does not yield a zero-skew calibration matrix

% build the matrix manually

% uo = -b/a
u0 = - double(params.b)/double(params.a);
% vo = -c
v0 = - double(params.c);
% fy = sqrt(d - a*u0^2 - v0^2)
fy = sqrt(double(params.d) - double(params.a) * power(u0,2) - power(v0,2));
% fx = sqrt(a)*fy
fx = sqrt(double(params.a)) * fy;

Kman = [fx, 0, u0; 
        0, fy, v0; 
        0, 0, 1];

fprintf('Calibration matrix\nK:\n');
disp(K);
fprintf('not zero skew :(\n\n');

fprintf('Calibration matrix manually reconstructed\nKman:\n');
disp(Kman);