%%
%This code is used to receive data from strain gauges connected to one
%Arduino board and generate a txt file that contains thes data. This code 
%takes data from the serial port the arduino uses, and writes them into a 
%txt file. Each line in the txt file represents a reading from the 
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
 
wheaston_bridges_lecture = 1000; 
wheaston_bridges = 4;       
total_batches = wheaston_bridges_lecture/wheaston_bridges;


data_2 = zeros (total_batches,wheaston_bridges);

for data_rows = 1: total_batches
    for wb = 1:wheaston_bridges
        b = str2num(fgetl(s));              %read line from file
        if b                                %if there is a line
            data_2(data_rows,wb) = b;
        end
    end
end
%data_2 = circshift(data_2,5)';
data_2
writematrix(data_2,'test0727_2.txt'); 


figure()

for wb = 1 : wheaston_bridges
    plot(data_2(:,wb));
    hold on 
end

legend('SG1','SG2','SG3','SG4')
