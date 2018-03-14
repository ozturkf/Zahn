clear;clc; close all;


x0=-52;
y0= -2.5;
z0= 10;
a0= 0;
b0= 90;
bOffset=-4.5;
b=b0+bOffset;
c0=0;

nDrops=[100 50 25 12.5];
distance=8;
length=0.1;

for k=1:4
    if k==1
        file = fopen('dots1.g','w');
        x0=x0+distance;
        fprintf(file,'%s\n','G28.2'); % print home
        fprintf(file,'G1 X-4 Y-42 Z0 A0 B%6.3f F800 \n', b);
        fprintf(file,'G1 X4 C0.032 \n');
        fprintf(file,'G1 X-4 C0 \n');
        c=c0;
    elseif k==2
        file = fopen('dots2.g','w');
        x0=x0+distance;
        fprintf(file,'G1 X-4 Y-42 Z0 A0 B%6.3f F800 \n', b);
        fprintf(file,'G1 X4 C0.032 \n');
        fprintf(file,'G1 X-4 C0 \n');
        c=c0;
    elseif k==3
        file = fopen('dots3.g','w');
        x0=x0+distance;
        fprintf(file,'G1 X-4 Y-42 Z0 A0 B%6.3f F800 \n', b);
        fprintf(file,'G1 X4 C0.032 \n');
        fprintf(file,'G1 X-4 C0 \n');
        c=c0;
    elseif k==4
        file = fopen('dots4.g','w');
        x0=x0+distance;
        fprintf(file,'G1 X-4 Y-42 Z0 A0 B%6.3f F800 \n', b);
        fprintf(file,'G1 X4 C0.032 \n');
        fprintf(file,'G1 X-4 C0 \n');
        c=c0;
    end
    
    repeats=nDrops(k)/12.5;
    target=[x0,y0,z0];
    fprintf(file,'G1 X%6.3f Y%6.3f Z%6.3f A%6.3f B%6.3f F300 \n', target(1) , target(2) , target(3) , a0 , b);
    
    for r=1:repeats %Number of divisions
        for set=1:2
            
            for i=1:12 %number of movements
                
                %print move to target for initialization
                if mod (i,2)
                    target(2)=target(2)+length;
                else
                    target(2)=target(2)-length;
                    
                end
                c=c+(set*nDrops(k)/(repeats*1000*2*3));
                fprintf(file,'G1 X%6.3f Y%6.3f C%6.3f\n',target(1),target(2),c);
                
            end
            if set==1
                target(1)= target(1)+32;
            elseif set==2
                target(1)= target(1)-32;
            end
            fprintf(file,'G1 X%6.3f Y%6.3f\n',target(1),target(2));
        end
    end
    
    if k==4
        fprintf(file,'G1 Y95 B90 F900\n');
    end
    
    fclose(file);
end