function [ NewIG ] = Segmentation( grayI, cut )

I=grayI;
I = imsharpen(I);
Ibw = ~imbinarize(I,graythresh(I));
%figure(3)  ,imshow(Ibw), title("bw");


medianFilteredI = medfilt2(Ibw, [3 3]);
%figure(4), imshow(medianFilteredI),title('smoothing');

percentageBlack = nnz(~medianFilteredI) / numel(medianFilteredI); %nnz:get white pixels ~nnz:get black numel:total pixel
ConnectedObjects = bwconncomp(medianFilteredI); % get number of connected objects
%percentageBlack

if ConnectedObjects.NumObjects <size(I,1)&& percentageBlack>0.3
    se = strel('square',10);
    Idilate=imdilate(medianFilteredI,se);
    Iarea = bwareaopen(Idilate,7000); % removes all connected components (objects) that have fewer than P pixels 

elseif percentageBlack>0.5
    se = strel('square',8);
    Iclose=imclose(medianFilteredI,se);
    %{

        Idilate=imdilate(medianFilteredI,se);
       % figure(5),imshow(bwlabel(Idilate)), title("dilation");

    se = strel('square',8);
        Iero=imerode(Idilate,se);
      %  figure(6),imshow(bwlabel(Iero)), title("erosion");
      %}
        Iarea = bwareaopen(Iclose,7000); % removes all connected components (objects) that have fewer than P pixels   
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
n = 1;
for cnt = 1 : numel(stat)
    BB = stat(cnt).   ;
    
    if BB(1)~=0.5 && BB(2)~=0.5 
        fig = 8 + cnt;
        if cut == 'Y'
            figure(n), imshow(grayI),title("Final box"); 
            n = n + 1;
        end
        hold on;
        rectangle('position',BB,'edgecolor','r','linewidth',2);
        
        Icropped = imcrop(grayI,stat(cnt).BoundingBox);
        
        numberOfWhitePixels = sum(Icropped(:));
        numberOfBlackPixels = numel(Icropped) - numberOfWhitePixels ;
        ratio =  numberOfBlackPixels/numberOfWhitePixels ;
       % ratio
        [L , W]=size(Icropped);
       % L\W
        if ratio<-0.9915 && L\W>0.7 && L\W<1.3
            NewIG = Icropped;
            if cut == 'Y'
                figure(fig),imshow(NewIG),title("Output");
            end
        end
    end   
    %figure (cnt),imshow(I);
end
end

