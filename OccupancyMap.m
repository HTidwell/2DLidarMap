


anglesShifted = Angles(1,:) + ((3/2)*pi); %this flips all points to orient the scan frame
[x,y] = pol2cart(anglesShifted,Ranges); %converts all the angle and range points to x,y points

yflip = -(y); %points need to be translated about the y axis to represent accurately
xshifted(1,:) = x(1,:) + 2.5; %center scan points to 2.5m along x axis
yshifted(1,:) = yflip(1,:) + 2.5; %center scan points to 2.5m along y axis

yflipped_roted = ((yshifted')); %go from columns to rows for setOccupancy to work
xshift_rot = xshifted'; %same for x points
map = occupancyMap(5,5,100); % make a 5m x 5m map, with a resolution of 100 points
setOccupancy(map,[xshift_rot,yflipped_roted],ones(8000,1)); %set all the measured points to occupied 

%scan = lidarScan(rangesM,angles);
figure;
show(map)