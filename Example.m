% =========================================================================
% Mina Khoshdeli
% Date: June 2016
% =========================================================================
I = imread('image.bmp');
[C1 C2] = decompose(I);

figure
subplot(131)
imshow(I)
title( 'Input RGB Image')
subplot(132)
imshow(C1,[])
title('Stain Channel 1')
subplot(133)
imshow(C2,[])
title('Stain Channel 2')
