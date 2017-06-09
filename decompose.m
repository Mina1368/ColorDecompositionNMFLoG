%==========================================================================
% Mina Khoshdeli
% Data : June 2016
% This fuction decompose an H&E stained histology image into two channels.
% Input : I is the RGB image
% Outputs : C1 and C2 are two color channels
% The basis for nnmf is initialized using w0.
%==========================================================================

function [C1 C2] = decompose(I)
[w0 ] = NMF_Initial(I);
 I = double(I);
s = size(I);

% Convert the RGB space to optical density
I0 = max(I(:))+1;
OD = -log((I+.001)./I0);
n = find(OD<0);
OD(n) = 0;

% Apply NMF
for i = 1:3;
    t = OD(:,:,i);
    D(i,:) = t(:);
end

[B, X] = nnmf(D, 2,'algorithm','mult','w0',w0);
% Show each channel
Blue = (B(:,1)*X(1,:));
Pink = (B(:,2)*X(2,:));

for i  = 1:3
    t = Blue(i,:);
    C1(:,:,i) = reshape(t,s(1),s(2)); 
end

for i  = 1:3
    t = Pink(i,:);
    C2(:,:,i) = reshape(t,s(1),s(2));
end
 
% C1 = (exp(-C1));
% C2 = exp(-C2);
C1 = rgb2gray(exp(-C1));
C2 = rgb2gray(exp(-C2));
 
C1 = medfilt2( C1,[2 2]);
C2 = medfilt2( C2,[2 2]);

% imwrite(C1,'Pink.bmp','BMP')
% imwrite(C2,'Blue.bmp','BMP')
% 
% figure
% imshow(C1)
% figure
% imshow(C2)
end
