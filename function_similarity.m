function similarity = function_similarity(I,E,num_usr,b_weight)
    similarity = zeros(1,num_usr);
    test = E;

        

    for i = 1:num_usr
        num_discord = 0;
        compared = I(i,:);
        v_c = find(compared >0);
        v_t = find(test > 0);
        % 求交集 
        intersection_subset = intersect(v_c,v_t);
        num_itersection = length(intersection_subset);
        % 求并集数目
        num_union = length(v_c) + length(v_t) - num_itersection;
        % 计算weight
        weight = num_itersection/num_union;
        if isnan(weight)
            weight = 0;
        end
        % 计算sim(u,v)       
        for m = 1:num_itersection
            vm = intersection_subset(m);
            for n = (m+1):num_itersection         
                vn = intersection_subset(n);
                sgn1 = sign(test(vm) - test(vn));
                sgn2 = sign(compared(vm)- compared(vn));
                temp = sgn1*sgn2;
                if temp <0
                    num_discord = num_discord+1;
                end       
            end
        end
        sim = 1 - 4*num_discord/(num_itersection*(num_itersection - 1));
        if isnan(sim)
            similarity(i) = 0;
        else
            if b_weight == true
                similarity(i) = weight*sim;
            else
                similarity(i) = sim;
            end
        end
    end
end
