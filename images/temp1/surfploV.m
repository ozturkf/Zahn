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
set(gca, 'ZTick', zt, 'ZTickLabel', (zt*3.6))
title 'Pre-Sintering';

subplot(2,1,2);
posth=surface(postIm'); hold on;view(75, 45);pbaspect([350 2500 150]);
xt = get(gca, 'XTick');
set(gca, 'XTick', xt, 'XTickLabel', xt*8.2/100)
yt = get(gca, 'YTick');
set(gca, 'YTick', yt, 'YTickLabel', round(yt*ylength/1000,1))
zt = get(gca, 'ZTick');
set(gca, 'ZTick', zt, 'ZTickLabel', (zt*3.6))
title 'Post-Sintering';

set(preh,'LineStyle','none')
set(posth,'LineStyle','none')

figure
subplot(10,2,(1:2));
contourf(flipud(postIm),'LineStyle','none');grid minor;
title 'Post-Sintering Shade Intensity'
xt = get(gca, 'XTick');
set(gca, 'XTick', xt, 'XTickLabel', round(xt*ylength/1000,1))
yt = get(gca, 'YTick');
set(gca, 'YTick', yt, 'YTickLabel', round(yt*8/140,1))
xlabel('Position X (mm)')
ylabel('Position Y (mm)')

lines=zeros(8, size(postIm,1));
scaled=zeros(8, size(postIm,1));
sub=    [round(linspace(330,530,8),0) ; round(linspace(643,998,8),0)]; %vsub

for i=1:size(sub,2)
    subplot(10,2,(3+2*i));
    lines(i,:)=postIm(:,sub(1,i));
    scaled(i,:)= postIm(:,sub(1,i))-min(postIm(:,sub(1,i))); %   (max(postIm))-min(postIm(:,sub(i))))
    plot(scaled(i,:));
    xticks([0:37:148]);
    xt = get(gca, 'XTick');
    set(gca, 'XTick', xt, 'XTickLabel', round(xt*8.2/148,1))
    yt = get(gca, 'YTick');
    set(gca, 'YTick', yt, 'YTickLabel', yt*3.6)
    axis([0,size(postIm,1) , 0,1]);
    xlabel('Position (mm)')
    ylabel('Shade')
    distance1 = 5.0*(sub(1,i)-80)/460;
    tit= strcat("Distance of " ,num2str(round(distance1,2)),' mm');
    title (tit);
    subplot(10,2,(1:2));hold on ;
    % plot([sub(i) 0 sub(i) size(postIm,1)])
    line([sub(1,i) sub(1,i)], [0 size(postIm,1)],'color', 'red')
end

for i=1:size(sub,2)
    subplot(10,2,(4+2*i));
    lines(i,:)=postIm(:,sub(2,i));
    scaled(i,:)= postIm(:,sub(2,i))-min(postIm(:,sub(2,i))); %   (max(postIm))-min(postIm(:,sub(i))))
    plot(scaled(i,:));
    xticks([0:37:148]);
    xt = get(gca, 'XTick');
    set(gca, 'XTick', xt, 'XTickLabel', round(xt*8.2/148,1))
    yt = get(gca, 'YTick');
    set(gca, 'YTick', yt, 'YTickLabel', yt*3.6)
    axis([0,size(postIm,1) , 0,1]);
    xlabel('Position (mm)')
    ylabel('Shade')
    distance2 = 50+(sub(2,i)-550)*(200-50)/(1000-523);
    tit= strcat("Density of " ,num2str(round(distance2,0)),' Drops/mm');
    title (tit);
    subplot(10,2,(1:2));hold on ;
    % plot([sub(i) 0 sub(i) size(postIm,1)])
    line([sub(2,i) sub(2,i)], [0 size(postIm,1)],'color', 'red')
