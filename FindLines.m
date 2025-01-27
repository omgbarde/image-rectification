%% Find useful lines in the image.
% Applies the Canny edge detection and two rounds of Hough transform,
% tailored to specific angles to extract vertical, diagonal and horizontal lines.
% The best ones have been selected manually with indexes.

% rgb -> greyscale -> Canny edge detection -> Hough lines

% convert image to greyscale
bw = rgb2gray(im);

% apply Canny Edge Detection 
edges = edge(bw, 'Canny'); 

% compute Hough transform for vertical + diagonal 
[H,T,R] = hough(edges,'RhoResolution', 0.5, 'Theta', -45:0.5:45);

% add peaks
P  = houghpeaks(H,20,'threshold',ceil(0.3*max(H(:))));

% get line data
figure;
lines1 = houghlines(edges,T,R,P,'FillGap',40,'MinLength',200);
imshow(im);
hold on
for k = 1:length(lines1)
   xy = [lines1(k).point1; lines1(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red')
end

% compute Hough transform for horizontal 
[H,T,R] = hough(edges,'RhoResolution',2, 'Theta', -90:0.5:-80);

% add peaks
P  = houghpeaks(H,3,'threshold',ceil(0.3*max(H(:))));

% get line data
lines2 = houghlines(edges,T,R,P,'FillGap',500,'MinLength',400);
max_len = 0;
for k = 1:length(lines2)
   xy = [lines2(k).point1; lines2(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
end