function [grayI]=Preprocessing(InputImage)
grayI1=rgb2gray(InputImage);  
brightFinal=grayI1-180;  
bw =imbinarize(brightFinal);
pix = size(bw);
no_of_pix = pix(1)*pix(2);
no_of_white_pix = sum(sum(bw==1));
percent_of_white_pix = no_of_white_pix*100/no_of_pix;   %percent_of_white_pix

if percent_of_white_pix<26
 J = imadjust(brightFinal,[],[],0.5);    %gamma correction
 grayI2=J;

 bw =imbinarize(grayI2);
 no_of_white_pix = sum(sum(bw==1));
 percent_of_white_pix = no_of_white_pix*100/no_of_pix;    %percent_of_white_pix
 
end

%if white percent is small then display the grayscale original image
%else display the enhanced one

if percent_of_white_pix<27
    %figure(2),imshow(grayI1),title('same original');
    grayI=grayI1;
else
     J = imadjust(InputImage,[],[],0.5);
    %figure(2),imshow(grayI2),title('enhanced');
    grayI=rgb2gray(J);
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%