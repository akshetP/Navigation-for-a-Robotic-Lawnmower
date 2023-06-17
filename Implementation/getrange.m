function [sat_pos,sat_vel,sat_antenna_range,C_e]=getrange(t,states,total_sat,sat_id,threshold)
%% %This function will implement iterative calculation for satellites to antena range until convergence

Define_Constants;
%%initialize satellites position
sat_pos=zeros(3,total_sat);
%%initialize satellites velocity
sat_vel=zeros(3,total_sat);
%%initializae antenna to satellite range
sat_antenna_range=zeros(1,total_sat);
%%initialize C_e matrix with identity for all satellites
C_e=repmat(eye(3), [1, 1, total_sat]);

for i=1:total_sat
    %%get satellites position and velocity using given function helper
    [sat_pos(:,i),sat_vel(:,i)] = Satellite_position_and_velocity(t,sat_id(i));
    %%noise std pseudo range 10
    initial_range=10;
    %%iterate until convergence. this will refine C_e and satellite to
    %%antenna range
    while abs(initial_range-sat_antenna_range(:,i))>threshold
        initial_range=sat_antenna_range(:,i);
        sat_antenna_range(:,i)=sqrt(transpose(C_e(:,:,i)*sat_pos(:,i)-states(1:3))*(C_e(:,:,i)*sat_pos(:,i)-states(1:3)));
        C_e(:,:,i)=[1,((omega_ie* sat_antenna_range(:,i))/c),0;(-(omega_ie* sat_antenna_range(:,i))/c),1,0;0,0,1];
    end
end

end