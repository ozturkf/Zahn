clear;clc; close all;
width=10;
depth=10;
heigth=1;
porosity=0.42;
dropVolume=0.025;
totalDropCount=width*depth*heigth*porosity/dropVolume;
density = (0.1:0.1:1) ;
edgecount=sqrt(totalDropCount*density);
z0= 0;
a0= 0;
x0= -45;
y0= -1.7;
b0=90;
bOffset=-4.5;
b=b0+bOffset;
c=0;
squares=10;
target=ones(squares,4);
target=target.*[x0,y0,z0,c];
target0=target;
target(:,4)=round(edgecount);
distancex =(width*ones(10,1))./target(:,4);

for si=1:10
    s=strcat('homogeneus',int2str(si*10),'.g');
    file = fopen(s,'w');
    fprintf(file,'%s\n','G28.2'); % print home
    fprintf(file,'G1 X-4 Y-55 Z20 A0 B%6.3f F800 \n', b);
    fprintf(file,'G1 X4 C0.032 \n');
    fprintf(file,'G1 X-4 C0.000 \n');
    fprintf(file,'G1 X%6.3f Y%6.3f Z%6.3f F200 \n',target(si,1), target(si,2));
    for i=1:target(si,4) %number of movements
        %print move to target for initialization
        if mod (i,2)
            target(si,1)= (target0(si,1)+(i-1)*distancex(si));
            target(si,2)= target0(si,2);
            fprintf(file,'G1 X%6.3f Y%6.3f Z%6.3f \n',target(si,1),target(si,2),target(si,3));
            target(si,2)= (target0(si,2)+(depth));
            c=target(si,4)/1000;
        else
            target(si,1)= (target0(si,1)+(i-1)*distancex(si));
            target(si,2)= (target0(si,2)+(depth));
            fprintf(file,'G1 X%6.3f Y%6.3f Z%6.3f \n',target(si,1),target(si,2),target(si,3));
            target(si,2)= target0(si,2);
            c=0;
        end
        fprintf(file,'G1 Y%6.3f C%6.3f \n',target(si,2),c);
    end
    fprintf(file,'G1 Y95 A0.000 B%6.3f F900',bOffset+90);
    fclose(file);
end