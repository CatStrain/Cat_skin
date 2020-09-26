%% data processing:
%slice into (5) parts:
strain_gauge_lecture = 200;
strain_gauges = 2;          %we have 8 strain gauges at the same time
total_batches = strain_gauge_lecture/strain_gauges;
Number = [1:total_batches]';

% Create sub tables:
%we could use foor loop but not necessary:
T_number = array2table(Number);
T_number.Properties.VariableNames = {'Number'};
%import the dataset
T_import = readtable('test0925_B3_7.txt');
T_import.Properties.VariableNames(1:2) = {'A1','A2'};
T_test = [T_number,T_import];
% substract the mean:
offset_test = mean(T_test{1:4,2:3});
mean_offset_test = T_test{:,2:3}-offset_test;

for i = 1:total_batches
    if i == 1
        combine = (-mean(mean_offset_test(i,1))+ mean(mean_offset_test(i,2)))/2;
    else
        combine = [combine;(-mean(mean_offset_test(i,1))+ mean(mean_offset_test(i,2)))/2];
    end
end
B3_7 = array2table(combine);
B3_7.Properties.VariableNames = {'B7'};
enlongation = [1:total_batches];
figure(1)

plot(enlongation,mean_offset_test);
xlabel('Count number');
ylabel('Signal Magnitude');
grid on;
title('Signal plotting(new-0924)');
legend('A1','A2');

figure(2)
plot(enlongation,combine);

xlabel('Counts(ms)')
ylabel('Signal Magnitude')
title('Processed signal(Band_1)');
legend('Combine');
grid on;



%Summrize the table:(show the data characterization)
%summary(T_test);


%% Combine then take the average
T = [T_number,B3_1,B3_2,B3_3,B3_4,B3_5,B3_6,B3_7,B3_8,B3_9,B3_10];
Tarray = table2array(T);
figure(1)
plot(enlongation,Tarray);
title('Signal plotting(Band3)');
legend('1','2','3','4','5','6','7','8','9','10')

for i = 1:total_batches
    if i == 1
        combine = mean(T{i,:});
    else
        combine = [combine;mean(T{i,:})];
    end
end
figure(2)
plot(enlongation,combine);
hold on;
grid on;
c = polyfit(enlongation,combine',3);%number means how many times the curve repeats fitting(can not over 4)
d = polyval(c,enlongation,1);
plot(enlongation,d, 'r' )
xlabel('Counts(ms)');
ylabel('Signal Magnitude(mean)');
title('Signal plotting(Band3)');
legend('Combine','Curve fitting');
grid on;
hold off;
%% Data Slicing
% increasing the data slices to fit the curve:
% set the slicing data:
n=50;%n means take the data into n parts

strain_gauge_lecture = 1600;
strain_gauges = 8;          %we have 8 strain gauges at the same time
total_batches = strain_gauge_lecture/strain_gauges;
Number = [1:total_batches]';

Ave_num = total_batches/n;
num = T_number{1:Ave_num:end,1};
 for i = 1:n
     if i==1
         
         mean_test = [mean(T_test{num(i,1):num(i+1,1),2:9})];
     elseif  i<n 
         mean_test= [mean_test;mean(T_test{num(i,1):num(i+1,1),2:9})];
     else
         mean_test= [mean_test;mean(T_test{num(i,1):end,2:9})];
     end
 end
% set the first 2 part as offset
offset_test = (mean_test(1,:)+mean_test(2,:))/2;

%mean_test = [mean(stage_1);mean(stage_2);mean(stage_3);mean(stage_4);mean(stage_5)];
mean_offset_test = mean_test-offset_test;% create x axe:
enlongation = [1:n]';
%while ploting, change the range into stretch length
% the original to maximun elongation is 90mm-100mm
x = enlongation*(10/n)+90;
figure(1)
plot(x,mean_offset_test);
xlabel('Skin-bridge Size (mm)');
ylabel('Signal Magnitude(mean)');
title('Signal plotting(0917-8)');
legend('A1','A2','A3','A4','A5','A6','A7','A8');
grid on;
%hold on;

%% MATLAB curve fitting(for one channel signal)
%(method of interpolation)
figure(2)
c = polyfit(x,mean_offset_test(:,3),3);%number means how many times the curve repeats fitting(can not over 4)
d = polyval(c,x,1);
plot(x,d, 'r' )
grid on;
hold on;
plot(x,mean_offset_test(:,3),'b')
xlabel('Skin-bridge Size (mm)')
ylabel('Signal Magnitude(mean)')
title('Processed signal fiting for channel A3');% channel can be changed in c
legend('curve fitting','original')
hold off;

%% Curve fitting for all channels
figure(3)
for i= 1:8
    curve = polyfit(x,mean_offset_test(:,i),3);
    fit = polyval(curve,x,1);
    plot(x,fit)
    grid on;
    hold on;
end
xlabel('Skin-bridge Size (mm)')
ylabel('Signal Magnitude(mean)')
title('Processed signal fiting for all channels(0917-8)');
legend('A1','A2','A3','A4','A5','A6','A7','A8');
hold off;

%% Combine all eight channels into one 

for i = 1:n
    if i == 1
        combine = mean(mean_offset_test(i,1))- mean(mean_offset_test(i,3));
    else
        combine = [combine;mean(mean_offset_test(i,1))- mean(mean_offset_test(i,3))];
    end
end
figure(4)
plot(x,combine)
hold on;
c = polyfit(x,combine,4);%number means how many times the curve repeats fitting(can not over 4)
d = polyval(c,x,1);
plot(x,d, 'r' )
xlabel('Skin-bridge Size (mm)')
ylabel('Signal Magnitude(mean)')
title('Processed signal (0920-3)');
legend('Combine','Curve fitting');
grid on;
hold off;
