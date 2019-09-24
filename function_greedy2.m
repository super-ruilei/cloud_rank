function rec_ind = function_greedy2(preference,n)
   %% greedy2
    rec_ind = zeros(n,1);
    for i = 1:n
        temp = sum((preference==1),2);
        [~,rec] = max(temp);
        rec_ind(i) = rec;
        preference(:,rec) = 0;
        preference(rec,:) = 0;   
    end
  
end