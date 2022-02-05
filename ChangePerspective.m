function [ img_out ] = ChangePerspective( img )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

matchedPtsTarget = [400,400; 250,400; 250,350; 400,350]; % (x,y), x - var
matchedPtsDistorted = matchedPtsTarget;



[h, w, c] = size(img);
if c == 3
    img = rgb2gray(img);
end

figure, imshow(img);
title('original image');

h = impoly(gca, matchedPtsDistorted);
matchedPtsDistorted = wait(h);

tform = estimateGeometricTransform(matchedPtsDistorted, matchedPtsTarget, 'projective');
img_out = imwarp(img, tform);
%*************
% outputting *
%*************

end

