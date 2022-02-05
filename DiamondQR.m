clc; clear all; close all;
img=imread('BONUS/Case5/5.3.bmp');
imb = im2bw(img);
bwa = imclearborder(imb);
bw2 = bwpropfilt(bwa,'EulerNumber',[0,0]);
%figure(1),imshow(bw2);
se = strel('square',3);
Ierode=imerode(bw2,se);
%figure(2),imshow(Ierode);
se = strel('diamond',45);
Idilate=imdilate(Ierode,se);
%figure(3),imshow(Idilate);
se = strel('diamond',20);
Ierode=imerode(Idilate,se);
%figure(4),imshow(Ierode);
stat = regionprops(Ierode,'Boundingbox');
%stat;
QrOutput = [];
 
for cnt = 1 : numel(stat)
    BB = stat(cnt).BoundingBox;
    if BB(1)~=0.5 && BB(2)~=0.5   
        QrOutput = stat(cnt);
    end   
    %figure (cnt),imshow(I);
end

%BB=QrOutput(1).BoundingBox;
%figure(6), imshow(img),title("Final box"); 
%hold on;
%rectangle('position',BB,'edgecolor','r','linewidth',2); 
Icropped = imcrop(img,QrOutput(1).BoundingBox);
figure (7),imshow(Icropped),title("Output");
