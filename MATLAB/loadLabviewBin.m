function [ data ] = loadLabviewBin(filename, numDims, varargin)
%LOADLABVIEWBIN Load Labview binary file into matlab
%
%   DATA = LOADLABVIEWBIN(FILENAME, NUMDIMS)
%       Loads the data contained in binary file FILENAME, assuming that it
%       is made up of individual blocks, each with NUMDIMS dimensions.
%       Data will be repeatedly read until the end of the file. Blocks of
%       any number of dimensions are supported. By default, data is assumed
%       to be big-endian, double precision numbers. 
%       Blocks are concatenated along the last dimension. If the file
%       contains N blocks, each of dimension AxBxC, this function will
%       return a matrix of size AxBx(C*N) elements. Setting the DATAMODE
%       parameter provides other data formats.
%
%   DATA = LOADLABVIEWBIN(FILENAME, NUMDIMS, PRECISION)
%       PRECISION can be any precision specifier, such as 'double' or
%       'int8' which represents the data type written by Labview to the
%       binary file. Default precision is 'double'.
%
%   DATA = LOADLABVIEWBIN(FILENAME, NUMDIMS, PRECISION, BINMODE)
%       BINMODE can be 'ieee-be' or 'ieee-le', depending on which mode
%       Labview writes the binary data. Default mode, corresponding to
%       typical Labview operation, is 'ieee-be', or big-endian binary.
%
%   DATA = LOADLABVIEWBIN(FILENAME, NUMDIMS, PRECISION, BINMODE, DATAMODE)
%       DATAMODE can be either 'matrix' or 'cell' depending on desired
%       data format: matrix concatenates the last dimension, while cell
%       returns a 1D cell array, each a single Labview buffer block.
%       Default mode is 'matrix'.

% conversion table for header bytes to array size
sizeMap = repmat([2^32 2^16 2^8 1]', 1, numDims);
% input handling
if nargin == 2
    precision = 'double';
    binMode = 'ieee-be';
    dataMode = 'matrix';
elseif nargin == 3
    precision = varargin{1};
    binMode = 'ieee-be';
    dataMode = 'matrix';
elseif nargin == 4
    precision = varargin{1};
    binMode = varargin{2};
    dataMode = 'matrix';
elseif nargin == 5
    precision = varargin{1};
    binMode = varargin{2};
    dataMode = varargin{3};  
else
    error('too many inputs');
end

fid = fopen(filename, 'r', binMode);
if fid < 0
    error(['file ' filename ' not found']);
end

fsize = dir(filename);
fbytes = fsize.bytes;

% find data chunks
count = 0;
chunkDim = zeros(numDims, 1);
while ftell(fid) ~= fbytes
    % read first 4*dimensions bytes, reshape into 4 byte chunks
    temp = reshape(fread(fid, 4*numDims),4,numDims);
    % use size map to determine actual dimensions
    chunkDim = sum(sizeMap.*temp);
    count = count+1; % build support for variable dimensions later
    % skip data
    fread(fid, prod(chunkDim), precision, 0, binMode);
end

% go back to beginning of the file
fseek(fid, 0, 'bof');

% allocate data matrix depending on mode
% assume all blocks are the same size and concatenate the last dimension
if strcmp(dataMode, 'matrix')
    if numDims==1
        data = NaN(chunkDim*count, 'single');
    else
        data = NaN([chunkDim(1:end-1) chunkDim(end)*count], 'single');
    end
elseif strcmp(dataMode,'cell')
    data = repmat({NaN(chunkDim)},1,count); 
else
    error('incorrect data mode specified: try cell or matrix');
end

% actually read the data
for ii=1:count
    fread(fid, 4*numDims); % skip header
    
    % 
    temp = fread(fid, prod(chunkDim), precision, 0, binMode);
    if numDims == 1
        temp = reshape(temp, 1, chunkDim);
    else
        evalfunc = 'temp = reshape(temp';
        for jj=1:1:numDims
            evalfunc = [evalfunc ',' num2str(chunkDim(numDims-jj+1))];
        end
        if numDims == 2
            eval([evalfunc ')'';'])
        else
            eval([evalfunc ');'])
        end
    end
    
    if strcmp(dataMode, 'matrix')
        startEl = (ii-1)*chunkDim(end)+1;
        endEl = ii*chunkDim(end);
        evalfunc = 'data(';
        for jj=1:numDims-1
            evalfunc = [evalfunc, ':,'];
        end
        eval([evalfunc num2str(startEl) ':' num2str(endEl) ') = temp;']);
    elseif strcmp(dataMode,'cell')
        data{ii} = temp;
    end
end
fclose(fid);

