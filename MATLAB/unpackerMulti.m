clear data rawData index
filename= ['D:\' file '.bin']
logicThresh = 1.7;
zeroThresh=0.01;
startoffset = 6;
endoffset = 1;
frameoffset = 1;

numReads = 16384;
rawData = zeros(numReads,24);

% get raw data in cell format
% data = loadLabviewBin(filename,2,'single','ieee-be','cell');

% string together blocks into single matrix
% data = cell2mat(data);
data = loadLabviewBin(filename,2,'single');
% rearrange data blocks due to 16-pin header connectors. For each block of
% 8 outputs, reverse order: ie swap 8 and 1, 7 and 2, 6 and 3, 5 and 4.
reindex = [8:-1:1 16:-1:9 24:-1:17 27:-1:25];
data(reindex,:) = data;

% turn logic signals into true binary
data(25:27,:) = data(25:27,:)>logicThresh;
% find the end of the read period, remove all junk before
% frame change occurs on falling edge
framePos = find(diff(data(25,:))<0);
numFrames = length(framePos)-1;

frameData = cell(1,numFrames);
for ii=1:numFrames
    rawFrame = data(:,framePos(ii)+frameoffset:framePos(ii+1)+frameoffset);

    disp(['Finished processing frame ' num2str(ii) ' of ' num2str(numFrames)]);
    % find location of individual reading periods on fastest select clock
    index = find(abs(diff(rawFrame(27,:)))>0);
%     startInd = find(abs(diff(rawFrame(25,:)))>0);
%     endInd = find(abs(diff(rawFrame(26,:)))>0);
%     if length(startInd) ~= numReads-1 || length(endInd) ~= numReads-1
%         warning(['data mismatch possible in frame ' num2str(ii)]);
%     end
    
%    startInd = [0 startInd];
%    endInd = [endInd size(rawFrame,2)];
    
    index = [0 index];
    for jj=1:numReads
        vals = mean(rawFrame(1:24, index(jj)+startoffset:index(jj+1)-endoffset),2)';

        frameData{ii}(jj,:) = vals;
    end
end

%% This seems to work based on some edge tests
% 1:8192 is the left half of the image
% 8193:16384 is the right half of the image
% (1:2:8192,:) is one half of the super-tile on the left side (left part of frame{1:24})
% (2:2:8192,:) is the other half of the super-tile on the left side (left part of frame{25:48})
% (8193:2:16384,:) is one half of the super-tile on the right side (right part of frame{1:24})
% (8194:2:16384,:) is the other half of the super-tile on the right side (right part of frame{25:48})

% need to put this together here, for each frame of data in frameData
rawFrame = cell(1,48);
% clunky, but works: make the frame sequence a cell array of cell arrays
frames = cell(1,numFrames);
for ii=1:numFrames
    % % assemble the top half of the super-tile from left and right
    for jj=1:24
        rawFrame{jj} = [reshape(frameData{ii}(8193:2:16384,jj),32,128); reshape(frameData{ii}(1:2:8192,jj),32,128)];
        rawFrame{jj+24} = [reshape(frameData{ii}(8194:2:16384,jj),32,128); reshape(frameData{ii}(2:2:8192,jj),32,128)];
    end
    
    frames{ii} = rawFrame;
end

%% This is a hack, doesn't work
% 
% scrambled = cell(1,48);
% frame = cell(1,48);
% assemble the bottom half of the super-tile from left and right
% this is the left half of the image. (1:64,:) corresponds to the center of
% the superpixel tile, (65:128,:) corresponds to the edges of the tile
% for jj=1:24
%     scrambled{jj} = reshape(rawData(1:8192,jj),128,64);
% end
% this is the right half of the image. 
% for jj=25:48
%     scrambled{jj} = reshape(rawData(8193:16384,jj-24),128,64);
% end

% now reassemble the pieces into the actual image we want
% for jj=1:24
%     frame{jj} = [scrambled{jj+24}(1:64,:); scrambled{jj}(1:64,:)];
%     frame{jj+24} = [scrambled{jj+24}(65:128,:); scrambled{jj}(65:128,:)];
% end

%%
save(file, 'frames');