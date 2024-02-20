%clear all;
% arduinoObj = serialport("COM4",115200);
% configureTerminator(arduinoObj,"CR/LF");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%wait for connection before running 
numDataPoints = 8000;
count = 1;

Ranges = [];
Angles = [];
while count <= numDataPoints
dataArd = readline(arduinoObj);
splitData = strsplit(dataArd,','); % Cast to string, split on the comma
distanceMM = str2num(splitData{1}); % distance
angleDeg = str2num(splitData{2}); % angle
scanStartBit = str2num(splitData{3}); % indicates start of a new scans      
range = distanceMM./1000;  %convert from millimeters to meters
angle = deg2rad(angleDeg);  %convert to rad
Ranges(1,count) = range; %append measurement to end of range matrix
Angles(1,count) = deg2rad(angleDeg);   %[Angles , angle];
count = count + 1;  
end