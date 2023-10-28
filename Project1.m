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
hold on

%Error Bars for Chanel 0
err1_Ch0=zeros(size(Ch0_bestfit1));
N=100;
ixErr_1_0=1:N:numel(Ch0_bestfit1);
err1_Ch0(ixErr_1_0) = std(Ch0_bestfit1);
errorbar(Data1.time(ixErr_1_0),Ch0_bestfit1(ixErr_1_0),err1_Ch0(ixErr_1_0),'LineStyle','none');

%Error Bars for Chanel 1
err1_Ch1=zeros(size(Ch1_bestfit1));
ixErr_1_1=1:N:numel(Ch1_bestfit1);
err1_Ch1(ixErr_1_1) = std(Ch1_bestfit1);
errorbar(Data1.time(ixErr_1_1),Ch1_bestfit1(ixErr_1_1),err2_Ch0(ixErr_1_1),'LineStyle','none');

xlim([0.5 1.5]); %creates a bound for the time so the graphs aren't incredibly unwieldy
hold off

%legends and things for case 1
xlabel("Time(s)");
ylabel("Thrust (lbs)");
title("Test Case 1");
legend("Chanel 0", 'Chanel 1', 'Chanel 0 Error', 'Chanel 1 Error');

%% Plotting Case 2

[Ch0_bestfit2, Ch0_delta2] = polyval(Ch0_coeff, Data2.mV(:,1), Ch0_S);
[Ch1_bestfit2, Ch1_delta2] = polyval(Ch1_coeff, Data2.mV(:,2), Ch1_S);

figure()
plot(Data2.time,Ch0_bestfit2,Data2.time,Ch1_bestfit2);
xlim([1 2]); 
hold on

%Error Bars for Chanel 0
err2_Ch0=zeros(size(Ch0_bestfit2));
ixErr_2_0=1:N:numel(Ch0_bestfit2);
err2_Ch0(ixErr_2_0) = std(Ch0_bestfit2);
errorbar(Data2.time(ixErr_2_0),Ch0_bestfit2(ixErr_2_0),err2_Ch0(ixErr_2_0),'LineStyle','none');

%Error Bars for Chanel 1
err2_Ch1=zeros(size(Ch1_bestfit2));
ixErr_2_1=1:N:numel(Ch1_bestfit2);
err2_Ch1(ixErr_2_1) = std(Ch1_bestfit2);
errorbar(Data2.time(ixErr_2_1),Ch1_bestfit2(ixErr_2_1),err2_Ch1(ixErr_2_1),'LineStyle','none');
hold off

%legends and things for case 1
xlabel("Time(s)");
ylabel("Thrust (lbs)");
title("Test Case 2");
legend('Chanel 0', 'Chanel 1', 'Chanel 0 Error', 'Chanel 1 Error');

%% Plotting Case 3

[Ch0_bestfit3, Ch0_delta3] = polyval(Ch0_coeff, Data3.mV(:,1), Ch0_S);
[Ch1_bestfit3, Ch1_delta3] = polyval(Ch1_coeff, Data3.mV(:,2), Ch1_S);

figure()
plot(Data3.time,Ch0_bestfit3,Data3.time,Ch1_bestfit3);
xlim([1 2]); 
hold on

%Error Bars for Chanel 0
err3_Ch0=zeros(size(Ch0_bestfit3));
ixErr_3_0=1:N:numel(Ch0_bestfit3);
err3_Ch0(ixErr_3_0) = std(Ch0_bestfit3);
errorbar(Data3.time(ixErr_3_0),Ch0_bestfit3(ixErr_3_0),err3_Ch0(ixErr_3_0),'LineStyle','none');

%Error Bars for Chanel 1
err3_Ch1=zeros(size(Ch1_bestfit3));
ixErr_3_1=1:N:numel(Ch1_bestfit3);
err3_Ch1(ixErr_3_1) = std(Ch1_bestfit3);
errorbar(Data3.time(ixErr_3_1),Ch1_bestfit3(ixErr_3_1),err3_Ch1(ixErr_3_1),'LineStyle','none');
hold off

%legends and things for case 1
xlabel("Time(s)");
ylabel("Thrust (lbs)");
title("Test Case 3");
legend('Chanel 0', 'Chanel 1', 'Chanel 0 Error', 'Chanel 1 Error');

%% Plotting Case 4

[Ch0_bestfit4, Ch0_delta4] = polyval(Ch0_coeff, Data4.mV(:,1), Ch0_S);
[Ch1_bestfit4, Ch1_delta4] = polyval(Ch1_coeff, Data4.mV(:,2), Ch1_S);

figure()
plot(Data4.time,Ch0_bestfit4,Data4.time,Ch1_bestfit4);
xlim([1.5 2.5]); 
hold on

%Error Bars for Chanel 0
err4_Ch0=zeros(size(Ch0_bestfit4));
ixErr_4_0=1:N:numel(Ch0_bestfit4);
err4_Ch0(ixErr_4_0) = std(Ch0_bestfit4);
errorbar(Data4.time(ixErr_4_0),Ch0_bestfit4(ixErr_4_0),err4_Ch0(ixErr_4_0),'LineStyle','none');

