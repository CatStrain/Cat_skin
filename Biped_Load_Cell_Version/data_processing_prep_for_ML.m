number_of_sensors = 4;
sensor_1_offset = -70;
sensor_2_offset = 200;
sensor_3_offset = -.8*7;
sensor_4_offset = 240;
flag_distace = 25;
%distance = 1;
zmp_position = 1;
zmp_position_limit = 9;
row_l_data = 1;

data = importdata('test_121620_1_Loadcells_blackMass.txt');
labeled_and_labeled_data = zeros (floor(size(data,1)/flag_distace), size(data,2)+1);
csv_file_name = 'test_121620_1_Loadcells_blackMass' 
%%
figure()
for sensors = 1 : number_of_sensors
    plot(data(:,sensors));
    hold on 
end
legend('Elasctic Band 1','2','3','4')

%% To reverse seonsr calibration (to pair lower limit of sensors with 0)
data(:,1) = data(:,1) - sensor_1_offset;
data(:,2) = data(:,2) - sensor_2_offset;
data(:,3) = data(:,3) - sensor_3_offset;
data(:,4) = data(:,4) - sensor_4_offset;


figure()
for sensors = 1 : number_of_sensors
    plot(data(:,sensors));
    hold on 
end
legend('Elasctic Band 1','2','3','4')

%% Simpifying data matrix: only taking one value per step, adding flags, and creating csv file

%zeros(length(data),1);
row_l_data = 1;
for i = 1 : length(labeled_and_labeled_data)
    labeled_and_labeled_data(row_l_data,:) = [data(((row_l_data*flag_distace)-12),:), zmp_position];
    zmp_position = zmp_position+1;
    if zmp_position == (zmp_position_limit)
         zmp_posotion = 1;
    end
    row_l_data = row_l_data + 1;
end

figure()
for sensors = 1 : number_of_sensors
    plot(labeled_and_labeled_data(:,sensors));
    hold on 
end
legend('Elasctic Band 1','2','3','4')

csvwrite(csv_file_name,labeled_and_labeled_data)
