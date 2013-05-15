load('dotX0');

reassembler;

Q1X = diffs{5}(1:end-rowskip,:);
P1X = diffs{20}(1:end-rowskip,:);
Q1Y = diffs{17}(1:end-rowskip,:);
P1Y = diffs{1}(1:end-rowskip,:);
Q1Dminus = diffs{21}(1:end-rowskip,:);
P1Dminus = diffs{10}(1:end-rowskip,:);
Q1Dplus = diffs{6}(1:end-rowskip,:);
P1Dplus = diffs{24}(1:end-rowskip,:);

% Q1X = diffs{12}(1:end-rowskip,:);
% P1X = diffs{15}(1:end-rowskip,:);
% Q1Y = diffs{14}(1:end-rowskip,:);
% P1Y = diffs{9}(1:end-rowskip,:);
% Q1Dminus = diffs{3}(1:end-rowskip,:);
% P1Dminus = diffs{13}(1:end-rowskip,:);
% Q1Dplus = diffs{16}(1:end-rowskip,:);
% P1Dplus = diffs{19}(1:end-rowskip,:);


load('dotX1');

reassembler;

Q2X = diffs{5}(1:end-rowskip,:);
P2X = diffs{20}(1:end-rowskip,:);
Q2Y = diffs{17}(1:end-rowskip,:);
P2Y = diffs{1}(1:end-rowskip,:);
Q2Dminus = diffs{21}(1:end-rowskip,:);
P2Dminus = diffs{10}(1:end-rowskip,:);
Q2Dplus = diffs{6}(1:end-rowskip,:);
P2Dplus = diffs{24}(1:end-rowskip,:);

% Q2X = diffs{12}(1:end-rowskip,:);
% P2X = diffs{15}(1:end-rowskip,:);
% Q2Y = diffs{14}(1:end-rowskip,:);
% P2Y = diffs{9}(1:end-rowskip,:);
% Q2Dminus = diffs{3}(1:end-rowskip,:);
% P2Dminus = diffs{13}(1:end-rowskip,:);
% Q2Dplus = diffs{16}(1:end-rowskip,:);
% P2Dplus = diffs{19}(1:end-rowskip,:);


% load('dotX2');
% 
% reassembler;
% 
% Q3 = diffs{5};
% P3 = diffs{20};
% 
% 
% load('dotX3');
% 
% reassembler;
% 
% Q4 = diffs{5};
% P4 = diffs{20};

flowDminus = (P1Dminus.*(Q2Dminus-Q1Dminus) - Q1Dminus.*(P2Dminus-P1Dminus));
flowDplus = (P1Dplus.*(Q2Dplus-Q1Dplus) - Q1Dplus.*(P2Dplus-P1Dplus));

figure;quiver(flipud(flowDplus+flowDminus), flipud(-(flowDplus-flowDminus)));
axis square;

flowX = (P1X.*(Q2X-Q1X) - Q1X.*(P2X-P1X));
flowY = (P1Y.*(Q2Y-Q1Y) - Q1Y.*(P2Y-P1Y));
figure;quiver(flipud(flowX), flipud(flowY));
axis square;

figure; quiver(flipud(0.707*(flowDplus+flowDminus) + flowX), flipud(-0.707*(flowDplus-flowDminus)+flowY));
axis square;


relThresh = 0.05;

[dSinX,a] = gradient(P1X);
[dCosX,a] = gradient(Q1X);
R1X = P1X.*dCosX - Q1X.*dSinX;
[dSinX,a] = gradient(P2X);
[dCosX,a] = gradient(Q2X);
R2X = P2X.*dCosX - Q2X.*dSinX;

% norm = dCosX.^2+dSinX.^2;
% rangeX = R1X ./ norm;
% rangeX(norm < relThresh*max(max(norm))) = 0;

[a,dSinY] = gradient(P1Y);
[a,dCosY] = gradient(Q1Y);
R1Y = P1Y.*dCosY - Q1Y.*dSinY;
[a,dSinY] = gradient(P2Y);
[a,dCosY] = gradient(Q2Y);
R2Y = P2Y.*dCosY - Q2Y.*dSinY;

