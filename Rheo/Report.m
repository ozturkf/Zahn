clc;close;
ar10=(table2array(A10))/100;
ar20=table2array(A20)/100;
ar35=table2array(A35)/100;
arw=table2array(Wasser)*1000;
x=[1:1:100]';
f1 = fit(x(20:100), ar10(20:100), 'poly2');
f2 = fit(x(20:100), ar20(20:100), 'poly2');
f3 = fit(x(20:100), ar35(20:100), 'poly2');
f4 = fit(x(20:100), arw(20:100), 'poly2');
plot(f3,'m',x(20:100),ar35(20:100),'.m');hold on;legend off;
plot(f2,'r',x(20:100),ar20(20:100),'.r');hold on;legend off;
plot(f1,'g',x(20:100),ar10(20:100),'.g');hold on;legend off;
plot(f4,'b',x(20:100),arw(20:100),'.b'); legend off;

legend ('A35 Measurements', 'A35 Regression','A20 Measurements', 'A20 Regression','A10 Measurements', 'A10 Regression','Water Measurements', 'Water Regression');
title('Viscosity Measurements');xlabel('Time (Seconds)');ylabel('Viscosity (mPas)');


grid minor;