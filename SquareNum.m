function [ SquaresNum ] = SquareNum( Image )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


InputImage = Segmentation(Image, 'N');
BinarizedImg = imbinarize(InputImage);
inverted = ~BinarizedImg;
st = strel('square' , 10);
img = imerode(inverted , st);
[L,SquaresNum] = bwlabel(img);
SquaresNum

end
%3 3.1 3 3.3 2
%1 1.1 3
%2 2.1 0
%4 4.1 5 4.4 19