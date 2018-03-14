clear;clc;close all;
%%
rawImage=imread('RawImage.jpg');
histeq=histeq(rawImage);
gs=rgb2gray(rawImage);

%%

im1 = insertShape(histeq,'Rectangle',[145 1548 445 200],'LineWidth',7,'color','red');
im2 = insertShape(im1,'Rectangle',[145 2076 445 200],'LineWidth',7,'color','red');
im3 = insertShape(im2,'Rectangle',[145 2650 445 200],'LineWidth',7,'color','red');
im4 = insertShape(im3,'Rectangle',[145 3160 445 200],'LineWidth',7,'color','red');
im5 = insertShape(im4,'Rectangle',[360 238 100 275],'LineWidth',7,'color','red');
im6 = insertShape(im5,'Rectangle',[360 485 100 275],'LineWidth',7,'color','red');
im7 = insertShape(im6,'Rectangle',[360 794 100 275],'LineWidth',7,'color','red');
im8 = insertShape(im7,'Rectangle',[360 1067 100 275],'LineWidth',7,'color','red');


%%
Sect1=gs(1548:1748,145:590);
Sect2=gs(2076:2276,145:590);
Sect3=gs(2650:2850,145:590);
Sect4=gs(3160:3360,145:590);
Sect5=gs(238:533,360:460);
Sect6=gs(485:775,360:460);
Sect7=gs(794:1089,360:460);
Sect8=gs(1067:1347,360:460);

adj1=imadjust(Sect1);
adj2=imadjust(Sect2);
adj3=imadjust(Sect3);
adj4=imadjust(Sect4);
adj5=imadjust(Sect5);
adj6=imadjust(Sect6);
adj7=imadjust(Sect7);
adj8=imadjust(Sect8);

sum1= -1.*sum(adj1);
sum2= -1.*sum(adj2);
sum3= -1.*sum(adj3);
sum4= -1.*sum(adj4);
sum5= -1.*sum(adj5');
sum6= -1.*sum(adj6');
sum7= -1.*sum(adj7');
sum8= -1.*sum(adj8');
%%
figure(1);
subplot(1,2,1);imshow(rawImage)
subplot(1,2,2);imshow(im8)

figure(2);
subplot(4,1,1); plot(sum1); hold on;
subplot(4,1,2); plot(sum2);
subplot(4,1,3); plot(sum3);
subplot(4,1,4); plot(sum4)

figure(3);
plot(sum5); hold on;
plot(sum6);
plot(sum7);
plot(sum8)
legend('100\mum','50\mum','25\mum','12,5\mum')
grid minor