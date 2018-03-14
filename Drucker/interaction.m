clear;clc; close all;
versatz=-0.6;
nDropCountTotal=0;
nDrops=20;
nLine=7;
nStep=zeros(6,1);
DropSize=10;
file = fopen('interaction.g','w');
x0=-49;
y0= -6;
z0= 10;
a0= 0;
b0= 90;
bOffset=-5;
b=b0+bOffset;
c0=0;
length=3;
numberofLayers=1;
modul=0;
fprintf(file,'%s\n','G28.2'); % print home
for schicht=1:8
for i=1:2
    modul=modul+1;
    target=[x0 y0 z0] + (i-1).*[0 5 0];
    fprintf(file,'G1 X%6.3f Y%6.3f Z%6.3f A%6.3f B%6.3f F400 ; \n', target(1) , target(2) , target(3) , a0 , b);
    for j=1:30
        if mod (modul,2)
            c0=c0+(0.2-((j)*0.15/30))/8;
        else
            c0=c0-((0.2-((j)*0.15/30))/8);
        end
        target(1)=target(1)+1;
        nDropCountTotal=nDropCountTotal+nDrops;
        fprintf(file,'G1 X%6.3f C%6.3f F300\n',target(1),c0);
    end
end

target=[x0+30 y0 z0];
fprintf(file,'G1 X%6.3f Y%6.3f B%6.3f F400\n ' ,target(1),target(2),b);

target=[x0+31 y0 z0];
fprintf(file,'G1 X%6.3f Y%6.3f Z%6.3f A%6.3f B%6.3f F400 ; \n', target(1) , target(2) , target(3) , a0 , b);
target=[x0+61 y0+2.5 z0];
fprintf(file,'G1 X%6.3f Y%6.3f Z%6.3f C%6.3f F300\n',target(1),target(2),target(3),c0+(3/8));
target=[x0+31 y0+5 z0];
fprintf(file,'G1 X%6.3f Y%6.3f Z%6.3f C%6.3f F300\n',target(1),target(2),target(3),c0);
end
fprintf(file,'G1 Y100 A0 B-4 F800');
fclose(file);
