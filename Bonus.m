clc; clear all; close all;
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
InputImage=imread('BONUS/Case5/5.1.bmp');
Im = ChangePerspective(InputImage);
I = imresize(Im, 2);
figure,imshow(I), title("Projected");
grayI1=Im;  %convert to gray scale
output=Im;
mask = grayI1 > 280;    
fixedImage = regionfill(grayI1, mask);
%enhance brightness
brightFinal=fixedImage-180;
bANdW =imbinarize(brightFinal);
pix = size(bANdW);
no_of_pix = pix(1)*pix(2);
no_of_white_pix = sum(sum(bANdW==1));
percent_of_white_pix = no_of_white_pix*100/no_of_pix;
percent_of_white_pix
J = imadjust(brightFinal,[],[],0.5);
 grayI2=J;
if percent_of_white_pix<26
 J = imadjust(brightFinal,[],[],0.5);
 grayI2=J;
 bANdW =imbinarize(grayI2);
 pix = size(bANdW);
 no_of_white_pix = sum(sum(bANdW==1));
 percent_of_white_pix = no_of_white_pix*100/no_of_pix;
 percent_of_white_pix
end
%{
%imbin=imbinarize(grayI);  %convert to black and white
%enhance illumination
%{mask = grayI > 280;    
fixedImage = regionfill(grayI, mask);
%enhance brightness
brightFinal=fixedImage-180;
bANdW =imbinarize(brightFinal);
%calculate the percentage of black and white pixel
pix = size(bANdW);
no_of_pix = pix(1)*pix(2);
no_of_white_pix = sum(sum(bANdW==1));
percent_of_white_pix = no_of_white_pix*100/no_of_pix;
percent_of_white_pix
%}
%if white percent is small then display the grayscale original image
%else display the enhanced one

if percent_of_white_pix<27
    %figure(2),imshow(grayI1),title('same original');
    grayI=grayI1;
else
     J = imadjust(Im,[],[],0.5);
    %figure(2),imshow(grayI2),title('enhanced');
    grayI=J;
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I=grayI;
I = imsharpen(I);
Ibw = ~imbinarize(I,graythresh(I));
%figure(3)  ,imshow(Ibw), title("bw");


medianFilteredI = medfilt2(Ibw, [3 3]);
%figure(4), imshow(medianFilteredI),title('smoothing');

percentageBlack = nnz(~medianFilteredI) / numel(medianFilteredI); %nnz:get white pixels ~nnz:get black numel:total pixel
ConnectedObjects = bwconncomp(medianFilteredI); % get number of connected objects
%percentageBlack

if ConnectedObjects.NumObjects <size(I,1)&&percentageBlack>0.3
    se = strel('square',10);
    Idilate=imdilate(medianFilteredI,se);
 %   figure(3),imshow(bwlabel(Idilate)), title("dilation");
%     se = strel('square', 3);
%     Iero=imerode(Idilate, se);
%     figure(4),imshow(bwlabel(Iero)), title("erution");
    Iarea = bwareaopen(Idilate,7000); % removes all connected components (objects) that have fewer than P pixels 

elseif percentageBlack>0.5

se = strel('square',8);
    Idilate=imdilate(medianFilteredI,se);
   % figure(5),imshow(bwlabel(Idilate)), title("dilation");

se = strel('square',8);
    Iero=imerode(Idilate,se);
  %  figure(6),imshow(bwlabel(Iero)), title("erosion");
    Iarea = bwareaopen(Iero,7000); % removes all connected components (objects) that have fewer than P pixels 
    
else
    se = strel('square', 5);
    Iero=imerode(medianFilteredI, se);
 %   figure(5),imshow(bwlabel(~Iero)), title("erution");
    Iarea = bwareaopen(~Iero,7000); % removes all connected components (objects) that have fewer than P pixels
end
%Iarea = bwareafilt(Iarea,10); % Get biggest box
Ifinal  = bwlabel(Iarea);
%figure(7),imshow(Ifinal), title("ifinal");
stat = regionprops(Iarea,'Boundingbox');
stat;

QrOutput = [];
for cnt = 1 : numel(stat)
    BB = stat(cnt).BoundingBox;
    if BB(1)~=0.5 && BB(2)~=0.5 
        n=7+cnt;
        figure(n), imshow(grayI),title("Final box"); 
        hold on;
        rectangle('position',BB,'edgecolor','r','linewidth',2);
        
        Icropped = imcrop(grayI,stat(cnt).BoundingBox);
        
        numberOfWhitePixels = sum(Icropped(:));
        numberOfBlackPixels = numel(Icropped) - numberOfWhitePixels ;
        ratio =  numberOfBlackPixels/numberOfWhitePixels ;
        ratio
        [L , W]=size(Icropped);
        L\W;
        if ratio<=-0.99 && L\W>2 && L\W<3.5
            Icropped = imresize(Icropped,1.5);
            figure,imshow(Icropped), title("Output");
        end
        
    end   
    %figure (cnt),imshow(I);
end


