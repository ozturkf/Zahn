clear;clc;
nDropCountTotal=0;
nDrops=zeros(6,1);
nLine=zeros(6,1);
nStep=zeros(6,1);
SchichtDicke=zeros(6,1);
DropSize=3.7;
file = fopen('exp3.g','w');
x0=-11;
y0=-5;
z0= 0;
a0= [15 30 45 15 30 45 ]; %printing skewness
b0= -90;
bOffset=-3.5;
b=b0+bOffset;
c0=0;
length=10;
numberofLayers=1;
pixels=[ 64 64 ;64 32; 32 32 ;32 16 ;16 16; 16 8];
fprintf(file,'%s\n','G28.2'); % print home
fprintf(file,'G1 X-4 Y-42 Z0 A0 B0 F600 \n');
fprintf(file,'G1 X4 C0.032 \n');
fprintf(file,'G1 X-4 C0 \n');
for k=1:numberofLayers %number of layers
    for i=1:size(pixels,1) %number of squares relevant to the array pixels
        nDrops(i)= pixels(i,1);
        nLine(i)= pixels(i,2);
        nStep(i)= cosd(a0(i)).*length ./nLine(i);
        target=[x0 y0 z0] + (i-1).*[10 0 0];
        fprintf(file,'G1 X%6.3f Y%6.3f Z%6.3f A%6.3f B%6.3f F1200 ;%d-%d \n', target(1) , target(2) , z0 , a0(i) , b,k,i);
        print move to target for initialization
        for j=1:nLine(i)
            if mod (j,2)
                target(1)=target(1)+length;
                c0=c0+nDrops(i)./1000;
                target(3)= target(3)+sind(a0(i)).*length./nLine(i);
            else
                target(1)=target(1)-length;
                c0=c0-nDrops(i)./1000;
                target(3)= target(3)+sind(a0(i)).*length./nLine(i);
            end
            nDropCountTotal=nDropCountTotal+nDrops(i);
            
            fprintf(file,'G1 X%6.3f Y%6.3f Z%6.3f C%6.3f\n',target(1),target(2),target(3),c0);
            print target with C<nDrops(i)>
            target(2)= target(2)+nStep(i);
            fprintf(file,'G1 X%6.3f Y%6.3f\n',target(1),target(2));
            print target
            
        end
        SchichtDicke(i)=DropSize.*nDrops(i).*nLine(i)./(((length./10).^2));
    end
end
fprintf(file,'G1 Y95 A0 B-90 \n');
fclose(file);
SchichtDicke=SchichtDicke*numberofLayers