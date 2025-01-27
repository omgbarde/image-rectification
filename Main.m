%% Lorenzo Bardelli 10831941
% IACV homework, A.Y. 2024/25
clear;
close all;
addpath('Homework/aux');
addpath('Homework/data');
clc;

% diary('output.txt'); % target .txt file
diary off % enable write to file

%% 0 load features
im = imread("data/Look-outCat.jpg");

% automatically computes lines
FindLines;

% getting best lines
LoadLines;

% load info on C and S
load("annotiations.mat","ellipse","xi","yi");

%% 1 find the horizontal line at infinity
%compute vanishing points and lines
VanishingPts;

%% 2 find rectification homography for the horizontal plane
% find the matrix and compute the depth
RectifyXY;

%% 3 find the calibration matrix
CameraCalibration;

%% 4 find the height h of the parallelepiped
% find the matrix and compute the height
RectifyXZ;

%% 5 find coordinates of points on S
% rectify the S curve
RectifyS;

%% 6 localize the camera
% find the R and T matrices and plot reconstructed scene
Localization;

% reconstruct 3D scene
ReconstructScene;

diary off