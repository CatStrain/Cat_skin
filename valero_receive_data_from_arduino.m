<<<<<<< HEAD
%%
%This code is used to receive data from 8 strain gauges connected to one
%Arduino board and generate a txt file that contains thes data. This code 
%drags data from the serial port the arduino uses, and write them into a 
%txt file.Each line in the text file represents a reading from the 8 
%strain gauges, and data from each strain gauge is separated by a comma. 


%%
s = serial('COM3');  %port
=======
s = serial('COM5');  %port
>>>>>>> 4fdc31eaa26acdf15cc7274bdff7dbf6b17f1a2f
set(s,'BaudRate',9600);  %
fopen(s);  
fileID = fopen('test_8.txt','w');
 
interval = 1600; %read 200 numbers from arduino. can be adjusted.
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
m=zeros(1,1000); %counter

while(t < interval)
    b = str2num(fgetl(s)); %drag one line from arduino
    if (mod(i,8)==1)
        x1 = b;
        fprintf(fileID,'%d ',x1);
    elseif (mod(i,8)==2)
        x2 = b;
        fprintf(fileID,'%d ',x2);
    elseif (mod(i,8)==3)
        x3 = b;
        fprintf(fileID,'%d ',x3);
    elseif (mod(i,8)==4)
        x4 = b;
        fprintf(fileID,'%d ',x4);
    elseif (mod(i,8)==5)
        x5 = b;
        fprintf(fileID,'%d ',x5);
    elseif (mod(i,8)==6)
        x6 = b;
        fprintf(fileID,'%d ',x6); 
    elseif (mod(i,8)==7)
        x7 = b;
        fprintf(fileID,'%d ',x7);
    else
        x8 = b; 
        fprintf(fileID,'%d\n',x8);
    end
    i=i+1;                
    t = t+passo;
    %drawnow;
end
fclose(s);
fclose(fileID);

