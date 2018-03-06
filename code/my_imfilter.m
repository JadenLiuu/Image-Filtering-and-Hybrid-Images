function output = my_imfilter(image, filter)
% This function is intended to behave like the built in function imfilter()
% See 'help imfilter' or 'help conv2'. While terms like "filtering" and
% "convolution" might be used interchangeably, and they are indeed nearly
% the same thing, there is a difference:
% from 'help filter2'
%    2-D correlation is related to 2-D convolution by a 180 degree rotation
%    of the filter matrix.

% Your function should work for color images. Simply filter each color
% channel independently.

% Your function should work for filters of any width and height
% combination, as long as the width and height are odd (e.g. 1, 7, 9). This
% restriction makes it unambigious which pixel in the filter is the center
% pixel.

% Boundary handling can be tricky. The filter can't be centered on pixels
% at the image boundary without parts of the filter being out of bounds. If
% you look at 'help conv2' and 'help imfilter' you see that they have
% several options to deal with boundaries. You should simply recreate the
% default behavior of imfilter -- pad the input image with zeros, and
% return a filtered image which matches the input resolution. A better
% approach is to mirror the image content over the boundaries for padding.

% % Uncomment if you want to simply call imfilter so you can see the desired
% % behavior. When you write your actual solution, you can't use imfilter,
% % filter2, conv2, etc. Simply loop over all the pixels and do the actual
% % computation. It might be slow.
% output = imfilter(image, filter);


%%%%%%%%%%%%%%%%
% Your code here
%%%%%%%%%%%%%%%%
image=im2single(image);
[filter_w, filter_h]=size(filter);
[im_w,im_h,rgb]=size(image);
output=zeros(size(image));
output=im2single(output);
cx=floor(filter_w/2)+1;
cy=floor(filter_h/2)+1;
for i=cx:im_w-filter_w
    for j=cy:im_h-filter_h
        temp=zeros(3,1);
        for x=1:filter_w
            for y=1:filter_h  
                for r=1:rgb
                    temp(r,1)=temp(r,1)+filter(x,y)*image(i+x,j+y,r);
                end
            end
        end
        output(i,j,:)=temp(:,1);
    end
end

for ii=1:cx-1    
    output(ii,:,:)=output(filter_w-ii+1,:,:);
end
for ii=1:cy-1    
    output(:,ii,:)=output(:,filter_h-ii+1,:);
end
for ii=1:filter_w   
    output(im_w-filter_w+ii,:,:)=output(im_w-filter_w-ii+1,:,:);  
end
for ii=1:filter_h
    output(:,im_h-filter_h+ii,:)=output(:,im_h-filter_h-ii+1,:);  
end


