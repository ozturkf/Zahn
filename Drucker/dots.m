clear;clc; close all;
nDropCountTotal=0;
nDrops=20;
DropSize=10;
x0=-47;
y0= -7;
z0= 10;
a0= 0;
b0= 90;
bOffset=-5;
b=b0+bOffset;
c0=0;
for type=1:4
    if type==1
         filename= 'dots1.g';
    elseif type==2
         filename= 'dots2.g';
    elseif type==3
         filename= 'dots3.g';
    elseif type==4
         filename= 'dots4.g';
    end
    
    file = fopen(filename,'w');
    
    modul=0;
    fprintf(file,'%s\n','G28.2'); % print home
    
    
    for i=1:2
        modul=modul+1;
        target=[x0 y0 z0] + (i-1).*[0 5 0];
        fprintf(file,'G1 X%6.3f Y%6.3f Z%6.3f A%6.3f B%6.3f F1200 ; \n', target(1) , target(2) , target(3) , a0 , b);
        for j=1:30
            if mod (modul,2)
                c0=c0+(0.2-((j)*0.15/30));
            else
                c0=c0-(0.2-((j)*0.15/30));
            end
            target(1)=target(1)+1;
            nDropCountTotal=nDropCountTotal+nDrops;
            fprintf(file,'G1 X%6.3f C%6.3f\n',target(1),c0);
        end
    end
    
    target=[x0+30 y0 z0];
    fprintf(file,'G1 X%6.3f Y%6.3f B%6.3f\n ' ,target(1),target(2),b);
    
    target=[x0+34 y0 z0];
    fprintf(file,'G1 X%6.3f Y%6.3f Z%6.3f A%6.3f B%6.3f F1200 ; \n', target(1) , target(2) , target(3) , a0 , b);
    target=[x0+64 y0+2.5 z0];
    fprintf(file,'G1 X%6.3f Y%6.3f Z%6.3f C%6.3f\n',target(1),target(2),target(3),c0+3);
    target=[x0+34 y0+5 z0];
    fprintf(file,'G1 X%6.3f Y%6.3f Z%6.3f C%6.3f\n',target(1),target(2),target(3),c0);
    
    fprintf(file,'G1 Y100 A0 B-4');
    fclose(file);
    
end