function [d_innov]=getInnovation(pr_data,prr_data,t,sat_antenna_range_rate,sat_antenna_range,states,time)
%% This function will calculate delta innovation matrix

%%extract pseudorange and pseudorangerate from CSV data
pseudoranges=pr_data(2:end,2:end);
pseudorangerates=prr_data(2:end,2:end);


%%find current time epoch
i=find(time==t);

%%calculate delta innovation matrix at current epoch
d_innov=[transpose(pseudoranges(i,:)-sat_antenna_range-states(7));
             transpose(pseudorangerates(i,:)-sat_antenna_range_rate-states(8))];


end