function [states]=doLeastSquare(threshold,t,states, total_sat,sat_id,data1,data2,time)
%% this function will perform iterative least square to get states at time t

%%set difference 
diff=1;
%%calculate normalize state
norm_states=norm(states(1:3));

%%main loop until convergence reach
while(diff>threshold)
    %%calculate satellites position and velocity, satellites to antenna
    %%range and C matrix
    [sat_pos,sat_vel,sat_antenna_range,C_e]=getrange(t,states, total_sat,sat_id,threshold);
    %%calculate Line of Sight vector
    [LOSvec]=getLOS(C_e,states,sat_pos,sat_antenna_range,total_sat);
    %%calculate satellites to antenna range rate
    [sat_antenna_range_rate]=getrangerate(sat_pos,sat_vel,C_e, LOSvec,states,total_sat);
    %%get delta innovation matrix
    [d_innov]=getInnovation(data1,data2,t,sat_antenna_range_rate, sat_antenna_range,states,time);
    %%get H matrix
    [H_mat]=getMeasurementMatrix(LOSvec,total_sat);
    %%update state
    states=states+(transpose(H_mat)*H_mat)\transpose(H_mat)*d_innov;
    %%calculate norm and compare with previous norm for convergence check
    norm_prev_states=norm_states;
    norm_states=norm(states(1:3));
    diff=abs(norm_states-norm_prev_states);

end