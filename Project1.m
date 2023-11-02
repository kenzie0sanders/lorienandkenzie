% Authors: Kenzie Sanders and Lorien Hoshall
% Assignment Title: Project 1: Water Bottle Rocket Force Calibration
% Purpose: To find the average load on each cell from a water bottle rocket
% Date Created: 10/25/23
% Date Revised: 10/26, 27, 28

close all;
clear;
clc;

%% Reading in the Data and cleaning it up

%Names each file
filename = "Static Test Stand Calibration Case 3.xlsx";
for i=1:10
filename(i+1) = sprintf("testrun%g", 20+i);
end
%opens and reads each file
Calibration_data = readmatrix(filename(1));

for j=1:10
Data(j) = load(filename(j+1));
end

%These are now structures
%cleans up the data for anything below 0

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

%% Creating Lines of Best Fit for 
%Creates coefficients for the lines of best fit off the calibration data
[Ch0_coeff, Ch0_S,MU0] = polyfit(Ch0_eff, LoadChannel0, 1);
[Ch1_coeff, Ch1_S,MU1] = polyfit(Ch1_eff, LoadChannel1, 1);

%using polyval to find the lines of voltage vs weight and make sure its
%accurate
[Ch0_calibrationfit, Ch0_delta] = polyval(Ch0_coeff, Ch0_eff, Ch0_S,MU0);
[Ch1_calibrationfit, Ch1_delta] = polyval(Ch1_coeff, Ch1_eff, Ch1_S,MU1);

%converting load on one channel to total load
Total_calibrationfit = Ch1_calibrationfit.*(Sum_eff)./Ch1_eff;
Total_calibrationerr = Total_calibrationfit+(Ch0_delta+Ch1_delta);
Total_calibrationerr1 = Total_calibrationfit-(Ch0_delta+Ch1_delta);

%plotting
plot(Sum_eff/2,Total_calibrationfit,'b-'); hold on;
plot(Sum_eff/2,Total_calibrationerr,'k-',Sum_eff/2,Total_calibrationerr1,'k-')

title("Calibration Test Data","Voltage vs Thrust");
xlabel("Voltage (mV)");
ylabel("Thrust (lbs)");
legend("Total Thrust","95% Error")

%% Plotting Cases 1 through 10

%preallocating matrices
MaxMat=10:1;

%does the work of 10 cases in one loop, wish i knew about this before
%typing out each one individually
for k=1:10
[Ch0_bestfit, Ch0_delta] = polyval(Ch0_coeff, Data(k).mV(:,1), Ch0_S,MU0);
[Ch1_bestfit, Ch1_delta] = polyval(Ch1_coeff, Data(k).mV(:,2), Ch1_S,MU1);

%converting load on one channel to total load
Total_bestfit0 = Ch0_bestfit.*(Data(k).mV(:,1)+Data(k).mV(:,2))./Data(k).mV(:,1);
Total_bestfit1 = Ch1_bestfit.*(Data(k).mV(:,1)+Data(k).mV(:,2))./Data(k).mV(:,2);
Total_bestfit = (Total_bestfit0+Total_bestfit1)/2;
Total_bestfit(isnan(Total_bestfit))=0; % clearing up NaNs and inf from dividing by 0
Total_bestfit(isinf(Total_bestfit))=0;

figure()
plot(Data(k).time,Total_bestfit);
hold on

%Error Bars for Channel 0
err1_Ch0=zeros(size(Ch0_bestfit));
N=100;
ixErr_0=1:N:numel(Ch0_bestfit);
err1_Ch0(ixErr_0) = 2*Ch0_delta(ixErr_0);

%Error Bars for Channel 1
err1_Ch1=zeros(size(Ch1_bestfit));
ixErr_1=1:N:numel(Ch1_bestfit);
err1_Ch1(ixErr_1) = 2*Ch1_delta(ixErr_1); %2*std is required or 95% confidence interval
errorbar(Data(k).time(ixErr_1),Ch1_bestfit(ixErr_1)+Ch0_bestfit(ixErr_0),err1_Ch0(ixErr_1)+err1_Ch0(ixErr_0),'LineStyle','none');

%creates a bound for the time so the graphs aren't incredibly unwieldy
[MAX,indexMAX]=max(Ch1_bestfit+Ch0_bestfit);
timeMAX = Data(k).time(indexMAX);
if timeMAX-1<0
    xLEFT = 0;
    xRIGHT = timeMAX+1+(1-timeMAX);
else
    xLEFT = timeMAX-1;
    xRIGHT = timeMAX+1;
end
xlim([xLEFT xRIGHT]); 
hold off

%legends and things for case 1
xlabel("Time(s)");
ylabel("Thrust (lbs)");
title(sprintf("Test Case %g",k));
legend("Total Force", "Total Error");

%finding the max of each line
MaxMat(k)=max(Total_bestfit); 

end

%% Calculates Average peak thrust and error

ThrustAvg=mean(MaxMat);
ThrustError=std(MaxMat);
