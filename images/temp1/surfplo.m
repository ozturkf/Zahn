clear;clc;close all;

preImage=imread('pre_on_v_slow.jpg');
%postImage=imread('on_25g.jpg');
postImage=imread('rep_on_v_slow.jpg');
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
subplot(2,1,1);imshow(preImage); hold on;
title 'Pre-Sintering';
subplot(2,1,2);imshow(postImage); hold on;
title 'Post-Sintering';

% figure(2);
figure('units','normalized','outerposition',[0 0 1 1])
subplot(4,4,(1:2));
preh=surface(preIm'); hold on;view(75, 45);pbaspect([350 2500 150]);
title 'Pre-Sintering';
subplot(4,4,(3:4));
posth=surface(postIm'); hold on;view(75, 45);pbaspect([350 2500 150]);
title 'Post-Sintering';
set(preh,'LineStyle','none')
set(posth,'LineStyle','none')
subplot(4,4,(5:8));
contourf(postIm,'LineStyle','none');grid minor;

% post=FastPeakFind(postIm);
% imagesc(postIm); hold on
% plot(post(1:2:end),post(2:2:end),'r+')
figure
B = imgaussfilt(postIm,0.7);
subplot(2,1,1);
contourf(postIm,'LineStyle','none');grid minor;
subplot(2,1,2);
contourf(B,'LineStyle','none');grid minor;
lines=zeros(8, size(postIm,1));
scaled=zeros(8, size(postIm,1));


sub=    [380 430 480 530 790 840 890 940]; %vsub
% sub=    [76 196 320 438 563 682 805 925]; %dotsub
figure (2);
for i=1:size(sub,2)
    subplot(4,4,(8+i));
    lines(i,:)=postIm(:,sub(i));
    scaled(i,:)= postIm(:,sub(i))-min(postIm(:,sub(i))); %   (max(postIm))-min(postIm(:,sub(i))))
    plot(scaled(i,:));
    axis([0,size(postIm,1) , 0,1]);
    subplot(4,4,(5:8));hold on ;
    % plot([sub(i) 0 sub(i) size(postIm,1)])
    line([sub(i) sub(i)], [0 size(postIm,1)],'color', 'red')
end
