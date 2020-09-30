%%
%This code is used to receive data from 8 strain gauges connected to one
%Arduino board and generate a txt file that contains thes data. This code 
%takes data from the serial port the arduino uses, and write them into a 
%txt file.Each line in the text file represents a reading from the 2 
%strain gauges each band, and data from each strain gauge is separated by a comma. 

%%
try                     %this is used to close the remaining portal and files
    fclose(s);          
    %fclose(fileID);
end
%%
clear all;
clc;  % clear all variables
%%

s = serial('COM4');  %port
set(s,'BaudRate',9600);  %
fopen(s);  
%fileID = fopen('test_10.txt','w');
 
strain_gauge_lecture = 200; %read 100 numbers from arduino. can be adjusted. 
                            %DUM: 100 times SG will be read
                            %since we have 2 Strain Gauges, this needs to
                            %be a multiple of the Strain Gauge number
                            
strain_gauges = 2;          %we have 2 strain gauges at the same time
total_batches = strain_gauge_lecture/strain_gauges;% data rows
passo = 1;
batch = 1;
% Number and slicing
Number = [1:total_batches]';


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
        if b
            data_2(data_rows,sg) = b;
        end
    end
end
data_2 = circshift(data_2',5)';
writematrix(data_2,'test0925_B4_5.txt'); %we change to this because we have the datamatrix ready

% %Create table:
% T_number = array2table(Number);
% T_number.Properties.VariableNames = {'Number'};
% T_signal = array2table(data_2);
% T_signal.Properties.VariableNames(1:8) = {'A1','A2','A3','A4','A5','A6','A7','A8'};
% %Append the time number array to the signal data
% T = [T_number,T_signal];
% %Summrize the table:(show the data characterization)
% %slice into (5) parts:
% n=5;
% Ave_num = total_batches/n;
% num = T_number{1:Ave_num:end,1};
% % Create sub tables:
% %we could use foor loop but not necessary:
% stage_1 = T{num(1,1):num(2,1),2:9};
% stage_2 = T{num(2,1):num(3,1),2:9};
% stage_3 = T{num(3,1):num(4,1),2:9};
% stage_4 = T{num(4,1):num(5,1),2:9};
% stage_5 = T{num(5,1):end,2:9};
% % substract the mean:
% offset = mean(stage_1);
% mean = [mean(stage_1);mean(stage_2);mean(stage_3);mean(stage_4);mean(stage_5)];
% 
% mean_offset = [mean-offset;
% %mean_offset = [mean(stage_1)-offset;mean(stage_2)-offset;mean(stage_3)-offset;mean(stage_4)-offset;mean(stage_5)-offset];
% 
% % create x axe:
% enlongation = [0;1;2;3;4];
% plot(enlongation,mean);
% plot(enlongation,mean_offset);
% 
% 
% 
% 
% summary(T);
% %take the 
% % fill the missing part:
% %TF = fillmissing(T,'previous');
% 
% 
% % Import .txt version data into matlab table
% % Table = readtable('test0917_5.txt','Format','auto'['A1','A2','A3','A4','A5','A6','A7','A8'])
% 
% 
% %fclose(s);
% %fclose(fileID);
% 
% %figure()
%  
% % plot(data_2(:,1));
% % hold on 
% % plot(data_2(:,2));
% % hold on
% % plot(data_2(:,3));
% % hold on 
% % plot(data_2(:,4));
% % hold on