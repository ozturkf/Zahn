clear;clc;close all;
mode=25;
sub25=[6290 5464 4655 3795 2976 2143 1359 530];
sub50=[6262 5448 4617 3820 2989 2167 1370 556];

inkVolume=[  2800        2400        2000        1600        1200         800         400         200];
limits25=[      125 170 219 215 255 288 362 400;
                645 677 650 642 626 627 649 631];
limits50=[       143 135 136 191 236 284 352 420;
                 593 599 610 586 589 582 563 583];
if mode==25
    sub=sub25;
    limits=limits25;
    postImage=imread('on_25f.jpg');
elseif mode==50
    sub=sub50;
    limits=limits50;
    postImage=imread('on_50f.jpg');
end

postSize=size(postImage);
rpostImage=imresize(postImage,(1000/postSize(2)));
axx= linspace(1, 8.2 , postSize(2));
ylength=8.2*postSize(1)/postSize(2);
axy= linspace(1, ylength , postSize(1));
posthisteq=histeq(rpostImage);
postgs=rgb2gray(posthisteq);
postDoub=im2double(postgs);
postIm= 1-postDoub;

figure
subplot(8,2,[1 3 5 7 9 11 13 15]);
contourf(flipud(postIm),'LineStyle','none');grid minor;

xt = get(gca, 'XTick');
set(gca, 'XTick', xt, 'XTickLabel', round(xt*8.2/1000,1))%*ylength/1000,1
yt = get(gca, 'YTick');
set(gca, 'YTick', yt, 'YTickLabel', round(yt*ylength/6000))%*8/140,1
xlabel('Position X(mm)')
ylabel('Position Y(mm)')

lines=zeros(8, size(postIm,2));
scaled=zeros(8, 900);



fwhm=(limits(2,:)-limits(1,:))*7.4/900

for i=1:size(sub,2)
    subplot(8,2,(2*(9-i)));
    lines(i,:)=postIm(sub(1,i),:);
    sm(i,:)=smooth(lines(i,:),60);
    cropped(i,:)=sm(i,51:950);
    %     rcropped(i,:)=1-((1 - cropped(i,:))/max( 1 - cropped(i,:)));
    scaled(i,:)= cropped(i,:)-min(cropped(i,:)); %   (max(postIm))-min(postIm(:,sub(i))))
    %     plot(cropped(i,:));hold on;
    plot(scaled(i,:));hold on;
    %     plot(rcropped(i,:),'blue');hold on;
    line([limits(1,i), limits(1,i)],[0 1],'color', 'black')
    line([limits(2,i), limits(2,i)],[0 1],'color', 'black')
    9-i
    find(abs(scaled(i,:)-(max(scaled(i,:))/2))<0.003)
    axis([0, 900 , 0,1]);
    xt = get(gca, 'XTick');
    set(gca, 'XTick', xt, 'XTickLabel', round(xt*7.4/1000,1))%for 25 *7.4/900 %for 50 *7.4/1000
    yt = get(gca, 'YTick');
    set(gca, 'YTick', yt, 'YTickLabel', yt*3.5)%for 25 *3.5
    xlab= strcat("Position X(mm)","     FWHM = ", num2str(fwhm(i)));
    xlabel(xlab)
    ylabel('Shade')
    tit= strcat("Total ink volume of " ,num2str(round(inkVolume(i))),' nL');
    title (tit);
    grid minor;
    subplot(8,2,[1 3 5 7 9 11 13 15]);hold on ;
   
    if mode==25
    line([0 size(postIm,2)], [sub(1,i) sub(1,i)],'color', 'red')
elseif mode==50
    line([0 size(postIm,2)], [(size(postIm,1)-sub(1,i)) (size(postIm,1)-sub(1,i))],'color', 'red')
end
    
end
