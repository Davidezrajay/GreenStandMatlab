clear all;

location1 = 'D:\Projects\GreenStand\ImageData\NeedColorSegmentation';
thumbnails = 'D:\Projects\GreenStand\ImageData\Thumbnails';

segmented = 'D:\Projects\GreenStand\ImageData\ColorSegmented';
  
ds = datastore({location1},'Type','image','FileExtensions',{'.jpg','.tif','.png'});
output = [];
[dsRows,dsCols] = size(ds.Files);
wb = waitbar(0);

 
 
for i = 1:dsRows
    try
 
        filePath = ds.Files(i);
        
        data = readimage(ds,i);
        [BW,SC] = createMask1(data);
        
        [filepath,name,ext] = fileparts(filePath{1,1});
        f = fullfile(segmented,strcat(name,'SEG','.tif'));
        imwrite(SC,f);
        
    catch ME
        continue;
    end
    
end
close(wb);






