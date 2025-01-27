%% Draw and save annotations for C and S

close all;
clear
addpath('Homework/aux/');
addpath('Homework/data/');
clc;

im = imread("data/Look-outCat.jpg");

figure;
imshow(im);
hold all;

fprintf('draw ellipse corrisponding to C, then press enter.\n');
ellipse = drawEllipse;
fprintf('draw 12 points on s, then double click.\n');
[xi,yi] = getpts();

save annotiations.mat ellipse xi yi