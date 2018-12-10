function [BW,maskedImage] = segmentImage(RGB)
%segmentImage Segment image using auto-generated code from imageSegmenter app
%  [BW,MASKEDIMAGE] = segmentImage(RGB) segments image RGB using
%  auto-generated code from the imageSegmenter app. The final segmentation
%  is returned in BW, and a masked image is returned in MASKEDIMAGE.

% Auto-generated by imageSegmenter app on 06-Dec-2018
%----------------------------------------------------


% Convert RGB image into L*a*b* color space.
X = rgb2lab(RGB);

% Auto clustering
sz = size(X);
im = single(reshape(X,sz(1)*sz(2),[]));
im = im - mean(im);
im = im ./ std(im);
s = rng;
rng('default');
L = kmeans(im,2,'Replicates',2);
rng(s);
BW = L == 2;
BW = reshape(BW,[sz(1) sz(2)]);

% Open mask with square
width = 4;
se = strel('square', width);
BW = imopen(BW, se);

% Create masked image.
maskedImage = RGB;
maskedImage(repmat(~BW,[1 1 3])) = 0;
end

