% Authors: Kenzie Sanders and Lorien Hoshall
% Assignment Title: Project 1: Water Bottle Rocket Force Calibration
% Purpose: To find the average load on each cell from a water bottle rocket
% Date: 10/25/23

close all;
clear;
clc;

%% Reading in the Data and cleaning it up

%Names each file
filename = "Static Test Stand Calibration Case 3.xlsx";
filename1 = "testrun21";
filename2 = "testrun22";
filename3 = "testrun23";
filename4 = "testrun24";
filename5 = "testrun25";
filename6 = "testrun26";
filename7 = "testrun27";
filename8 = "testrun28";
filename9 = "testrun29";
filename10 = "testrun30";

%opens and reads each file
Calibration_data = readmatrix(filename);
Data1 = load(filename1);
Data2 = load(filename2);
Data3 = load(filename3);
Data4 = load(filename4);
Data5 = load(filename5);
Data6 = load(filename6);
Data7 = load(filename7);
Data8 = load(filename8);
Data9 = load(filename9);
Data10 = load(filename10);
%These are now structures

%% Calibration Test polynomial
Calibration_weight = Calibration_data(:,1);
Channel0_offset = Calibration_data(:,2);
Channel1_offset = Calibration_data(:,3);
Channel0_voltage = Calibration_data(:,4);
Channel1_voltage = Calibration_data(:,5);

%shortcuts to make the math nicer
Ch1_eff = Channel1_voltage - Channel1_offset;
Ch0_eff = Channel0_voltage - Channel0_offset;
Sum_eff = Ch1_eff + Ch0_eff;

%Calculating loads on each channel 
LoadChannel1 = Calibration_weight .* Ch1_eff./Sum_eff;
LoadChannel0 = Calibration_weight .* Ch0_eff./Sum_eff;

%% Line of best fit for each cell using polyfit and polyval

%calling polyfit and polyval
%Creates coefficients for the lines of best fit off the calibration data
[Ch0_coeff, Ch0_S] = polyfit(Calibration_weight, LoadChannel0,1);
[Ch1_coeff, Ch1_S] = polyfit(Calibration_weight, LoadChannel1,1);


%% Plotting Case 1
%about to make 10 of these, sorry

[Ch0_bestfit1, Ch0_delta1] = polyval(Ch0_coeff, Data1.mV(:,1), Ch0_S);
[Ch1_bestfit1, Ch1_delta1] = polyval(Ch1_coeff, Data1.mV(:,2), Ch1_S);

figure()
plot(Data1.time,Ch0_bestfit1,Data1.time,Ch1_bestfit1);
xlim([0.5 1.5]); %creates a bound for the time so the graphs aren't incredibly unwieldy

%legends and things for case 1

%% Plotting Case 2

[Ch0_bestfit2, Ch0_delta2] = polyval(Ch0_coeff, Data2.mV(:,1), Ch0_S);
[Ch1_bestfit2, Ch1_delta2] = polyval(Ch1_coeff, Data2.mV(:,2), Ch1_S);

figure()
plot(Data2.time,Ch0_bestfit2,Data2.time,Ch1_bestfit2);
xlim([1 2]); 
%legends and things for case 2


%% Plotting Case 3

[Ch0_bestfit3, Ch0_delta3] = polyval(Ch0_coeff, Data3.mV(:,1), Ch0_S);
[Ch1_bestfit3, Ch1_delta3] = polyval(Ch1_coeff, Data3.mV(:,2), Ch1_S);

figure()
plot(Data3.time,Ch0_bestfit3,Data3.time,Ch1_bestfit3);
xlim([1 2]); 
%legends and things for case 3


%% Plotting Case 4

[Ch0_bestfit4, Ch0_delta4] = polyval(Ch0_coeff, Data4.mV(:,1), Ch0_S);
[Ch1_bestfit4, Ch1_delta4] = polyval(Ch1_coeff, Data4.mV(:,2), Ch1_S);

figure()
plot(Data4.time,Ch0_bestfit4,Data4.time,Ch1_bestfit4);
xlim([1.5 2.5]); 
%legends and things for case 4 

%% Plotting Case 5

[Ch0_bestfit5, Ch0_delta5] = polyval(Ch0_coeff, Data5.mV(:,1), Ch0_S);
[Ch1_bestfit5, Ch1_delta5] = polyval(Ch1_coeff, Data5.mV(:,2), Ch1_S);