end
%%
figure (3)
subplot(2,2,(1:2));
contourf(flipud(postIm),'LineStyle','none');grid minor; hold on;
title 'Post-Sintering Shade Intensity'
xt = get(gca, 'XTick');
set(gca, 'XTick', xt, 'XTickLabel', round(xt*ylength/1000,1))
yt = get(gca, 'YTick');
set(gca, 'YTick', yt, 'YTickLabel', round(yt*8/140,1))
xlabel('Position (mm)')
ylabel('Shade')

x1fir=320;
x1las=543;
y1fir= 90.0;
y1las= 81.0;

x2fir=785;
x2las=983;
y2fir= 81.0;
y2las= 73.0;

x1=zeros(1,abs(x1las-x1fir+1));
x2=zeros(1,abs(x2las-x2fir+1));

y1=zeros(1,abs(y1las-y1fir+1));
y2=zeros(1,abs(y2las-y2fir+1));

x1(1)=x1fir; x1(end)=x1las;
x2(1)=x2fir; x2(end)=x2las;

y1(1)=y1fir; y1(end)=y1las;
y2(1)=y2fir; y2(end)=y2las;

a1=(y1(end)-y1(1))./(x1(end)-x1(1));
a2=(y2(end)-y2(1))./(x2(end)-x2(1));

for i=1:size(x1,2)
    x1(i+1)=x1(i)+1;
    y1(i+1)=y1(1)+a1.*(x1(i+1)-x1(1));
    z1(i)=postIm(round(y1(i),0),x1(i));
end

for i=1:size(x2,2)
    x2(i+1)=x2(i)+1;
    y2(i+1)=y2(1)+a2.*(x2(i+1)-x2(1));
    z2(i)=postIm(round(y2(i),0),x2(i));
end


plot(x1,y1,'m-')
plot(x2,y2,'r-')

subplot(2,2,3);
plot(smooth(z1,40),'m');
grid minor;set(gca, 'XTick', xt, 'XTickLabel', round(xt*11/200,1))
yt = get(gca, 'YTick');
set(gca, 'YTick', yt, 'YTickLabel', yt*3.6)

xlabel('Position (mm)')
ylabel('Shade')

subplot(2,2,4);
plot(smooth(z2,40),'r');
grid minor;
set(gca, 'XTick', xt, 'XTickLabel', round(xt*11/200,1))
yt = get(gca, 'YTick');
set(gca, 'YTick', yt, 'YTickLabel', yt*3.6)

xlabel('Position (mm)')
ylabel('Shade')
%% calibration v and parallel
figure
xcomp1=511;
begin2=560;
xcomp2=round(begin2+((1000-begin2)*100/(200-50)));
subplot(2,1,1);contourf(flipud(postIm),'LineStyle','none');grid minor; hold on;
line([xcomp1 xcomp1], [0 size(postIm,1)],'color', 'magenta');hold on;
line([xcomp2 xcomp2], [0 size(postIm,1)],'color', 'red')
xt = get(gca, 'XTick');
set(gca, 'XTick', xt, 'XTickLabel', round(xt*ylength/1000,1))
yt = get(gca, 'YTick');
set(gca, 'YTick', yt, 'YTickLabel', round(yt*8/140,1))
xlabel('Position X (mm)')
ylabel('Position Y (mm)')

subplot(2,1,2);
l1=postIm(:,xcomp1);
l2=postIm(:,xcomp2);
cr1=l1(16:123);
cr2=l2(21:128);

scaled1= smooth((cr1-min(cr1)),15);
scaled2= smooth((cr2-min(cr2)),15);
rat=max(scaled1)/max(scaled2);
scaled2=scaled2*rat;
scaled1=scaled1/1.6;
plot(scaled1,'magenta');hold on;
plot(scaled2,'red');
set(gca, 'XTick', xt, 'XTickLabel', round(xt*8.2/120,1))
yt = get(gca, 'YTick');
set(gca, 'YTick', yt, 'YTickLabel', yt*3.5/0.3)

xlabel('Position (mm)')
ylabel('Shade')
legend 'Profile Magenta' 'Profile Red'
