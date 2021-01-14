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
 
wheaston_bridges_lecture = 25000; 
wheaston_bridges = 4;       
total_batches = wheaston_bridges_lecture/wheaston_bridges;


data_2 = zeros (total_batches,wheaston_bridges);
flags = zeros (1,total_batches);
flag_distance = 25;
count = 1;
flag_num = 1;
last_flag_num = 9;

for flag = 1: total_batches
    if count == flag_distance
        count = 0;
        flags(flag)=1 ;
    end   
    count = count + 1;
end

fprintf ('data colection started')
for data_rows = 1: total_batches
    for wb = 1:wheaston_bridges
        b = str2num(fgetl(s));              %read line from file
        if b                                %if there is a line
            data_2(data_rows,wb) = b;
        end
    end
    if flags(data_rows)==1
        %fprintf('Flag')
        if flag_num == last_flag_num
            flag_num = 0;
        end
        flag_num = flag_num +1
        
    end
end
%data_2 = circshift(data_2,5)';
%data_2
%DUM...
data_2=data_2';
data_2 = circshift(data_2,1);
data_2=data_2'
%...DUM
writematrix(data_2,'test_122420_11_9points_ElasticBands_RandomF.txt'); 

figure()

for wb = 1 : wheaston_bridges
    plot(data_2(:,wb));
    hold on 
end

legend('Elasctic Band 1','2','3','4')
