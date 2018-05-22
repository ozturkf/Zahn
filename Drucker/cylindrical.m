clear; clc; close all;
dens =[ 30 50 100 100 100 100 100 100 50 30];
passes = 10;
peri = 8*pi();
target0 = [ -45 -5 20 90 0 0];
target = target0;
s=strcat('cylindrical.g');
file = fopen(s,'w');
fprintf(file,'%s\n','G28.2'); % print home
fprintf(file,'G1 X-4 Y-55 Z20 A0 B%6.3f F600 \n', target(5));
fprintf(file,'G1 X4 C0.032 \n');
fprintf(file,'G1 X-4 C0.000 \n');
fprintf(file,'G1 X%6.3f Y%6.3f Z%6.3f A%6.3f B%6.3f C%6.3f F200 \n',target(1,1), target(1,2), target(1,3), target(1,4), target(1,5), target(1,6));

for p=1:passes
    for i=1:size(dens,2)  
        if mod (p,2)
            target(1,2)= target(1,2)+ (10/size(dens,2));
            target(1,5)= target(1,5)+360;
            target(6)=target(6)+ (peri*dens(i))/(1000*passes);
            fprintf(file,'G1 X%6.3f Y%6.3f Z%6.3f A%6.3f B%6.3f C%6.3f \n',target(1,1), target(1,2), target(1,3), target(1,4), target(1,5), target(1,6));
        else
            target(1,2)= target(1,2)- (10/size(dens,2));
            target(1,5)= target(1,5)-360;
            target(6)=target(6)- (peri*dens(i))/(1000*passes);
            fprintf(file,'G1 X%6.3f Y%6.3f Z%6.3f A%6.3f B%6.3f C%6.3f \n',target(1,1), target(1,2), target(1,3), target(1,4), target(1,5), target(1,6));
        end
    end   
end
fprintf(file,'G1 Y95 Z30 A0.000 F600');
fclose(file);