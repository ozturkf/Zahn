clear;clc;close all;

preImage=imread('pre_on_v_slow.jpg');
postImage=imread('rep_on_v_slow.jpg');
preSize=size(preImage);
postSize=size(postImage);
rpreImage=imresize(preImage,(1000/preSize(2)));
rpostImage=imresize(postImage,(1000/postSize(2)));
axx= linspace(1, 8.2 , postSize(1));
ylength=8.2*postSize(2)/postSize(1);
axy= linspace(1, ylength , postSize(2));
prehisteq=histeq(rpreImage);
posthisteq=histeq(rpostImage);
pregs=rgb2gray(prehisteq);
postgs=rgb2gray(posthisteq);
preDoub=im2double(pregs);
postDoub=im2double(postgs);
preIm= 1-preDoub;
postIm= 1-postDoub;

figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,1,1);
preh=surface(preIm'); hold on;view(75, 45);pbaspect([350 2500 150]);
xt = get(gca, 'XTick');
set(gca, 'XTick', xt, 'XTickLabel', xt*8.2/200)
yt = get(gca, 'YTick');
set(gca, 'YTick', yt, 'YTickLabel', round(yt*ylength/1000,1))
zt = get(gca, 'ZTick');
set(gca, 'ZTick', zt, 'ZTickLabel', round(zt*4))
title 'Pre-Sintering';

subplot(2,1,2);
posth=surface(postIm'); hold on;view(75, 45);pbaspect([350 2500 150]);
xt = get(gca, 'XTick');
set(gca, 'XTick', xt, 'XTickLabel', xt*8.2/100)
yt = get(gca, 'YTick');
set(gca, 'YTick', yt, 'YTickLabel', round(yt*ylength/1000,1))
zt = get(gca, 'ZTick');
set(gca, 'ZTick', zt, 'ZTickLabel', round(zt*4))
title 'Post-Sintering';

set(preh,'LineStyle','none')
set(posth,'LineStyle','none')

figure
subplot(3,4,(1:4));
contourf(flipud(postIm),'LineStyle','none');grid minor;

xt = get(gca, 'XTick');
set(gca, 'XTick', xt, 'XTickLabel', round(xt*ylength/1000,1))
yt = get(gca, 'YTick');
set(gca, 'YTick', yt, 'YTickLabel', round(yt*8/140,1))
xlabel('Position (mm)')
ylabel('Shade')

lines=zeros(8, size(postIm,1));
scaled=zeros(8, size(postIm,1));
sub=    [380 430 480 530 790 840 890 940]; %vsub
% sub=    [76 196 320 438 563 682 805 925]; %dotsub

for i=1:size(sub,2)
    subplot(3,4,(4+i));
    lines(i,:)=postIm(:,sub(i));
    scaled(i,:)= postIm(:,sub(i))-min(postIm(:,sub(i))); %   (max(postIm))-min(postIm(:,sub(i))))
    plot(scaled(i,:));
    xticks([0:37:148]);
    xt = get(gca, 'XTick');
    set(gca, 'XTick', xt, 'XTickLabel', round(xt*8.2/148,1))
    yt = get(gca, 'YTick');
    set(gca, 'YTick', yt, 'YTickLabel', yt*4)
    axis([0,size(postIm,1) , 0,1]);
    xlabel('Position (mm)')
    ylabel('Shade')
    subplot(3,4,(1:4));hold on ;
    % plot([sub(i) 0 sub(i) size(postIm,1)])
    line([sub(i) sub(i)], [0 size(postIm,1)],'color', 'red')
end
