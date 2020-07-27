%%
%This code is used to receive data from 8 strain gauges connected to one
%Arduino board and generate a txt file that contains thes data. This code 
%takes data from the serial port the arduino uses, and write them into a 
%txt file.Each line in the text file represents a reading from the 8 
%strain gauges, and data from each strain gauge is separated by a comma. 

%%
try                     %this is used to close the remaining portal and files
    fclose(s);          
    %fclose(fileID);
end
%%
clear all;
clc;  % clear all variables
%%

s = serial('COM5');  %port
set(s,'BaudRate',9600);  %
fopen(s);  
%fileID = fopen('test_10.txt','w');
 
strain_gauge_lecture = 160; %read 200 numbers from arduino. can be adjusted. 
                            %DUM: 200 times SG will be read
                            %since we have 8 Strain Gauges, this needs to
                            %be a multiple of the Strain Gauge number
                            
strain_gauges = 8;          %we have 8 strain gauges at the same time
total_batches = strain_gauge_lecture/strain_gauges;
passo = 1;
batch = 1;

data_2 = zeros (total_batches,strain_gauges);

% while(t < strain_gauge_lecture)
%     b = str2num(fgetl(s)); %takes one line from arduino
%     
for data_rows = 1: total_batches
        %b = str2num(fgetl(s)) %this should be put under the next for loop,
        %or the eight columns would be the same
    for sg = 1:strain_gauges
        b = str2num(fgetl(s));
%             if (mod(i,8)==sg)
%                 fprintf(fileID,'%d ',b);
              %if (b~=0) %we don't need this if function since it doesn't matter if we write 0 to the data matrix             
        data_2(data_rows,sg) = b;
    end
end

writematrix(data_2,'test_10.txt'); %we change to this because we have the datamatrix ready


%fclose(s);
%fclose(fileID);

%figure()
 
% plot(data_2(:,1));
% hold on 
% plot(data_2(:,2));
% hold on
% plot(data_2(:,3));
% hold on 
% plot(data_2(:,4));
% hold on

