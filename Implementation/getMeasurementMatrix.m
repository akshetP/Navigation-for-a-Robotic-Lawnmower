function [H_mat]=getMeasurementMatrix(LOSvec,total_sat)
%% This function calculate measurement matrix (H) from LOS vector and total number of satellites

%%initialize H matrix
H_mat=zeros(2*total_sat,8);

%%Fill H matrix with the formula given
H_mat(1:total_sat,end-1)=1;
H_mat(1+total_sat:2*total_sat,end)=1;
H_mat(1:total_sat,1:3)=-transpose(LOSvec);
H_mat(1+total_sat:2*total_sat,4:6)=-transpose(LOSvec);

end