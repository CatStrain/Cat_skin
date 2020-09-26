%% data processing:
%slice into (5) parts:
strain_gauge_lecture = 200;
strain_gauges = 2;          %we have 8 strain gauges at the same time
total_batches = strain_gauge_lecture/strain_gauges;
Number = [1:total_batches]';

%% Include multiple files into a single table

% aof is the file numbers
aof = 9;

% loop for reading in files:
for ii = 1:aof
    filename = ['test0925_B4_' num2str(ii) '.txt'];
    if (ii == 1)
    %%opts = detectImportOptions(filename,'Delimiter','\n');
    %opts.Datalines = [1:100];
        T4 = readtable(filename);
        T4.Properties.VariableNames={num2str(ii) num2str(ii+1)};
    else
        T4 = [T4,readtable(filename)];
        T4.Properties.VariableNames(ii*2-1:ii*2)={num2str(ii*2-1) num2str(ii*2)};
        %T4.Properties.VariableNames={'A1_1','A2_1','A1_2','A2_2','A1_3','A2_3'};
    end
end
%change the table to array
Tarray = table2array(T4);

% eliminate the offset for each column:
offset_test = mean(T4{1:4,:});
T_without_offset = Tarray-offset_test;
figure(1)
plot(Number',T_without_offset);
legend('A1','A2','A3','A4','A5','A6','A7','A8','A9','A10','A11','A12','A13','A14','A15','A16','A17','A18');
title('Signal plotting(Band4)');
% take the average by columns
for i = 1:total_batches
    if i == 1
        combine = mean(T4{i,:});
    else
        combine = [combine;mean(T4{i,:})];
    end
end

%Curve fitting
%****Important: we can use curve fitting toolbox in MATLAB for expressions
% or using function:
% https://blog.csdn.net/zhanshen112/article/details/79778530
figure(2)
plot(Number',combine);
hold on;
grid on;
c = polyfit(Number',combine',3);%number means how many times the curve repeats fitting(can not over 4)
d = polyval(c,Number',1);
plot(Number',d, 'r' )
xlabel('Counts(ms)');
ylabel('Signal Magnitude');
title('Signal plotting(Band4)');
legend('Combine','Curve fitting');
grid on;
hold off;

%merge tables and save comma seperated file
%writetable(T4,'my_output_file.txt','Delimiter',' ');
%% Standard Deviation
% calculate every rows' std(without offset)
stdev = std(T_without_offset')/18;% depends on the size of data
figure(1)
errorbar(Number,combine,stdev);
xlabel('Counts(ms)');
ylabel('Signal Magnitude');
title('Signal plotting with standerd deviation(Band4)');
legend('error bar');
figure(2)
errorbar(Number,d,stdev,'r');
xlabel('Counts(ms)');
ylabel('Signal Magnitude');
title('Curve fitting with standerd deviation(Band4)');
legend('error bar');
% %% Create sub tables:
% %we could use foor loop but not necessary:
% T_number = array2table(Number);
% T_number.Properties.VariableNames = {'Number'};
% %import the dataset
% T_import = readtable('test0925_B4_2.txt');
% T_import.Properties.VariableNames(1:2) = {'A1','A2'};
% T_test = [T_number,T_import];
% % substract the mean:
% offset_test = mean(T_test{1:4,2:3});
% mean_offset_test = T_test{:,2:3}-offset_test;
% for i = 1:total_batches
%     if i == 1
%         combine = (-mean(mean_offset_test(i,1))+ mean(mean_offset_test(i,2)))/2;
%     else
%         combine = [combine;(-mean(mean_offset_test(i,1))+ mean(mean_offset_test(i,2)))/2];
%     end
% end
% B4_2 = array2table(combine);
% B4_2.Properties.VariableNames = {'B2'};
% enlongation = [1:total_batches];
% figure(1)
% 
% plot(enlongation,mean_offset_test);
% xlabel('Count number');
% ylabel('Signal Magnitude');
% grid on;
% title('Signal plotting(new-0924)');
% legend('A1','A2');
% 
% figure(2)
% plot(enlongation,combine);
% 
% xlabel('Counts(ms)')
% ylabel('Signal Magnitude')
% title('Processed signal(Band_1)');
% legend('Combine');
% grid on;
% 
% 
% 
% %Summrize the table:(show the data characterization)
% %summary(T_test);
% 
% 
% %% Combine then take the average
% T = [T_number,B4_1,B4_2];
% Tarray = table2array(T);
% figure(1)
% plot(enlongation,Tarray);
% title('Signal plotting(Band4)');
% legend('1','2')
% 
% for i = 1:total_batches
%     if i == 1
%         combine = mean(T{i,:});
%     else
%         combine = [combine;mean(T{i,:})];
%     end
% end
% figure(2)
% plot(enlongation,combine);
% hold on;
% grid on;
% c = polyfit(enlongation,combine',3);%number means how many times the curve repeats fitting(can not over 4)
% d = polyval(c,enlongation,1);
% plot(enlongation,d, 'r' )
% xlabel('Counts(ms)');
% ylabel('Signal Magnitude(mean)');
% title('Signal plotting(Band4)');
% legend('Combine','Curve fitting');
% grid on;
% hold off;
% 
