%% Compute vanishing points and lines
% using cross product

vx = cross(hl1, hl2);
vy = cross(dl1, dl2);
vz = cross(vl1, vl2);

%normalize
vx = vx / vx(3);
vy = vy / vy(3);
vz = vz / vz(3);

% calculate lines at infinity
linf1 = cross(vx,vy);
linf1 = linf1/norm(linf1);

linf2 = cross(vx,vz);
linf2 = linf2/norm(linf2);

% display information
text(vx(1), vx(2), 'vx', 'FontSize', 20, 'Color', 'b');
text(vy(1), vy(2), 'vy', 'FontSize', 20, 'Color', 'b');
text(vz(1), vz(2), 'vz', 'FontSize', 20, 'Color', 'b');
plot([vx(1), vy(1)], [vx(2), vy(2)], 'b--');
plot([vx(1), vz(1)], [vx(2), vz(2)], 'b--');