clc; clear all; close all;
% InputImage=imread('Case1/1.1.bmp');
% InputImage=imread('Case2/2.1.bmp');
% InputImage=imread('Case3/3.1.bmp');
% InputImage=imread('Case3/3.3.bmp');
% InputImage=imread('Case4/4.1.bmp');
% InputImage=imread('Case4/4.4.bmp');
% InputImage=imread('Bonus/Case6/6.1.bmp');
InputImage=imread('Bonus/Case6/6.2.bmp');


figure (1),imshow(InputImage),title("InputImage");

grayImage=Preprocessing(InputImage);
figure (2), imshow(grayImage), title ("preprocessing");

Rotated = Rotation(grayImage);
figure (3),imshow(Rotated),title("Rotated");
Segmentation(Rotated, 'Y');
%Segmentation(grayImage, 'Y');



