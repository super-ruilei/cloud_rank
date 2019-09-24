function phi = function_preference(qos,E,similarity,num_service,b_sign,b_higher_weight)
    top_t = 60;
    test = E;

    phi = repmat(test,num_service,1)' - repmat(test,num_service,1);
    non_value = find(test==-1);
    phi(non_value,:) = 0;
    phi(:,non_value) = 0;%%clear value for  equation  (5.2)

    % find top t users as the neighbors for the target user
    [sim_,ind] = sort(similarity(1:end),'descend');
    neighbor_list = ind(2:(top_t + 1));
    sim_ = sim_(2:(top_t + 1));
    
    %normalize similarity
    sim_norm = sim_/(sum(sim_));
    
    total_neighbor = zeros(num_service,num_service);
    for jj = 1:length(neighbor_list)   
        
        k_nn = neighbor_list(jj);
        if b_higher_weight
            weight = sim_(jj)*sim_norm(jj);
        else
            weight = sim_norm(jj);
        end
        k_nn_matrix = qos(k_nn,:);

        neighbor_preference = repmat(k_nn_matrix,num_service,1)' - repmat(k_nn_matrix,num_service,1);
        non_value = find(k_nn_matrix==-1);
        neighbor_preference(non_value,:) = 0;
        neighbor_preference(:,non_value) = 0;
        if b_sign  
            neighbor_preference = sign(neighbor_preference);
        end
        %weight = 1;
        total_neighbor = total_neighbor + weight*neighbor_preference;
    end
    n_label = (phi == 0);
    phi = sign(phi) + sign(n_label.*total_neighbor);%equation 5.2    
end