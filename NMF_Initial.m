% =========================================================================
% Mina Khoshdeli
% Date: June 2016
% =========================================================================
function [w0 ] = NMF_Initial(I)
I = im2double(I);
% this function gives the basis for NMF color deconvolution
% w0 : is the basis matrix or the stain matrix
% h0 : is the coefficients matrix for each stain
%-----------------------------------------------------

% Ib = I(:,:,1);
Ib = rgb2gray(I);
H = fspecial('log',21,3);
Ib_LoG = imfilter(Ib,H);
%----------------------------------------------------

i = find(-0.01<Ib_LoG<.01);
Ib_LoG(i) = 0;

%----------------------------------------------------

[maxb,imaxb,minb,iminb]=extrema2(Ib_LoG);

%-----------------------------------------------------
imaxb = imaxb(1:round(.2*size(imaxb,1)));
iminb = iminb(1:round(.2*size(iminb,1)));

[xmax,ymax] = ind2sub(size(Ib),imaxb);
[xmin,ymin] = ind2sub(size(Ib),iminb);
%----------------------------------------------------

h01 = zeros(3,1);
for i  = 1:size(xmax,1)
    k = xmax(i);
    j = ymax(i);
    h01 = h01 + squeeze(I(k,j,:));
end
h01 = h01/size(xmax,1);

h02 = zeros(3,1);
for i  = 1:size(xmin,1)
    k = xmin(i);
    j = ymin(i);
    h02 = h02 + squeeze(I(k,j,:));
end
h02 = h02/size(xmin,1);

w0 = [h01,h02];
