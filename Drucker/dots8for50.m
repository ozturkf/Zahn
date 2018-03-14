clear;clc; close all;
shotSize=4 ;
x0=-52;
y0= -2.5;
z0= 10;
a0= 0;k
b0= 90;
c=0;
bOffset=-4.5;
b=b0+bOffset;
cNew=zeros([1 8]);
cOld=cNew;
cMax=[4 8 16 24 32 40 48 56];
distance=8;
length=0.1;
repeats=cMax(end)/shotSize;

file = fopen('dots8for50.g','w');
x0=x0+distance;
fprintf(file,'%s\n','G28.2'); % print home
fprintf(file,'G1 X-4 Y-42 Z0 A0 B%6.3f F800 \n', b);
fprintf(file,'G1 X4 C0.032 \n');
fprintf(file,'G1 X-4 C0 \n');
target=[x0,y0,z0];
fprintf(file,'G1 X%6.3f Y%6.3f Z%6.3f A%6.3f B%6.3f F300 \n', target(1) , target(2) , target(3) , a0 , b);

for r=1:repeats %Number of divisions
    for j=1:8
        target(1)= x0+((j-1)*8);
        target(1)
        fprintf(file,'G1 X%6.3f \n',target(1));
        for i=1:2 %number of movements
            %print move to target for initialization
            if mod (i,2)
                target(2)=target(2)+length;
            else
                target(2)=target(2)-length;
            end
            cNew (j) = cNew(j) +(shotSize/(2*1000));
            if cNew(j)>(cMax(j)/1000)
                cNew(j)=(cMax(j)/1000);
            end
            c=c+(cNew(j)-cOld(j));
            cOld=cNew;
            fprintf(file,'G1 Y%6.3f C%6.3f \n',target(2),c);
        end
    end
end


fprintf(file,'G1 Y95 B90 F900');

fclose(file);