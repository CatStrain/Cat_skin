%%
%This code is used to receive data from strain gauges connected to one
%Arduino board and generate a txt file that contains thes data. This code 
%takes data from the serial port the arduino uses, and writes them into a 
%txt file. Each line in the txt file represents a reading from the 
%strain gauges, and data from each strain gauge is separated by a comma. 

%%
clear all;
clc;
%%
s_1=serial('COM3','baudrate',9600);
s_1=serial('COM5','baudrate',9600);

%Biped
try
    fopen(s_1);
catch err
    fclose(instrfind);
    error('Make sure you select the correct COM3 Port where the Arduino is connected.');
end
%CoP Plate
s_2=serial('COM5','baudrate',9600);
try
    fopen(s_2);
catch err
    fclose(instrfind);
    error('Make sure you select the correct COM5 Port where the Arduino is connected.');
end

%% old:
% try                     %this is used to close the remaining portal and files
%     fclose(s_1);          
%     fclose(s_2); 
% end
%%%
% clear all;
% clc;  % clear all variables
%%%
% 
% s_1 = serial('COM5');  
% set(s_1,'BaudRate',9600);  
% fopen(s_1);  

%%
sensor_lecture = 25000; 
number_of_sensors = 8;       
total_lines = sensor_lecture/number_of_sensors;


data_biped = zeros (total_lines,number_of_sensors);
flags = zeros (1,total_lines);
flag_distance = 25;
count = 1;
flag_num = 1;
last_flag_num = 9;

%% To generate array of flags:
for flag = 1: total_lines
    if count == flag_distance
        count = 0;
        flags(flag)=1 ;
    end   
    count = count + 1;
end

fprintf ('Biped and CoP Plate data colection started')
for line = 1: total_lines
    for sensor = 1:number_of_sensors
        b = str2num(fgetl(s_1));              %read line from port 1 (Biped)
        if b                                  %if there is a line
            data_biped(line,sensor) = b;
        end
        %                                       NEW
        c = str2num(fgetl(s_2));              %read line from port 2 (Plate)
        if c                                  %if there is a line
            data_biped(line,sensor) = c;
        end
    end
    if flags(line)==1                       % To print visual cue [[Understand this]]: Why does it need to be 1??
        if flag_num == last_flag_num
            flag_num = 0;
        end
        flag_num = flag_num +1   
    end
end

%%
data_biped=data_biped';
data_biped = circshift(data_biped,1);
data_biped=data_biped'
%...DUM
writematrix(data_biped,'test_122220_6_SpringPlant_ProximalAttachment_randomF.txt'); 

figure()

for sensor = 1 : number_of_sensors
    plot(data_biped(:,sensor));
    hold on 
end

legend('Elasctic Band 1','2','3','4')
