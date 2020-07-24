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
clear all;clc;  % clear all variables
%%

s = serial('COM5');  %port
set(s,'BaudRate',9600);  %
fopen(s);  
fileID = fopen('test_10.txt','w');
 
interval = 20; %read 200 numbers from arduino. can be adjusted.
passo = 1;
t = 1;
x1 = 0;   %8 signals representing 8 strai gauges 
x2 = 0;   %...
x3 = 0;
x4 = 0;
x5 = 0;
x6 = 0;
x7 = 0;
x8 = 0;

i=1;
%m=zeros(1,1000); %counter

data = zeros (interval,8);

while(t < interval)
    b = str2num(fgetl(s)); %takes one line from arduino
    if (t > 3)
        if (mod(i,8)==1)
            x1 = b
            fprintf(fileID,'%d ',x1);
            %data(t,1) = b;
        elseif (mod(i,8)==2)
            x2 = b;
            fprintf(fileID,'%d ',x2);
            %data(t,2) = b;
        elseif (mod(i,8)==3)
            x3 = b;
            fprintf(fileID,'%d ',x3);
            %data(t,3) = b;
        elseif (mod(i,8)==4)
            x4 = b;
            fprintf(fileID,'%d ',x4);
            %data(t,4) = b;
        elseif (mod(i,8)==5)
            x5 = b;
            fprintf(fileID,'%d ',x5);
            %data(t,5) = b;
        elseif (mod(i,8)==6)
            x6 = b;
            fprintf(fileID,'%d ',x6); 
            %data(t,6) = b;
        elseif (mod(i,8)==7)
            x7 = b;
            fprintf(fileID,'%d ',x7);
            %data(t,7) = b;
        else
            x8 = b; 
            fprintf(fileID,'%d\n',x8);
            %data(t,8) = b;
        end
        
        %drawnow;
    end
    i=i+1;                
    t = t+passo;
    
end
fclose(s);
fclose(fileID);

plot(data(:,8));


