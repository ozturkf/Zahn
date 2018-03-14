clear;clc;close all;

rawImage=imread('ImagePh.jpg');
histeq=histeq(rawImage);
gs=rgb2gray(histeq);
setx=[95 70 65 45 75 50 15 1];
sety=[250 613 1005 1413 1793 2165 2573 3017];
sizex=340;
sizey=70;
sizeImage=size(rawImage);
xScale=8.2/sizeImage(2);
xAx=[0:xScale:sizex*xScale];
im1 = insertShape(rawImage,'Rectangle',[setx(1) sety(1) sizex sizey],'LineWidth',7,'color','red');
im2 = insertShape(im1,'Rectangle',[setx(2) sety(2) sizex sizey],'LineWidth',7,'color','red');
im3 = insertShape(im2,'Rectangle',[setx(3) sety(3) sizex sizey],'LineWidth',7,'color','red');
im4 = insertShape(im3,'Rectangle',[setx(4) sety(4) sizex sizey],'LineWidth',7,'color','red');
im5 = insertShape(im4,'Rectangle',[setx(5) sety(5) sizex sizey],'LineWidth',7,'color','red');
im6 = insertShape(im5,'Rectangle',[setx(6) sety(6) sizex sizey],'LineWidth',7,'color','red');
im7 = insertShape(im6,'Rectangle',[setx(7) sety(7) sizex sizey],'LineWidth',7,'color','red');
im8 = insertShape(im7,'Rectangle',[setx(8) sety(8) sizex sizey],'LineWidth',7,'color','red');

% frame1=im1(sety(1)-1:(sety(1)+sizey+1),setx(1)-1:(setx(1)+sizex+1));
% frame2=im1(sety(2)-1:(sety(2)+sizey+1),setx(2)-1:(setx(2)+sizex+1));
% frame3=im1(sety(3)-1:(sety(3)+sizey+1),setx(3)-1:(setx(3)+sizex+1));
% frame4=im1(sety(4)-1:(sety(4)+sizey+1),setx(4)-1:(setx(4)+sizex+1));
% frame5=im1(sety(5)-1:(sety(5)+sizey+1),setx(5)-1:(setx(5)+sizex+1));
% frame6=im1(sety(6)-1:(sety(6)+sizey+1),setx(6)-1:(setx(6)+sizex+1));
% frame7=im1(sety(7)-1:(sety(7)+sizey+1),setx(7)-1:(setx(7)+sizex+1));
% frame8=im1(sety(8)-1:(sety(8)+sizey+1),setx(8)-1:(setx(8)+sizex+1));

Sect1 = gs(sety(1):(sety(1)+sizey),setx(1):(setx(1)+sizex));
Sect2 = gs(sety(2):(sety(2)+sizey),setx(2):(setx(2)+sizex));
Sect3 = gs(sety(3):(sety(3)+sizey),setx(3):(setx(3)+sizex));
Sect4 = gs(sety(4):(sety(4)+sizey),setx(4):(setx(4)+sizex));
Sect5 = gs(sety(5):(sety(5)+sizey),setx(5):(setx(5)+sizex));
Sect6 = gs(sety(6):(sety(6)+sizey),setx(6):(setx(6)+sizex));
Sect7 = gs(sety(7):(sety(7)+sizey),setx(7):(setx(7)+sizex));
Sect8 = gs(sety(8):(sety(8)+sizey),setx(8):(setx(8)+sizex));

adj1=imadjust(Sect1);
adj2=imadjust(Sect2);
adj3=imadjust(Sect3);
adj4=imadjust(Sect4);
adj5=imadjust(Sect5);
adj6=imadjust(Sect6);
adj7=imadjust(Sect7);
adj8=imadjust(Sect8);
% adj1=Sect1;
% adj2=Sect2;
% adj3=Sect3;
% adj4=Sect4;
% adj5=Sect5;
% adj6=Sect6;
% adj7=Sect7;
% adj8=Sect8;

sum1= -1.*sum(adj1);
sum2= -1.*sum(adj2);
sum3= -1.*sum(adj3);
sum4= -1.*sum(adj4);
sum5= -1.*sum(adj5);
sum6= -1.*sum(adj6);
sum7= -1.*sum(adj7);
sum8= -1.*sum(adj8);

sum1= sum1-min(sum1)-1500;
sum2= sum2-min(sum2)-1500;
sum3= sum3-min(sum3);
sum4= sum4-min(sum4);
sum5= sum5-min(sum5)-2500;
sum6= sum6-min(sum6)-2300;
sum7= sum7-min(sum7)-1500;
sum8= sum8-min(sum8)-1500;

sum1(sum1<0 ) = 0;
sum2(sum2<0 ) = 0;
sum3(sum3<0 ) = 0;
sum4(sum4<0 ) = 0;
sum5(sum5<0 ) = 0;
sum6(sum6<0 ) = 0;
sum7(sum7<0 ) = 0;
sum8(sum8<0 ) = 0;

sumsmax1=max([max(sum1) max(sum2) max(sum3) max(sum4)]);
sumsmax2=max([max(sum5) max(sum6) max(sum7) max(sum8)]);

sum1= sum1/sumsmax1;
sum2= sum2/sumsmax1;
sum3= sum3/sumsmax1;
sum4= sum4/sumsmax1;
sum5= sum5/sumsmax2;
sum6= sum6/sumsmax2;
sum7= sum7/sumsmax2;
sum8= sum8/sumsmax2;

figure(1);
subplot(2,1,1);plot(xAx,sum1); hold on;
subplot(2,1,1);plot(xAx,sum2); hold on;
subplot(2,1,1);plot(xAx,sum3); hold on;
subplot(2,1,1);plot(xAx,sum4); hold on;
axis([0 sizex*xScale 0 1]);
ax = gca;
ax.FontSize=20;
title '800 nL Total Volume','FontSize',40;
grid minor;
legend '100 nL Drops' '50 nL Drops' '25 nL Drops' '12.5 nL Drops' ;
xlabel ('Distance (mm)');
ylabel ('Ink intensity');
subplot(2,1,2);plot(xAx,sum5); hold on;
subplot(2,1,2);plot(xAx,sum6); hold on;
subplot(2,1,2);plot(xAx,sum7); hold on;
subplot(2,1,2);plot(xAx,sum8);% hold on;
axis([0 sizex*xScale 0 1]);
ax = gca;
ax.FontSize=20; 
title '400 nL Total Volume','FontSize',40;
xlabel ('Distance (mm)');
ylabel ('Ink intensity');
legend '100 nL Drops' '50 nL Drops' '25 nL Drops' '12.5 nL Drops' ;

% figure (5);
% subplot(8,2,2);imshow(Sect1);
% subplot(8,2,4);imshow(Sect2);
% subplot(8,2,6);imshow(Sect3);
% subplot(8,2,8);imshow(Sect4);
% subplot(8,2,10);imshow(Sect5);
% subplot(8,2,12);imshow(Sect6);
% subplot(8,2,14);imshow(Sect7);
% subplot(8,2,16);imshow(Sect8);
% 
% subplot(8,2,[1,3,5,7,9,11,13,15]);
% imshow(im8);legend off;

grid minor