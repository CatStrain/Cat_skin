clear all;
clc;
%%
data_b = zeros(200,1);
data_c = zeros(200,1);

s_1 = serial('COM5','baudrate',9600);
s_2 = serial('COM6','baudrate',9600);
%%
try
    fopen(s_1);
catch err
    fclose(instrfind);
    error('Make sure you select the correct COM5 Port where the Arduino is connected.');
end
try
    fopen(s_2);
catch err
    fclose(instrfind);
    error('Make sure you select the correct COM6 Port where the Arduino is connected.');
end
%%
for data_line = 1:400
        b = str2double(fgetl(s_1));              %read line from file
        if b                                     %if there is a line
            data_b(data_line,1) = b;
        end
        c = str2double(fgetl(s_2)); 
        if c                                     %if there is a line
            data_c(data_line,1) = c;
        end
end
%%
fclose(s_1);
fclose(s_2);
%%
figure()


plot(data_b(:,1));
hold on 
plot(data_c(:,1));
    
