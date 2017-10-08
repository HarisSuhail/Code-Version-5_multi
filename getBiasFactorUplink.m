function [bias_factor_db] = getBiasFactorUplink(tier, b0, b1, b2)
%This function returns the biasing factor for the concerned tier




if tier == 0
    bias_factor_db = b0;  %No biasing for UHF macrocell
elseif tier == 1
    bias_factor_db =  b1 ; %mmWave small cell biased by 20dB
elseif tier == 2
    bias_factor_db= b2;    %uhf small cell bias factor
end
end