% norm = dCosY.^2+dSinY.^2;
% rangeY = R1Y ./ norm;
% rangeY(norm < relThresh*max(max(norm))) = 0;
% 
% figure;imagesc(rangeX);
% figure;imagesc(rangeY);
% figure;imagesc(rangeX+rangeY);

biggerQMat = zeros(size(Q1Dminus)+[1 1]);
biggerQMat(2:end,1:end-1) = Q1Dminus;
biggerPMat = zeros(size(P1Dminus)+[1 1]);
biggerPMat(2:end,1:end-1) = P1Dminus;
dSinDminus = biggerPMat(1:end-1,2:end)-P1Dminus;
dCosDminus = biggerQMat(1:end-1,2:end)-Q1Dminus;

R1Dminus = P1Dminus.*dCosDminus - Q1Dminus.*dSinDminus;

biggerQMat = zeros(size(Q1Dminus)+[1 1]);
biggerQMat(2:end,1:end-1) = Q2Dminus;
biggerPMat = zeros(size(P1Dminus)+[1 1]);
biggerPMat(2:end,1:end-1) = P2Dminus;
dSinDminus = biggerPMat(1:end-1,2:end)-P2Dminus;
dCosDminus = biggerQMat(1:end-1,2:end)-Q2Dminus;

R2Dminus = P2Dminus.*dCosDminus - Q2Dminus.*dSinDminus;

% norm = dCosDminus.^2+dSinDminus.^2;
% rangeDminus = R1Dminus ./ norm;
% rangeDminus(norm < relThresh*max(max(norm))) = 0;
% figure;imagesc(rangeDminus);
% 
biggerQMat = zeros(size(Q1Dplus)+[1 1]);
biggerQMat(1:end-1,2:end) = Q1Dplus;
biggerPMat = zeros(size(P1Dplus)+[1 1]);
biggerPMat(1:end-1,2:end) = P1Dplus;
dSinDplus = biggerPMat(2:end,1:end-1)-P1Dplus;
dCosDplus = biggerQMat(2:end,1:end-1)-Q1Dplus;

R1Dplus = P1Dplus.*dCosDplus - Q1Dplus.*dSinDplus;

biggerQMat = zeros(size(Q1Dplus)+[1 1]);
biggerQMat(1:end-1,2:end) = Q2Dplus;
biggerPMat = zeros(size(P1Dplus)+[1 1]);
biggerPMat(1:end-1,2:end) = P2Dplus;
dSinDplus = biggerPMat(2:end,1:end-1)-P2Dplus;
dCosDplus = biggerQMat(2:end,1:end-1)-Q2Dplus;

R2Dplus = P2Dplus.*dCosDplus - Q2Dplus.*dSinDplus;

% norm = dCosDplus.^2+dSinDplus.^2;
% rangeDplus = R1Dplus ./ norm;
% rangeDplus(norm < relThresh*max(max(norm))) = 0;
% figure;imagesc(-rangeDplus);

% figure;imagesc(rangeX-rangeY+rangeDminus-rangeDplus);
hSize = 1;
start = ceil(hSize/2);
h = ones(hSize);

range1 = R1X - R1Y + 0.707*R1Dminus - 0.707*R1Dplus;
r1 = range1;
% r1 = conv2(range1,h,'same');
% r1 = r1(start:hSize:end-1, start:hSize:end);
range2 = R2X - R2Y + 0.707*R2Dminus - 0.707*R2Dplus;
r2 = range2;
% r2 = conv2(range2,h,'same');
% r2 = r2(start:hSize:end-1, start:hSize:end);
norm = dCosX.^2+dSinX.^2+dCosY.^2+dSinY.^2+0.5*(dCosDminus.^2+dSinDminus.^2+dCosDplus.^2+dSinDplus.^2);
n2 = norm;
% n2 = conv2(norm,h,'same');
% n2 = n2(start:hSize:end-1, start:hSize:end);
rangeDiff = (r2-r1)./n2;
rangeDiff(n2 < relThresh*max(max(n2))) = 0;
figure;imagesc(rangeDiff);
colormap gray; axis square; set(gca,'XTick', [], 'YTick',[]);
