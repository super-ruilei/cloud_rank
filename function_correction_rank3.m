function new_rec_ind2 = function_correction_rank3(test,rec_ind)
    %% correction rank 2
    %% 思想如下 将better的已存在qos值的排序放入rec_ind
    [test_val,test_ind] = sort(test,'descend');
    exist_order = test_ind(find(test_val>0));
    new_rec_ind = test_interpolation(rec_ind,exist_order);  
    new_rec_ind2 = test_replace(new_rec_ind,exist_order);
  
end


