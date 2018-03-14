clear;clc; close all;
vertical=0;
lines=4;
gap=4.04;
z0= 0;
zGap=9.8;
a0= 0;
dropDensity=5;
if vertical
    x0= -4;
    y0= -2.5;
    b0= 180;
else
    x0= -45;
    y0= -1.7;
    b0=90;
end
c=0;
bOffset=-4.5;
b=b0+bOffset;
distance=16;
length=10;
file = fopen('9skewness.g','w');
fprintf(file,'%s\n','G28.2'); % print home
fprintf(file,'G1 X-4 Y-55 Z20 A0 B%6.3f F800 \n', b);
fprintf(file,'G1 X4 C0.032 \n');
fprintf(file,'G1 X-4 C0.000 \n');
target=ones(lines,4);
target=target.*[x0,y0,z0,a0];
target(:,4) = (0:15:45) ;
target0=target;

for r=1:lines %Number of divisions
    fprintf(file,'G1 A%6.3f B%6.3f F200 \n', target(r,4) , b);
    for i=1:2 %number of movements
        %print move to target for initialization
        if mod (i,2)
            target(r,1)= (target0(r,1)+(r-1)*distance);
            target(r,2)= target0(r,2)- sind(target(r,4)).*(zGap)- cosd(target(r,4)).*((gap./2));
            target(r,3)= target0(r,3) - sind(target(r,4)).*(gap/2)+cosd(target(r,4)).*(zGap);
            fprintf(file,'G1 X%6.3f Y%6.3f Z%6.3f \n',target(r,1),target(r,2),target(r,3));
            plty1((2*r-1),1)=target(r,1);
            plty1((2*r-1),2)=target(r,2);
            target(r,1)= (target0(r,1)+((r-1)*distance)+length);
            c=length*dropDensity/1000;
            plty1((2*r),1)=target(r,1);
            plty1((2*r),2)=target(r,2);
            
        else
            target(r,1)= (target0(r,1)+(r-1)*distance+length);
            target(r,2)= target0(r,2)- sind(target(r,4)).*(zGap)+ cosd(target(r,4)).*((gap./2));
            target(r,3)= target0(r,3) + sind(target(r,4)).*(gap/2)+cosd(target(r,4)).*(zGap);
            fprintf(file,'G1 X%6.3f Y%6.3f Z%6.3f \n',target(r,1),target(r,2),target(r,3));
            plty2((2*r),1)=target(r,1);
            plty2((2*r),2)=target(r,2);
            target(r,1)= (target0(r,1)+((r-1)*distance));
            
            plty2((2*r-1),1)=target(r,1);
            plty2((2*r-1),2)=target(r,2);
            c=0;
            
        end
        fprintf(file,'G1 X%6.3f C%6.3f \n',target(r,1),c);
    end
end

fprintf(file,'G1 Y95 A0.000 B%6.3f F900',bOffset+90);
plot(plty1(:,1),plty1(:,2),plty2(:,1),plty2(:,2));hold on;
fclose(file);
target
plty1
plty2
legend('show')