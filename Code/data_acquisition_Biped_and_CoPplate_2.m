%%
%This code is used to receive data from strain gauges connected to one or
%more Arduino boards and generate a txt file that contains thes data. This 
%code takes data from the serial port the Arduino uses, and writes them   
%into a txt file. Each line in the txt file represents a reading from the 
%strain gauges, and data from each strain gauge is separated by a comma. 

%%
clear all;
clc;
%% For testing purposes
% file_name='test_0106_constant_2';                  % the data file name
% data = importdata(strcat(file_name,'.txt'));
% file_name='test_0106_constant_2';                  % the data file name
% data_2 = importdata(strcat(file_name,'.txt'));
%% Connecting with Arduinos
s_1 = serial('COM5','baudrate',9600);
s_2 = serial('COM6','baudrate',9600);

%Biped
try
    fopen(s_1);
catch err
    fclose(instrfind);
    error('Make sure you select the correct COM5 Port where the Arduino is connected.');
end

%% Provitional

%  for data_column = 1:1000
%         b = str2double(fgetl(s_1));              %read line from file
%         b
%  end

% %   for i = 1:1000
% %         %% Reading from Arduino 1
% %         b = str2double(fgetl(s_1));              %read line from port 1 (Biped)
% %         b
% %  %       pause(0.5)
% %  end
 %%
%CoP Plate
try
    fopen(s_2);
catch err
    fclose(instrfind);
    error('Make sure you select the correct COM6 Port where the Arduino is connected.');
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

%leg variables
leg_sensor_lecture = 2000;             %25000
number_of_leg_sensors = 2;          %8
lecture_line_biped = leg_sensor_lecture/number_of_leg_sensors;
data_biped = zeros (lecture_line_biped,number_of_leg_sensors);

%CoP plate varaiables
CoP_plate_sensor_lecture = leg_sensor_lecture/2;
number_of_CoP_plate_sensors = 1;    %4  
lecture_line_CoP_plate = lecture_line_biped; %CoP_plate_sensor_lecture/number_of_CoP_plate_sensors;
data_CoP_plate = zeros (lecture_line_CoP_plate,number_of_CoP_plate_sensors);
CoP_plate_line_counter = 1;

batch_line_array = zeros (1,lecture_line_biped);
batch_size = 25;
batch_line = 1;
CoP_cue = 1;
biggest_CoP_value = 9;
read_CoP_plate = 0;

for i = 1: lecture_line_biped
    if batch_line == batch_size
        batch_line = 0;
        batch_line_array(i)=1 ;
    end   
    batch_line = batch_line + 1;
end
%%
fprintf ('data colection started')
read_CoP_plate = 0
for data_line = 1: lecture_line_biped
    for data_column = 1:number_of_leg_sensors
        %% Reading from Arduino 1
        b = str2double(fgetl(s_1));              %read line from port 1 (Biped)
        %b
        if b                                     %if there is a line
            data_biped(data_line,data_column) = b;
            read_CoP_plate = read_CoP_plate+1;
            %a=111
            
        end
        %% Reading from Arduino 2
        if read_CoP_plate == 2
            c = str2double(fgetl(s_2));              %read line from port 2 (Plate)
            c
            a=1111
            if c                                     %if there is a line
                data_CoP_plate(CoP_plate_line_counter,number_of_CoP_plate_sensors) = c;
                CoP_plate_line_counter = CoP_plate_line_counter + 1;     
                %c
                a=222222
            end
            read_CoP_plate = 0;
        end
    end
        %data_column
     %   pause(0.5)
     
    %Only required for training the Plate.
%     if batch_line_array(data_line)==1                  %there are 25 lines per batch, only enter this when value of a line is 1
%         %fprintf('Flag')
%         if CoP_cue == biggest_CoP_value
%             CoP_cue = 0;                   %
%         end
%         CoP_cue = CoP_cue +1
%         
%     end
    %data_line
  %  pause(0.5)
end
%%
%data_2 = circshift(data_2,5)';
%data_2
%DUM...
data_biped=data_biped';
data_biped = circshift(data_biped,1);
data_biped=data_biped'
writematrix(data_biped,'Biped_data_test_1.txt'); 
%...DUM

%DUM...
data_CoP_plate=data_CoP_plate';
data_CoP_plate = circshift(data_CoP_plate,1);
data_CoP_plate=data_CoP_plate'
writematrix(data_CoP_plate,'CoPPlate_data_test_1.txt'); 
%...DUM

figure()

for data_column = 1 : number_of_leg_sensors
    plot(data_biped(:,data_column));
    hold on 
end

legend('Elasctic Band 1','2','3','4')
