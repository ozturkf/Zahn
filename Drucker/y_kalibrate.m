clear;clc; close all;
backlash=0;
nDropCountTotal=0;
nDrops=20;
nLine=7;
nStep=zeros(6,1);
DropSize=10;
file = fopen('exp5.g','w');
x0=-15;
y0= 5;
z0= 0;
a0= 0;
b0= 0;
bOffset=-4;
b=b0+bOffset;
c0=0;
length=3;
numberofLayers=1;
modul=1;
fprintf(file,'%s\n','G28.2'); % print home
fprintf(file,'G1 X-4 Y-42 Z10 A0 B0 F600 \n');
fprintf(file,'G1 X4 C0.032 \n');
fprintf(file,'G1 X-4 C0 \n');
fprintf(file,'G1 X-15 Y-10 \n');
for i=1:nLine
    target=[x0 y0 z0] + (i-1).*[0 5 0];
    fprintf(file,'G1 X%6.3f Y%6.3f Z%6.3f A%6.3f B%6.3f F1200 ; \n', target(1) , target(2) , target(3) , a0 , b);
    for j=1:3
        if mod (modul,2)
            c0=c0+nDrops./1000;
        else
            c0=c0-nDrops./1000;
        end
        target(1)=target(1)+length;
        nDropCountTotal=nDropCountTotal+nDrops;
        
        fprintf(file,'G1 X%6.3f Y%6.3f Z%6.3f C%6.3f\n',target(1),target(2),target(3),c0);
        
        target(1)= target(1)+length;
        fprintf(file,'G1 X%6.3f Y%6.3f\n',target(1),target(2));
        modul=modul+1;
    end
end
target=[x0 y0 z0];
b=b0+bOffset+180;
fprintf(file,'G1 X%6.3f Y%6.3f B%6.3f\n ' ,target(1),target(2),b);

for i=1:nLine
    target=[x0 -y0 z0]+[0 -0.6 0] +backlash * [ 0 -2 0] + (i-1).*[ 0 5.2 0];
    fprintf(file,'G1 X%6.3f Y%6.3f Z%6.3f A%6.3f B%6.3f F1200 ; \n', target(1) , target(2) , target(3) , a0 , b);
    for j=1:3
        if mod (modul,2)
            c0=c0+nDrops./1000;
        else
            c0=c0-nDrops./1000;
        end
        target(1)=target(1)-length;
        nDropCountTotal=nDropCountTotal+nDrops;        
        fprintf(file,'G1 X%6.3f Y%6.3f Z%6.3f C%6.3f\n',target(1),target(2),target(3),c0);        
        target(1)= target(1)-length;
        fprintf(file,'G1 X%6.3f Y%6.3f\n',target(1),target(2));
        modul=modul+1;
    end
end
fprintf(file,'G1 Y100 A0 B0');
fclose(file);
