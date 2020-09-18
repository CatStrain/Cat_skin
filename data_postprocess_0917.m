%% data processing:
%slice into (5) parts:
strain_gauge_lecture = 1600;
strain_gauges = 8;          %we have 8 strain gauges at the same time
total_batches = strain_gauge_lecture/strain_gauges;
Number = [1:total_batches]';
n=5;
Ave_num = total_batches/n;

% Create sub tables:
%we could use foor loop but not necessary:
T_number = array2table(Number);
T_number.Properties.VariableNames = {'Number'};
%import the dataset
T_import = readtable('test0917_8.txt');
T_import.Properties.VariableNames(1:8) = {'A1','A2','A3','A4','A5','A6','A7','A8'};
T_test = [T_number,T_import];

num = T_number{1:Ave_num:end,1};

stage_1 = T_test{num(1,1):num(2,1),2:9};
stage_2 = T_test{num(2,1):num(3,1),2:9};
stage_3 = T_test{num(3,1):num(4,1),2:9};
stage_4 = T_test{num(4,1):num(5,1),2:9};
stage_5 = T_test{num(5,1):end,2:9};


% substract the mean:
offset_test = mean(stage_1);
mean_test = [mean(stage_1);mean(stage_2);mean(stage_3);mean(stage_4);mean(stage_5)];
mean_offset_test = mean_test-offset_test;% create x axe:
enlongation = [1;2;3;4;5];

%plot(enlongation,mean_offset_test);

%Summrize the table:(show the data characterization)
summary(T_test);

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
% set the first part as offset
offset_test = mean_test(1,:);

%mean_test = [mean(stage_1);mean(stage_2);mean(stage_3);mean(stage_4);mean(stage_5)];
mean_offset_test = mean_test-offset_test;% create x axe:
enlongation = [1:n]';

plot(enlongation,mean_offset_test);
legend('A1','A2','A3','A4','A5','A6','A7','A8');
grid on;
%hold on;

%% MATLAB curve fitting(for one channel signal)
%(method of interpolation)
c = polyfit(enlongation,mean_offset_test(:,5),4);%number means how many times the curve repeats fitting
d = polyval(c,enlongation,1);
plot(enlongation,d, 'r' )
grid on;
hold on;
plot(enlongation,mean_offset_test(:,5),'b')
legend('curve fitting','original')
hold off;
