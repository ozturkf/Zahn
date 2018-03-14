clear;clc;close all;

preImage=imread('preImage.jpg');
postImage=imread('postImage.jpg');
preSize=size(preImage);
postSize=size(postImage);
rpreImage=imresize(preImage,(1000/preSize(2)));
rpostImage=imresize(postImage,(1000/postSize(2)));

prehisteq=histeq(rpreImage);
posthisteq=histeq(rpostImage);
pregs=rgb2gray(prehisteq);
postgs=rgb2gray(posthisteq);
preDoub=im2double(pregs);
postDoub=im2double(postgs);
preIm= 1-preDoub;
postIm= 1-postDoub;
figure(1);
subplot(1,2,1);imshow(preImage); hold on;
title 'Pre-Sintering';
subplot(1,2,2);imshow(postImage); hold on;
title 'Post-Sintering';

% figure(2);
figure('units','normalized','outerposition',[0 0 1 1])
subplot(3,2,1);
preh=surface(preIm); hold on;view(75, 45);pbaspect([350 2500 150]);
title 'Pre-Sintering';
subplot(3,2,2);
posth=surface(postIm); hold on;view(75, 45);pbaspect([350 2500 150]);
title 'Post-Sintering';
set(preh,'LineStyle','none')
set(posth,'LineStyle','none')
subplot(3,2,(3:4));
contourf(preIm','LineStyle','none');grid minor;
subplot(3,2,(5:6));
contourf(postIm','LineStyle','none');grid minor;