function [b_wkrcc,b_preference_sign,b_higher_weight,b_greedy] = load_config(flag)
	
    if flag == "cloud_rank_1"
        b_wkrcc = false;
        b_preference_sign = false;
        b_higher_weight = false;
        b_greedy = false;
    end
    if flag == "cloud_rank_2"
        b_wkrcc = false;
        b_preference_sign = false;
        b_higher_weight = true;
        b_greedy = false;
    end
    if flag == "ours"
        b_wkrcc = true;
        b_preference_sign = true;
        b_higher_weight = false;
        b_greedy = false;
    end
end