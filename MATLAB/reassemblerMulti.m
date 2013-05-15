% Dark frame calibration
darkcal = 'DARK10M.mat'
darkdata = load(darkcal);

% Light frame calibration
lightcal = 'LIGHT10M.mat'
lightdata = load(lightcal);
norms = cellfun(@minus,darkdata.frame, lightdata.frame, 'UniformOutput', false);
% assume data is stored in variable frames, a 1D vector of cell arrays,
% each entry in the vector is a single frame
numFrames = length(frames);
calframes = cell(1,numFrames);
frameSeq = cell(1,numFrames);
for ii=1:numFrames
    calframes{ii} = cellfun(@minus,darkdata.frame, frames{ii}, 'UniformOutput', false);
    frameSeq{ii} = cellfun(@rdivide, calframes{ii}, norms, 'UniformOutput',false);
end

%% compute differences for each frame in the sequence
diffSeq = cell(1,numFrames);
sumSeq = cell(1,numFrames);
for ii=1:numFrames

    diffs = cell(1,24);
    sums = cell(1,24);

    for jj=2:2:48
        diffs{jj/2} = frameSeq{ii}{jj}(:,1:96)-frameSeq{ii}{jj-1}(:,1:96);
        sums{jj/2} = 0.5*(frameSeq{ii}{jj}(:,1:96)+frameSeq{ii}{jj-1}(:,1:96));
    end
    
    diffSeq{ii} = diffs;
    sumSeq{ii} = sums;
end
% meanframe = zeros(size(frame{1},1), 96);
% for ii=1:48
%     meanframe = meanframe + frame{ii}(:,1:96);
% end
% figure; imagesc(meanframe(:,4:end)); 
% axis square; colormap gray; 
% set(gca,'XTick', [], 'YTick', []);

%% put together pixel sum image for intensity. account for pixel pair
% position in each tile
% phase pi/2, 0
% low beta, horizontal: 5, 20
% low beta, vertical: 17, 1
% low beta, diagonal +45: 21, 10
% low beta, diagonal -45: 6, 24

% mid beta, diagonal +67.5: 18, 11
% mid beta, diagonal -22.5: 2, 7
% mid beta, diagonal -67.5: 4, 23
% mid beta, diagonal +22.5: 22, 8

% high beta, horizontal: 12, 15
% high beta, vertical: 14, 9
% high beta, diagonal +45: 3, 13
% high beta, diagonal -45: 19, 16
rowsize = 4;
colsize = 6;
rowskip = 5;

order        = [5 20 17 1 21 10 6 24     18 11 2 7 4 23 22 8     12 15 14 9 3 13 16 19];
 
figure;
for ii=0:2
    for jj=0:3
        subplot(4,6,2*ii+6*jj+1);
        imagesc(flipud(diffs{order(8*ii+2*jj+1)}(:,rowskip:end)'));
        axis square; colormap gray;
        set(gca,'XTick', [], 'YTick', []);
        
        subplot(4,6,2*ii+6*jj+2);
        imagesc(flipud(diffs{order(8*ii+2*jj+2)}(:,rowskip:end)'));
        axis square; colormap gray;
        set(gca,'XTick', [], 'YTick', []);

    end
end

% figure;
% for ii=0:2
%     for jj=0:3
%         subplot(4,6,2*ii+6*jj+1);
%         imagesc(sums{order(8*ii+2*jj+1)}(:,4:end));
%         axis square; colormap gray;
%         set(gca,'XTick', [], 'YTick', []);
%         
%         subplot(4,6,2*ii+6*jj+2);
%         imagesc(sums{order(8*ii+2*jj+2)}(:,4:end));
%         axis square; colormap gray;
%         set(gca,'XTick', [], 'YTick', []);
% 
%     end
% end
% imSums = cell(1,24);
% 
% for ii=1:24
%     imSums{ii} = zeros(size(sums{1}).*[colsize rowsize]);
% end
% 
% for ii=1:24
%     imSums{ii}(allColPos(ii):colsize:end,allRowPos(ii):rowsize:end) = sums{order(ii)};
% end
% 
% figure;
% for ii=0:2
%     for jj=0:3
%         subplot(4,6,2*ii+6*jj+1);
%         imagesc(imSums{order(8*ii+2*jj+1)}(:,20:end-20));
%         axis square; colormap gray;
%         set(gca,'XTick', [], 'YTick', []);
%         
%         subplot(4,6,2*ii+6*jj+2);
%         imagesc(imSums{order(8*ii+2*jj+2)}(:,20:end-20));
%         axis square; colormap gray;
%         set(gca,'XTick', [], 'YTick', []);
% 
%     end
% end

%% THIS IS HARDWIRED, DO NOT CHANGE
imSumSeq = cell(1,numFrames);
imSum = zeros(size(sums{1}).*[colsize rowsize]);

sumOrder = ...
        [13     15      17      19      21      23 ...
         1      3       5       7       9       11 ...
         2      4       6       8       10      12 ...
         14     16      18      20      22      24];
     
for kk=1:numFrames

    for ii=0:3
        for jj=0:5
            imSum(ii+1:rowsize:end,jj+1:colsize:end) = sumSeq{kk}{sumOrder(6*ii+jj+1)}';
        end
    end

    figure; imagesc(flipud(imSum(rowskip*rowsize:end,:))); 
    axis square; colormap gray; 
    set(gca,'XTick', [], 'YTick', []);
    imSumSeq{kk} = imSum;
end