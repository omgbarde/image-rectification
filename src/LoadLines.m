%% Load best lines
% Indexes selected manually

idx1 = [5, 3, 17, 16];
idx2 = [3, 1];

% horizontal lines (hl2 will serve as a measure for the lenght)
hl1 = cross([lines2(idx2(1)).point1 1]', [lines2(idx2(1)).point2 1]');
hl2 = cross([lines2(idx2(2)).point1 1]', [lines2(idx2(2)).point2 1]');

% vertical lines (vl1 will serve as a mesure for the height)
vl1 = cross([lines1(idx1(1)).point1 1]', [lines1(idx1(1)).point2 1]');
vl2 = cross([lines1(idx1(2)).point1 1]', [lines1(idx1(2)).point2 1]');

% depth lines (dl1 will serve as a measure for the depth)
dl1 = cross([lines1(idx1(3)).point1 1]', [lines1(idx1(3)).point2 1]');
dl2 = cross([lines1(idx1(4)).point1 1]', [lines1(idx1(4)).point2 1]');