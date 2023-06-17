function [sat_antenna_range_rate]=getrangerate(sat_pos,sat_vel,C_e,LOSvec,states,total_sat)
%% This function will calculate range rate from given formula

Define_Constants;

sat_antenna_range_rate=zeros(1,total_sat);

for i=1:total_sat
    sat_antenna_range_rate(:,i)=transpose(LOSvec(:,i))*....
        ((C_e(:,:,i)*(sat_vel(:,i)+Omega_ie*sat_pos(:,i)))-(states(4:6)+Omega_ie*states(1:3)));

end

end