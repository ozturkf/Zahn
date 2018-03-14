clc;clear;close all;
S= [468 270 160	120	100;400	260	150	226	106;371	260	150	155	97;450	270	165	130	101;390	260	150	120	105];
M= [365	340	265	195	185;395	310	200	190	175;370	360	260	200	160;420	329	265	200	164;410	250	230	200	160];
avs=mean(S)';
avm=mean(M)';
X= [20,30,40,60,80]';

[curvem, goodness, output] = fit(X,avm,'smoothingspline');
plot(curvem,'b'); hold on;
[curves, goodness, output] = fit(X,avs,'smoothingspline');
plot(curves,'r'); hold on;
legend off;

plot(X,S','rh','MarkerSize', 10); hold on;
plot(X,M','bx','MarkerSize', 10);legend Milled Sawn;
ax = gca;
ax.FontSize=30;
grid on;
% legend ('A35 Measurements','FontSize',16, 'A35 Regression','FontSize',16,'A20 Measurements', 'A20 Regression','A10 Measurements', 'A10 Regression','Water Measurements', 'Water Regression');
title('Effect of Temperature on the Absorption Time','FontSize',40);xlabel('Temperature (°Celcius)','FontSize',30);ylabel('Time (mS)','FontSize',30);