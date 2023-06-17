function [LOSvec]=getLOS(C_e,states,sat_pos,sat_antenna_range,total_sat)
%% This function will calculate Line of Sight vector

%%initialize LOS vector
LOSvec=zeros(3,total_sat);
%%calculate loss vector
for i=1:total_sat
    LOSvec(:,i)=(C_e(:,:,i)*sat_pos(:,i)-states(1:3))/sat_antenna_range(:,i);
end
end