%% data processing:
%load the parameters
strain_gauge_lecture = 800;
strain_gauges = 8;          %we have 8 strain gauges at the same time
total_batches = strain_gauge_lecture/strain_gauges;
Number = [1:total_batches]';

%% Include multiple files into a single table

% aof is the file numbers
aof = 10;

% loop for reading in files:
for ii = 1:aof
    filename = ['test0926_B1_' num2str(ii) '.txt'];
    if (ii == 1)
    %%opts = detectImportOptions(filename,'Delimiter','\n');
    %opts.Datalines = [1:100];
        T_1 = readtable(filename);
        T = T_1{:,7:8};%% read certain columns for Band_1
        %%T.Properties.VariableNames(1:2)={num2str(ii) num2str(ii+1)};
    else
        T_1 = readtable(filename);
        %T = T_1{:,7:8};
        T = [T,T_1{:,7:8}];
       % T.Properties.VariableNames(ii*2-1:ii*2)={num2str(ii*2-1) num2str(ii*2)};
        %T4.Properties.VariableNames={'A1_1','A2_1','A1_2','A2_2','A1_3','A2_3'};
    end
end
%change the table to array
%%Tarray = table2array(T);
%delete the first row
T=T(2:100,:);% eliminate the first line (if necessary), depends on the data
T_table = array2table(T);

% eliminate the offset for each column:
offset_test = mean(T_table{1:8,:});
T_without_offset = T-offset_test;
figure(1)
plot(Number(1:99)',T_without_offset(:,3:20));
legend('A1','A2','A3','A4','A5','A6','A7','A8','A9','A10','A11','A12','A13','A14','A15','A16','A17','A18','A19','A20');
title('Signal plotting(Band1)');
% take the average by columns
for i = 1:total_batches-1
    if i == 1
        combine = mean(T_without_offset(i,3:20));
    else
        combine = [combine;mean(T_without_offset(i,3:20))];
    end
end

%Curve fitting
%****Important: we can use curve fitting toolbox in MATLAB for expressions
% or using function:
% https://blog.csdn.net/zhanshen112/article/details/79778530
figure(2)
plot(Number(1:99)',combine);
hold on;
grid on;
c = polyfit(Number(1:99)',combine',3);%number means how many times the curve repeats fitting(can not over 4)
d = polyval(c,Number(1:99)',1);
plot(Number(1:99)',d, 'r' )
xlabel('Counts(ms)');
ylabel('Signal Magnitude');
title('Signal plotting(Band1,old Amplifier)');
legend('Combine','Curve fitting');
grid on;
hold off;

%merge tables and save comma seperated file
%writetable(T4,'my_output_file.txt','Delimiter',' ');
%% Standard Deviation
% calculate every rows' std(without offset)
stdev = std(T_without_offset(:,3:20)')/18;% depends on the size of data
figure(3)
errorbar(Number(1:99),combine,stdev);
xlabel('Counts(ms)');
ylabel('Signal Magnitude');
title('Signal plotting with standerd deviation(Band1,old amplifier)');
legend('error bar');
figure(4)
errorbar(Number(1:99),d,stdev,'r');
xlabel('Counts(ms)');
ylabel('Signal Magnitude');
title('Curve fitting with standerd deviation(Band1,old amplifier)');
legend('error bar');