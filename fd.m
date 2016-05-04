function out = fd()
%Implementation of face detection using color segmentation
 

for iter = 1:14
    if iter < 10
        rgbimage = imread(['./originalimages_part1/1-0' num2str(iter) '.jpg']);
    else
        rgbimage = imread(['./originalimages_part1/1-' num2str(iter) '.jpg']);
    end
    
    
  image = rgb2ycbcr(rgbimage);

 dimensions = size(image);
 test = zeros(dimensions(1) , dimensions(2),3);
 

 matrix = zeros( dimensions(1) , dimensions(2));
 for i = 1:dimensions(1)
     for j = 1:dimensions(2)
  %       if image(i,j,1) > 10
             if image(i,j,2) > 85 && image(i,j,2) < 135
                 if image(i,j,3) > 135 && image(i,j,3) < 180
                     matrix(i,j) = 255;
                 end
             end
 %        end
     end
 end
% figure , imshow(matrix);
 matrix = bwfill( matrix , 'holes');
 %figure , imshow(matrix);
 
 matrix = bwareaopen( matrix , 500 );
% figure , imshow(matrix);
 
[segments, num_segments] = bwlabel(matrix);
status = regionprops(segments, 'BoundingBox');


%figure , imshow(rgbimage);


%disp(status);
max = 0;
index = 1;
for i=1:num_segments
    width = status(i).BoundingBox(3);
    height = status(i).BoundingBox(4);
    disp(width);
    disp(height);
    ratio = height/width;
   % if ratio > 3 || ratio < 0.75 || (width < 40 && height < 50) 
    %    continue; 
   % end
    if ratio > max && ratio > 1 && ratio < 3 
      if width > 100 && height > 100
        max = ratio;
        index = i;
      end
    end
    
   % rectangle('position', status(i).BoundingBox, 'edgecolor', 'r');
end

%subplot( 1, 5 , iter);
figure , imshow(rgbimage);



rectangle('position', status(index).BoundingBox, 'edgecolor', 'g');

end



end

