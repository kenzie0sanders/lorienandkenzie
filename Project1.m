% Authors: Kenzie Sanders and Lorien Hoshall
% Assignment Title: Project 1: Water Bottle Rocket Force Calibration
% Purpose: To find the average load on each cell from a water bottle rocket
% Date: 10/25/23

%% Reading in the Data and cleaning it up

%Names each file
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
readmatrix
%for loop for each of 10 cases

%separates into two cells

%cleans up cells from NaNs, leaving 0s at beinning and end
filename1 = rmmissing(filename1);
filename2 = rmmissing(filename2);
filename3 = rmmissing(filename3);
filename4 = rmmissing(filename4);
filename5 = rmmissing(filename5);
filename6 = rmmissing(filename6);
filename7 = rmmissing(filename7);
filename8 = rmmissing(filename8);
filename9 = rmmissing(filename9);
filename10 = rmmissing(filename10);

%% Line of best fit for each cell using polyfit and polyval

% for loop

% polyfit and polyval for each cell for each case (20 Total lines)


%% Plotting each case's two different lines for each cell

%for Loop

%creates 10 different figures

%plots two lines in each graph, cell 1 and cell 2

%legends and things


%% Average Peak Thrust and Associated Error
%Take peak thrust from each case
MaxMat=[1:10];
MaxMat(1)=max(filename1);
MaxMat(2)=max(filename2);
MaxMat(3)=max(filename3);
MaxMat(4)=max(filename4);
MaxMat(5)=max(filename5);
MaxMat(6)=max(filename6);
MaxMat(7)=max(filename7);
MaxMat(8)=max(filename8);
MaxMat(9)=max(filename9);
MaxMat(10)=max(filename10);

%avg and print avg peak thrust
ThrustAvg=avg(MaxMat);
