
function myslider
x = 1:10;
hplot = plot(x,0*x);
h = uicontrol('style','slider','units','pixel','position',[20 20 300 20]);
addlistener(h,'ActionEvent',@(hObject, event) makeplot(hObject, event,x,hplot));