%Error Bars for Chanel 1
err4_Ch1=zeros(size(Ch1_bestfit4));
ixErr_4_1=1:N:numel(Ch1_bestfit4);
err4_Ch1(ixErr_4_1) = std(Ch1_bestfit4);
errorbar(Data4.time(ixErr_4_1),Ch1_bestfit4(ixErr_4_1),err4_Ch1(ixErr_4_1),'LineStyle','none');
hold off

%legends and things for case 1
xlabel("Time(s)");
ylabel("Thrust (lbs)");
title("Test Case 4");
legend('Chanel 0', 'Chanel 1', 'Chanel 0 Error', 'Chanel 1 Error');

%% Plotting Case 5

[Ch0_bestfit5, Ch0_delta5] = polyval(Ch0_coeff, Data5.mV(:,1), Ch0_S);
[Ch1_bestfit5, Ch1_delta5] = polyval(Ch1_coeff, Data5.mV(:,2), Ch1_S);

figure()
plot(Data5.time,Ch0_bestfit5,Data5.time,Ch1_bestfit5);
xlim([1.2 2.2]); 
hold on

%Error Bars for Chanel 0
err5_Ch0=zeros(size(Ch0_bestfit5));
ixErr_5_0=1:N:numel(Ch0_bestfit5);
err5_Ch0(ixErr_5_0) = std(Ch0_bestfit5);
errorbar(Data5.time(ixErr_5_0),Ch0_bestfit5(ixErr_5_0),err5_Ch0(ixErr_5_0),'LineStyle','none');

%Error Bars for Chanel 1
err5_Ch1=zeros(size(Ch1_bestfit5));
ixErr_5_1=1:N:numel(Ch1_bestfit5);
err5_Ch1(ixErr_5_1) = std(Ch1_bestfit5);
errorbar(Data5.time(ixErr_5_1),Ch1_bestfit5(ixErr_5_1),err5_Ch1(ixErr_5_1),'LineStyle','none');
hold off

%legends and things for case 1
xlabel("Time(s)");
ylabel("Thrust (lbs)");
title("Test Case 5");
legend('Chanel 0', 'Chanel 1', 'Chanel 0 Error', 'Chanel 1 Error');

%% Plotting Case 6

[Ch0_bestfit6, Ch0_delta6] = polyval(Ch0_coeff, Data6.mV(:,1), Ch0_S);
[Ch1_bestfit6, Ch1_delta6] = polyval(Ch1_coeff, Data6.mV(:,2), Ch1_S);

figure()
plot(Data6.time,Ch0_bestfit6,Data6.time,Ch1_bestfit6);
xlim([1.5 2.5]); 
hold on

%Error Bars for Chanel 0
err6_Ch0=zeros(size(Ch0_bestfit6));
ixErr_6_0=1:N:numel(Ch0_bestfit6);
err6_Ch0(ixErr_6_0) = std(Ch0_bestfit6);
errorbar(Data6.time(ixErr_6_0),Ch0_bestfit6(ixErr_6_0),err6_Ch0(ixErr_6_0),'LineStyle','none');

%Error Bars for Chanel 1
err6_Ch1=zeros(size(Ch1_bestfit6));
ixErr_6_1=1:N:numel(Ch1_bestfit6);
err6_Ch1(ixErr_6_1) = std(Ch1_bestfit6);
errorbar(Data6.time(ixErr_6_1),Ch1_bestfit6(ixErr_6_1),err6_Ch1(ixErr_6_1),'LineStyle','none');
hold off

%legends and things for case 1
xlabel("Time(s)");
ylabel("Thrust (lbs)");
title("Test Case 6");
legend('Chanel 0', 'Chanel 1', 'Chanel 0 Error', 'Chanel 1 Error');

%% Plotting Case 7

[Ch0_bestfit7, Ch0_delta7] = polyval(Ch0_coeff, Data7.mV(:,1), Ch0_S);
[Ch1_bestfit7, Ch1_delta7] = polyval(Ch1_coeff, Data7.mV(:,2), Ch1_S);

figure()
plot(Data7.time,Ch0_bestfit7,Data7.time,Ch1_bestfit7);
xlim([0 1]); 
hold on

%Error Bars for Chanel 0
err7_Ch0=zeros(size(Ch0_bestfit7));
ixErr_7_0=1:N:numel(Ch0_bestfit7);
err7_Ch0(ixErr_7_0) = std(Ch0_bestfit7);
errorbar(Data7.time(ixErr_7_0),Ch0_bestfit7(ixErr_7_0),err7_Ch0(ixErr_7_0),'LineStyle','none');

%Error Bars for Chanel 1
err7_Ch1=zeros(size(Ch1_bestfit7));
ixErr_7_1=1:N:numel(Ch1_bestfit7);
err7_Ch1(ixErr_7_1) = std(Ch1_bestfit7);
errorbar(Data7.time(ixErr_7_1),Ch1_bestfit7(ixErr_7_1),err7_Ch1(ixErr_7_1),'LineStyle','none');
hold off

