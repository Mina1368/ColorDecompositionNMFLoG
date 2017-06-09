% =========================================================================
% Mina Khoshdeli
% Date: June 2016
% =========================================================================
function [C1 C2] = decompose(I)
% this fuction use nomnegative matrix factorization (NMF) to convert RGB image I
% into H and E stain channels
% C1 and C2 are the two stain channels


%% Read the RGB image
I = im2double(I);
s = size(I);

%% Convert the RGB space to optical density
I0 = max(I(:))+1;
OD = -log((I+.001)./I0);
n = find(OD<0);
OD(n) = 0;

%% Apply NMF
for i = 1:3;
    t = OD(:,:,i);
    D(i,:) = t(:);
end
% I = im2double(imread('image24.bmp'));
[w0 ] = NMF_Initial(I);
[B, X] = nnmf(D, 2,'algorithm','als','w0',w0);
%% Show each channel
Blue = (B(:,1)*X(1,:));
Pink = (B(:,2)*X(2,:));

for i  = 1:3
    t = Pink(i,:);
    C1(:,:,i) = reshape(t,s(1),s(2)); 
end

for i  = 1:3
    t = Blue(i,:);
    C2(:,:,i) = reshape(t,s(1),s(2));
end
 
%% Convert OD images to RGB
% figure
% imshow(C1,[])
% figure
% imshow(C2,[])
% 
% imwrite(C1,'ST13_0050_v1_C1_OD_peak.bmp','BMP')
% imwrite(C2,'ST13_0050_v1_C2_OD_peak.bmp','BMP')

% imwrite(C1,'ST13_0050_v1_C1_OD_random.bmp','BMP')
% imwrite(C2,'ST13_0050_v1_C2_OD_random.bmp','BMP')

C1 = rgb2gray(exp(-C1));
C2 = rgb2gray(exp(-C2));
 
C1 = medfilt2( C1,[2 2]);
C2 = medfilt2( C2,[2 2]);

% imwrite(C1,'ST13_0050_v1_C1_peak.bmp','BMP')
% imwrite(C2,'ST13_0050_v1_C2_peak.bmp','BMP')


% imwrite(C1,'ST13_0050_v1_C1_random.bmp','BMP')
% imwrite(C2,'ST13_0050_v1_C2_random.bmp','BMP')
% 
figure
imshow(C1)
figure
imshow(C2)
end
