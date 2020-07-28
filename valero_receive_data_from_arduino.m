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

s = serial('COM5');  
set(s,'BaudRate',9600);  
fopen(s);  
 
strain_gauge_lecture = 800; %read 200 numbers from arduino. can be adjusted. 
                            %DUM: 200 times SG will be read
                            %since we have 8 Strain Gauges, this needs to
                            %be a multiple of the Strain Gauge number
                            
strain_gauges = 8;          %we have 8 strain gauges read at the same time
total_batches = strain_gauge_lecture/strain_gauges;
passo = 1;
batch = 1;

data_2 = zeros (total_batches,strain_gauges);

for data_rows = 1: total_batches
    for sg = 1:strain_gauges
        b = str2num(fgetl(s));
        if b
            data_2(data_rows,sg) = b;
        end
    end
end
data_2 = circshift(data_2',5)';

writematrix(data_2,'test0727_2.txt'); 

figure()


plot(data_2(:,1));
hold on 
plot(data_2(:,2));
hold on
plot(data_2(:,3));
hold on 
plot(data_2(:,4));
hold on
plot(data_2(:,5));
hold on
plot(data_2(:,6));
hold on
plot(data_2(:,7));
hold on
plot(data_2(:,8));
hold on

legend('SG1','SG2','SG3','SG4','SG5','SG6','SG7','SG8')
