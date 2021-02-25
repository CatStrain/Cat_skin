number_of_sensors = 4;
% sensor_1_offset = -70;
% sensor_2_offset = 200;
% sensor_3_offset = -.8*7;
% sensor_4_offset = 240;
flag_distace = 25;
%distance = 1;
zmp_position = 1;
zmp_position_limit = 9;
row_l_data = 1;

data = importdata('C:\Users\dario\Google Drive\USC\Projects\Biped\Figures_and_Tables\Figure 2_Raw Signals\Material\test_0111_800g_lessstiff+black_constant_2.txt');
%labeled_and_labeled_data = zeros (floor(size(data,1)/flag_distace), size(data,2)+1);
%csv_file_name = 'test_121620_1_Loadcells_blackMass' 
%%
%data(:,4) = data(:,4)+250;

figure()
for sensors = 1 : number_of_sensors
    plot(data(:,sensors),'LineWidth',.1);
    hold on 
end
legend('Load Cell:  1','                  2','                  3','                  4', 'FontSize',12)   
%legend('Skin Sensor:  1','                      2','                      3','                      4', 'FontSize',12)   
xlabel('Sample #', 'FontSize',15) 
ylabel('Sensor Reading','FontSize',15)

