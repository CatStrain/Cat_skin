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

clear all;
clc;
%%
s_1=serial('COM6','baudrate',9600);


%Biped
try
    fopen(s_1);
catch error
    fclose(instrfind);
    error('Make sure you select the correct COM6 Port where the Arduino is connected.');
end

sensor_lecture = 25000; 
number_of_sensors = 8;       
lecture_line = sensor_lecture/number_of_sensors;

data_biped = zeros (lecture_line,number_of_sensors);
batch_line_array = zeros (1,lecture_line);
batch_size = 25;
batch_line = 1;
CoP_cue = 1;
biggest_CoP_value = 9;
waith_time=0;
transition_waiting_time = 20;        %To have control over the batch transition time, specially to coordinate two DAQ instances 

for i = 1: lecture_line             %to show flags every 25 lines of data file reading (one barch, 25 lines)
    if batch_line == batch_size
        batch_line = 0;
        batch_line_array(i)=1 ;
    end   
    batch_line = batch_line + 1;
end
%%

fprintf ('data colection started')
record_start_time = clock;
%batch_record_start_time = clock;
for data_line = 1: lecture_line
    for data_column = 1:number_of_sensors
        b = str2double(fgetl(s_1));              %read line from file
        if b                                %if there is a line
            data_biped(data_line,data_column) = b;
        end
    end
    if batch_line_array(data_line)==1                  %there are 25 lines per batch, only enter this when value of a line is 1
        fprintf ('25 data lines recorded...')
        if CoP_cue == biggest_CoP_value
            CoP_cue = 0;                   %
        end
%         while (waith_time < transition_waiting_time)         %This loop won't allow the code to continue until the transition_waiting_time condition is met
%             referece_clock = clock;
%             waith_time = (referece_clock(5)*60 + referece_clock(6)) - (batch_record_start_time(5)*60 + batch_record_start_time(6));
%             %fprintf("waiting for the difference to be bigger than 60...\n") 
%         end
%         batch_record_start_time = clock;
        CoP_cue = CoP_cue +1        
    end
end
fclose(s_1);
record_end_time = clock;

data_biped=data_biped';
data_biped = circshift(data_biped,1);
data_biped=data_biped';

data_biped_with_time = [record_start_time(3:6);data_biped;record_end_time(3:6)];

writematrix(data_biped_with_time,'testing_biped_1_021021.txt'); 

figure()

for data_column = 1 : number_of_sensors
    plot(data_biped(:,data_column));
    hold on 
end

legend('Elasctic Band 1','2','3','4')
