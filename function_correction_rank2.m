function new_rec_ind = function_correction_rank2(test,rec_ind)
    %% correction rank 2
    %% ˼������ ��better���Ѵ���qosֵ���������rec_ind
    [test_val,test_ind] = sort(test,'descend');
    exist_order = test_ind(find(test_val>0));
    new_rec_ind = test_interpolation(rec_ind,exist_order);
  
end