figure()
plot(Data5.time,Ch0_bestfit5,Data5.time,Ch1_bestfit5);
xlim([1.2 2.2]); 
%legends and things for case 5


%% Plotting Case 6

[Ch0_bestfit6, Ch0_delta6] = polyval(Ch0_coeff, Data6.mV(:,1), Ch0_S);
[Ch1_bestfit6, Ch1_delta6] = polyval(Ch1_coeff, Data6.mV(:,2), Ch1_S);

figure()
plot(Data6.time,Ch0_bestfit6,Data6.time,Ch1_bestfit6);
xlim([1.5 2.5]); 
%legends and things for case 6

%% Plotting Case 7

[Ch0_bestfit7, Ch0_delta7] = polyval(Ch0_coeff, Data7.mV(:,1), Ch0_S);
[Ch1_bestfit7, Ch1_delta7] = polyval(Ch1_coeff, Data7.mV(:,2), Ch1_S);

figure()
plot(Data7.time,Ch0_bestfit7,Data7.time,Ch1_bestfit7);
xlim([0 1]); 
%legends and things for case 7

%% Plotting Case 8

[Ch0_bestfit8, Ch0_delta8] = polyval(Ch0_coeff, Data8.mV(:,1), Ch0_S);
[Ch1_bestfit8, Ch1_delta8] = polyval(Ch1_coeff, Data8.mV(:,2), Ch1_S);

figure()
plot(Data8.time,Ch0_bestfit8,Data8.time,Ch1_bestfit8);
xlim([2.5 3.5]); 
%legends and things for case 8

%% Plotting Case 9

[Ch0_bestfit9, Ch0_delta9] = polyval(Ch0_coeff, Data9.mV(:,1), Ch0_S);
[Ch1_bestfit9, Ch1_delta9] = polyval(Ch1_coeff, Data9.mV(:,2), Ch1_S);

figure()
plot(Data9.time,Ch0_bestfit9,Data9.time,Ch1_bestfit9);
xlim([.5 1.5]); 
%legends and things for case 9

%% Plotting Case 4

[Ch0_bestfit10, Ch0_delta10] = polyval(Ch0_coeff, Data10.mV(:,1), Ch0_S);
[Ch1_bestfit10, Ch1_delta10] = polyval(Ch1_coeff, Data10.mV(:,2), Ch1_S);

figure()
plot(Data10.time,Ch0_bestfit10,Data10.time,Ch1_bestfit10);
xlim([.5 1.5]); 
%legends and things for case 10

%% Average Peak Thrust and Associated Error
%Take peak thrust from each case
MaxMat=10:2;
[MaxMat(1,1),index11]=max(Ch0_bestfit1); [MaxMat(1,2),index12]=max(Ch1_bestfit1);
[MaxMat(2,1),index21]=max(Ch0_bestfit2); [MaxMat(2,2),index22]=max(Ch1_bestfit2);
[MaxMat(3,1),index31]=max(Ch0_bestfit3); [MaxMat(3,2),index32]=max(Ch1_bestfit3);
[MaxMat(4,1),index41]=max(Ch0_bestfit4); [MaxMat(4,2),index42]=max(Ch1_bestfit4);
[MaxMat(5,1),index51]=max(Ch0_bestfit5); [MaxMat(5,2),index52]=max(Ch1_bestfit5);
[MaxMat(6,1),index61]=max(Ch0_bestfit6); [MaxMat(6,2),index62]=max(Ch1_bestfit6);
[MaxMat(7,1),index71]=max(Ch0_bestfit7); [MaxMat(7,2),index72]=max(Ch1_bestfit7);
[MaxMat(8,1),index81]=max(Ch0_bestfit8); [MaxMat(8,2),index82]=max(Ch1_bestfit8);
[MaxMat(9,1),index91]=max(Ch0_bestfit9); [MaxMat(9,2),index92]=max(Ch1_bestfit9);
[MaxMat(10,1),index101]=max(Ch0_bestfit10); [MaxMat(10,2),index102]=max(Ch1_bestfit10);

%avg and print avg peak thrust
ThrustAvg=mean(mean(MaxMat));
ThrustError=mean(std(MaxMat));
