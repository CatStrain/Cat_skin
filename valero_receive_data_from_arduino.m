%%
%This code is used to receive data from 8 strain gauges connected to one
%Arduino board and generate a txt file that contains thes data. This code 
%takes data from the serial port the arduino uses, and write them into a 
%txt file.Each line in the text file represents a reading from the 8 
%strain gauges, and data from each strain gauge is separated by a comma. 

%%
try                     %this is used to close the remaining portal and files
    fclose(s);          
    fclose(fileID);
end
%%
%clear all;
clc;  % clear all variables
%%

s = serial('COM5');  %port
set(s,'BaudRate',9600);  %
fopen(s);  
fileID = fopen('test_10.txt','w');
 
strain_gauge_lecture = 160; %read 200 numbers from arduino. can be adjusted. 
                            %DUM: 200 times SG will be read
                            %since we have 8 Strain Gauges, this needs to
                            %be a multiple of the Strain Gauge number
                            
strain_gauges = 8;
total_batches = strain_gauge_lecture/strain_gauges;
passo = 1;

batch = 1;

t = 1;


i=1;
%m=zeros(1,1000); %counter

data_2 = zeros (strain_gauge_lecture/8,8);

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
                %if (b~=0) %we will write b no matter what we have, since that is the reading             
            data_2(data_rows,sg) = b;
                end
%             end
        end
    end
    
    
%     
%     if (mod(i,8)==1)        %DUM ## What is "mod"?
%         fprintf(fileID,'%d ',b);
%         if (b~=0)
%             data(batch,1) = b;
%         end
%     elseif (mod(i,8)==2)
%         fprintf(fileID,'%d ',b);
%         if (b~=0)
%             data(batch,2) = b;
%         end
%     elseif (mod(i,8)==3)
%         fprintf(fileID,'%d ',b);
%         if (b~=0)
%             data(batch,3) = b;
%         end
%     elseif (mod(i,8)==4)
%         fprintf(fileID,'%d ',b);
%         if (b~=0)
%             data(batch,4) = b;
%         end
%     elseif (mod(i,8)==5)
%         fprintf(fileID,'%d ',b);
%         if (b~=0)
%             data(batch,5) = b;
%         end
%     elseif (mod(i,8)==6)
%         fprintf(fileID,'%d ',b); 
%         if (b~=0)
%             data(batch,6) = b;
%         end
%     elseif (mod(i,8)==7)
%         fprintf(fileID,'%d ',b);
%         if (b~=0)
%             data(batch,7) = b;
%         end
%     else
%         fprintf(fileID,'%d\n',b);
%         if (b~=0)
%             data(batch,8) = b;
%             batch = batch + 1;
%         else 
%             batch = batch + 1;
%         end
%     %drawnow;
%     end
%     i=i+1;                
     t = t+passo;
    
% end
fclose(s);
fclose(fileID);

figure()
 
% plot(data(:,1));
% hold on 
% plot(data(:,2));
% hold on
% plot(data(:,3));
% hold on 
% plot(data(:,4));
% hold on