%legends and things for case 1
xlabel("Time(s)");
ylabel("Thrust (lbs)");
title("Test Case 7");
legend('Chanel 0', 'Chanel 1', 'Chanel 0 Error', 'Chanel 1 Error');

%It was at this point Lorien realized coding all of these error bars might be easier with a function, but she was already almost done

%% Plotting Case 8

[Ch0_bestfit8, Ch0_delta8] = polyval(Ch0_coeff, Data8.mV(:,1), Ch0_S);
[Ch1_bestfit8, Ch1_delta8] = polyval(Ch1_coeff, Data8.mV(:,2), Ch1_S);

figure()
plot(Data8.time,Ch0_bestfit8,Data8.time,Ch1_bestfit8);
xlim([2.5 3.5]); 
hold on

%Error Bars for Chanel 0
err8_Ch0=zeros(size(Ch0_bestfit8));
ixErr_8_0=1:N:numel(Ch0_bestfit8);
err8_Ch0(ixErr_8_0) = std(Ch0_bestfit8);
errorbar(Data8.time(ixErr_8_0),Ch0_bestfit8(ixErr_8_0),err8_Ch0(ixErr_8_0),'LineStyle','none');

%Error Bars for Chanel 1
err8_Ch1=zeros(size(Ch1_bestfit8));
ixErr_8_1=1:N:numel(Ch1_bestfit8);
err8_Ch1(ixErr_8_1) = std(Ch1_bestfit8);
errorbar(Data8.time(ixErr_8_1),Ch1_bestfit8(ixErr_8_1),err8_Ch1(ixErr_8_1),'LineStyle','none');
hold off

%legends and things for case 1
xlabel("Time(s)");
ylabel("Thrust (lbs)");
title("Test Case 8");
legend('Chanel 0', 'Chanel 1', 'Chanel 0 Error', 'Chanel 1 Error');

%% Plotting Case 9

[Ch0_bestfit9, Ch0_delta9] = polyval(Ch0_coeff, Data9.mV(:,1), Ch0_S);
[Ch1_bestfit9, Ch1_delta9] = polyval(Ch1_coeff, Data9.mV(:,2), Ch1_S);

figure()
plot(Data9.time,Ch0_bestfit9,Data9.time,Ch1_bestfit9);
xlim([.5 1.5]); 
hold on

%Error Bars for Chanel 0
err9_Ch0=zeros(size(Ch0_bestfit9));
ixErr_9_0=1:N:numel(Ch0_bestfit9);
err9_Ch0(ixErr_9_0) = std(Ch0_bestfit9);
errorbar(Data9.time(ixErr_9_0),Ch0_bestfit9(ixErr_9_0),err9_Ch0(ixErr_9_0),'LineStyle','none');

%Error Bars for Chanel 1
err9_Ch1=zeros(size(Ch1_bestfit9));
ixErr_9_1=1:N:numel(Ch1_bestfit9);
err9_Ch1(ixErr_9_1) = std(Ch1_bestfit9);
errorbar(Data9.time(ixErr_9_1),Ch1_bestfit9(ixErr_9_1),err9_Ch1(ixErr_9_1),'LineStyle','none');
hold off

%legends and things for case 1
xlabel("Time(s)");
ylabel("Thrust (lbs)");
title("Test Case 9");
legend('Chanel 0', 'Chanel 1', 'Chanel 0 Error', 'Chanel 1 Error');

%% Plotting Case 10

[Ch0_bestfit10, Ch0_delta10] = polyval(Ch0_coeff, Data10.mV(:,1), Ch0_S);
[Ch1_bestfit10, Ch1_delta10] = polyval(Ch1_coeff, Data10.mV(:,2), Ch1_S);

figure()
plot(Data10.time,Ch0_bestfit10,Data10.time,Ch1_bestfit10);
xlim([.5 1.5]); 
hold on

%Error Bars for Chanel 0
err10_Ch0=zeros(size(Ch0_bestfit10));
ixErr_10_0=1:N:numel(Ch0_bestfit10);
err10_Ch0(ixErr_10_0) = std(Ch0_bestfit10);
errorbar(Data10.time(ixErr_10_0),Ch0_bestfit10(ixErr_10_0),err10_Ch0(ixErr_10_0),'LineStyle','none');

%Error Bars for Chanel 1
err10_Ch1=zeros(size(Ch1_bestfit10));
ixErr_10_1=1:N:numel(Ch1_bestfit10);
err10_Ch1(ixErr_10_1) = std(Ch1_bestfit10);
errorbar(Data10.time(ixErr_10_1),Ch1_bestfit10(ixErr_10_1),err10_Ch1(ixErr_10_1),'LineStyle','none');
hold off

%legends and things for case 1
xlabel("Time(s)");
ylabel("Thrust (lbs)");
title("Test Case 9");
legend('Chanel 0', 'Chanel 1', 'Chanel 0 Error', 'Chanel 1 Error');

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

%avg peak thrust and error
ThrustAvg=mean(mean(MaxMat));
ThrustError=mean(std(MaxMat));
