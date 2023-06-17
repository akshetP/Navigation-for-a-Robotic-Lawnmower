%%Here, we are implementing GNSS and DR and combining them using Kalman
%%Filter

clear all;

Define_Constants;

%%read input data
data_pr=readmatrix('Pseudo_ranges.csv');
data_prr=readmatrix('Pseudo_range_rates.csv');
data_dr=readmatrix('Dead_reckoning.csv');

%run GNSS function 
GNSSoutput=GNSS(data_pr,data_prr);

%run DR function
DRoutput=DR(data_dr,data_pr,data_prr);

%run integration
Final=Integration(GNSSoutput,DRoutput);

%plot the result
fig1=figure;
fig1.Position=[0,0,900,900];
plot(Final.Long,Final.Lat,GNSSoutput.long,GNSSoutput.lat,DRoutput.long,DRoutput.lat);
xlabel('Longitude');
ylabel('Latitude');
legend('Integration Position','GNSS Position','DR Position','Location','best');
title('Position Solution')
grid on;
print('pos_comparison','-djpeg','-r800')

fig2=figure;
fig2.Position=[0,0,900,900];
plot(Final.Long,Final.Lat);
xlabel('Longitude');
ylabel('Latitude');
legend('Integration Position');
title('Final Position Solution')
grid on;
saveas(fig2,'final_pos.jpg');
print('final_pos','-djpeg','-r800')


fig3=figure;
fig3.Position=[0,0,900,900];
plot(Final.Time,Final.VelNorth,Final.Time,Final.VelEast);
xlabel('Time');
ylabel('Velocity');
legend('North Vel','East Vel');
title('Final Velocity Solution');
grid on;
saveas(fig3,'final_vel.jpg');
print('final_vel','-djpeg','-r800')


fig4=figure;
fig4.Position=[0,0,900,900];
plot(Final.Time,Final.Head);
xlabel('Time');
ylabel('Heading');
title('Final Heading Solution');
grid on;
saveas(fig4,'final_head.jpg');
print('final_head','-djpeg','-r800');


fig5=figure;
fig5.Position=[0,0,900,900];
geoplot(Final.Lat,Final.Long)
legend('Integration Vel');
title('Geo Plot of Integrated Solution');
grid on;
saveas(fig5,'final_pos_geoplot.jpg');
print('final_pos_geoplot','-djpeg','-r800');

fig6=figure;
fig6.Position=[0,0,900,900];
plot(GNSSoutput.long,GNSSoutput.lat);
xlabel('Longitude');
ylabel('Latitude');
title('GNSS Position Solution');
grid on;
saveas(fig6,'GNSS_pos.jpg');
print('GNSS_pos','-djpeg','-r800');

fig7=figure;
fig7.Position=[0,0,900,900];
plot(Final.Time,GNSSoutput.velNorth,Final.Time,GNSSoutput.velEast);
xlabel('Time');
ylabel('Velocity');
legend('North Vel','East Vel');
title('GNSS Velocity Solution');
grid on;
print('GNSS_vel','-djpeg','-r800');

%%DR Plotting
fig8=figure;
fig8.Position=[0,0,900,900];
plot(DRoutput.long,DRoutput.lat);
xlabel('Longitude');
ylabel('Latitude');
legend('DR Position');
title('DR Position Solution')
grid on;
saveas(fig8,'dr_pos.jpg');
print('dr_pos','-djpeg','-r800')


fig9=figure;
fig9.Position=[0,0,900,900];
plot(Final.Time,DRoutput.velNorth,Final.Time,DRoutput.velEast);
xlabel('Time');
ylabel('Velocity');
legend('North Vel','East Vel');
title('DR Velocity Solution');
grid on;
saveas(fig9,'dr_vel.jpg');
print('dr_vel','-djpeg','-r800')


fig10=figure;
fig10.Position=[0,0,900,900];
plot(Final.Time,DRoutput.heading);
xlabel('Time');
ylabel('Heading');
title('DR Heading Solution');
grid on;
saveas(fig10,'dr_head.jpg');
print('dr_head','-djpeg','-r800');
