function DRoutput=DR(data_dr,data_pr,data_prr)

Define_Constants;

format long;

%% Assigning the correct values from the .csv file to the variables
time=data_dr(:,1);
sensor_wheels=data_dr(:,2:5);
ang_rate=data_dr(:,6);
heading_mag=data_dr(:,7)*deg_to_rad;
heading_smooth=zeros(size(heading_mag));
tau=0.5;
sat_id=data_pr(1,2:end);
total_time=length(time);
total_sat=length(sat_id);
threshold=1e-5;
lat=zeros(total_time,1);
long=zeros(total_time,1);


%% Initializig the States
t=0;
states=zeros(8,1);

%% Calling the function 'doLeastSquare' to get the Updated State Values
[states]=doLeastSquare(threshold,t,states,total_sat,sat_id,data_pr,data_prr,time);
% Callling the function "pv_ECEF_to_NED" to convert Cartesian  to curvilinear position and velocity resolving axes from ECEF to NED
[lat_init,long_init,height_init,vel_init] = pv_ECEF_to_NED(states(1:3),states(4:6));
% Assigning the initial latitude, longitude, and height values to their respective arrays
lat(1)=lat_init;
long(1)=long_init;
init_height=height_init;

%% Averaging the driving wheel (Rear Wheels) velocities, ignoring skidding and steering loss
avg_vel=0.5*(sensor_wheels(:,3)+sensor_wheels(:,4));

%% Storing the Average and Instantaneous Velocities
avg_vel_N=zeros(total_time,1);
avg_vel_E=zeros(total_time,1);
inst_vel_N=zeros(total_time,1);
inst_vel_E=zeros(total_time,1);

%% Computing the average velocities in the North and East directons
for i=2:total_time
    % Calculating the average velocity in the North direction for the current time step i
    avg_vel_N(i)=0.5*(cos(heading_mag(i))+cos(heading_mag(i-1)))*avg_vel(i);
    % Calculating the average velocity in the East direction for the current time step i
    avg_vel_E(i)=0.5*(sin(heading_mag(i))+sin(heading_mag(i-1)))*avg_vel(i);
    
    % Returning the radii of curvature in the North and East direction based on the latitude lat(i-1)
    [R_N,R_E]=Radii_of_curvature(lat(i-1));
    % Calculating the time difference between the current time step i and the previous time step i-1
    d_t=time(i)-time(i-1);
    
    % Updating the latitude for the current time step i based on the average velocities
    lat(i)=lat(i-1)+((avg_vel_N(i)*d_t)/(R_N+init_height));
    long(i)=long(i-1)+((avg_vel_E(i)*d_t)/((R_E+init_height)*cos(lat(i))));

end

%% Calculating the instantaneous velocity in North and East directions at t = 1
inst_vel_N(1)=vel_init(1)*cos(heading_mag(i));
inst_vel_E(1)=vel_init(2)*sin(heading_mag(i));

% Calculating the instantaneous velocity in North and East directions from t = 2
for i=2:total_time
    inst_vel_N(i)=1.7*avg_vel_N(i)-0.7*inst_vel_N(i-1);
    inst_vel_E(i)=1.7*avg_vel_E(i)-0.7*inst_vel_E(i-1);
end

%% Calculating the heading using gyro-mag smoothing (Slide3A-55)
W_gm=(1*deg_to_rad+1e-4)/(4*deg_to_rad);

%% Calculating the heading values from gyro values
heading_smooth(1)=heading_mag(1);
for i=2:total_time
    heading_smooth(i)=W_gm*heading_mag(i)+(1-W_gm)*(heading_smooth(i-1)+tau*ang_rate(i));
end

%% Storing the results of a dead reckoning calculation in a structure called 'DRoutput'
DRoutput.time=time;
DRoutput.lat=lat*rad_to_deg;
DRoutput.long=long*rad_to_deg;
DRoutput.velNorth=inst_vel_N;
DRoutput.velEast=inst_vel_E;
DRoutput.avg_vel_N=avg_vel_N;
DRoutput.avg_vel_E=avg_vel_E;
DRoutput.heading=heading_smooth*rad_to_deg;

%% Creating an array "final_ouput" that contains the time, latitude, longitude, north velocity, east velocity, 
% and heading values obtained from the dead reckoning output stored in "DRoutput"
%final_ouput=[DRoutput.time,DRoutput.lat,DRoutput.long,DRoutput.velNorth,DRoutput.velEast,DRoutput.heading];

%% Saving the "final_ouput" array to an Excel file named "final_ouput_DR.xlsx"
%writematrix(final_ouput,'final_ouput_DR.xlsx');

%% Displaying the Success Message in the Command Window
disp('DR done');

end
