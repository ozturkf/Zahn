%--------------------------------------------------------------------------
% RVM_example.m
%--------------------------------------------------------------------------
% This program shows how to connect to the LSPone (laboratory syringe pump)
% using matlab. The different commands can be found in the user manual.
%
% Advanced Microfluidics SA, August 2017
%--------------------------------------------------------------------------

% Configure serial port corresponding to LSPone
rvm = serial('COM5','BaudRate',9600,'Parity','none','Databits',8,'Stopbits',1,'FlowControl','none','Terminator',{'CR','CR'},'Timeout',1000);
%%
fopen(rvm) % Open communicationx
fprintf(rvm,'/1ZR') % Send command to device
pause(8) % Wait between commands. The pump needs some time to execute the command
%%
fprintf(rvm,'/1I1R')
%%
% Read answer from device - useful to check that all is right
% See user manual - errors in case of problem
answer = fscanf(rvm)

% Close communication
fclose(rvm)
delete(rvm)
clear lsp