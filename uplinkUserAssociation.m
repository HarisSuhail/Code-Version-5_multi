function [uplink_BS_associated, uplink_nU_BS_0, uplink_nU_BS_1, uplink_nU_BS_2, association_matrix_uplink, Pr_dB, max_power_db ] = uplinkUserAssociation(L_dB,Pt_dB, U, nU, nBS_0, nBS_1, nBS_2, BSType, BSLocation, blocking_prob,bias0, bias1, bias2)

Ux = (U(:, 1));
Uy = (U(:, 2));

BSx = BSLocation(:, 1);
BSy = BSLocation(:, 2);

uplink_nU_BS_0 = 0;
uplink_nU_BS_1 = 0;
uplink_nU_BS_2 = 0;

association_matrix_uplink = zeros(length(Ux), length(BSx));
d = zeros([nBS_0+nBS_1+nBS_2 , nU]);
Pr_dB = zeros([nBS_0+nBS_1+nBS_2 ,nU]);


  
  
for i = 1:length(BSx)
    Pr_dB(i, :) = Pt_dB(1, :) - transpose(L_dB(:, i));
    Pr_dB(i, :) = Pr_dB(i, :) + getUplinkAntennaGain(BSType(i), 1);
end

max_power_db = [];
uplink_BS_associated = [];
user_per_tier = [0 0 0]; %index of array -> tier.    value of index -> users associated with that tier
bias_array = [getBiasFactorUplink(0,bias0, bias1, bias2).*ones([1 nBS_0])  getBiasFactorUplink(1,bias0, bias1, bias2).*ones([1 nBS_1])   getBiasFactorUplink(2,bias0, bias1, bias2).*ones([1 nBS_2])];

for i = 1:nU
    [max_power_db(i), uplink_BS_associated(i)] = max(transpose(Pr_dB(:, i)) + bias_array);
    max_power_db(i) = max_power_db(i) - getBiasFactorUplink(BSType(uplink_BS_associated(i)),bias0, bias1, bias2);
    association_matrix_uplink(i, uplink_BS_associated(i)) = 1;
    user_per_tier(1+getTier( uplink_BS_associated(i), nBS_0, nBS_1, nBS_2 )) = user_per_tier(1+getTier( uplink_BS_associated(i), nBS_0, nBS_1, nBS_2 )) + 1;
end

uplink_nU_BS_0 = user_per_tier(1);
uplink_nU_BS_1 = user_per_tier(2);
uplink_nU_BS_2 = user_per_tier(3);

end