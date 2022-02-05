function [RestoredImage] = Automatic_noise_remove(InputImage)
%stringPath=convertStringsToChars("4.4.bmp");

%I= rgb2gray(InputImage);
%figure (1),imshow(I);
% FT and shifting
I = InputImage;
FT=fft2 (I);
FTshift=fftshift(FT);

disp=log(1+abs(FTshift));
%figure (2),imshow(disp,[]);
% Filtter
[L,W,z1]=size(FTshift);
Filter = ones(size(FTshift));
D = 30;
d=10;
%Filter(L/2-D:L/2+D,W/2-D:W/2+D)=1;


meanIntensity = mean(disp(:));
for r = 1+d:size(disp, 1)-d    % for number of rows of the image
    for c =1+d :size(disp, 2)-d    % for number of columns of the image
       if r<(L/2+D)&& r>(L/2-D) && c<(W/2+D)&& c>(W/2-D)
          Filter(r,c)= 1;
       elseif  disp(r,c)>meanIntensity&& disp(r,c)>disp(r+d,c)&& disp(r,c)>disp(r-d,c)&& disp(r,c)>disp(r,c+d)&& disp(r,c)>disp(r,c-d)&& disp(r,c)>disp(r+d,c+d)&& disp(r,c)>disp(r-d,c-d)
            Filter(r,c)= 0;
%             r=r+d;
       
       end 
    end   
end
se = strel('square',4) ;
Filter = imdilate(Filter,se);
Filter = imerode(Filter,se);
 d2=1;
% for r = 1+d:size(disp, 1)-d    % for number of rows of the image
%     for c =1+d :size(disp, 2)-d    % for number of columns of the image
%        if Filter(r,c)==0 &&(Filter(r,c)==Filter(r+d2,c)|| Filter(r,c)==Filter(r-d2,c)|| Filter(r,c)==Filter(r,c+d2)|| Filter(r,c)==Filter(r,c-d2)|| Filter(r,c)==Filter(r+d2,c+d2)|| Filter(r,c)==Filter(r-d2,c-d2))
%           Filter(r,c)= 0;
%        else
%             Filter(r,c)= 1;
% %             r=r+d;
%        
%        end 
%     end   
% end

%figure (5),imshow(Filter);



percentageBlack = nnz(~Filter) / numel(Filter); %nnz:get white pixels numel:total pixel

if percentageBlack<0.001 &&  percentageBlack>0
    FTshift=FTshift.*Filter;
    % Inverse trans.
    invShift=ifftshift(FTshift);
    invFT=ifft2(invShift);
    %figure (3),imshow(invFT,[]);
    dd=double(I)-invFT;
    %figure (4),imshow(dd,[]);
    RestoredImage=invFT;
end

end