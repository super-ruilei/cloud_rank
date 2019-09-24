function  [re_predict_order]= test_replace(predict,real)

[val,~,i_b] = intersect(predict,real);

[~,iib]=sort(i_b);
real_order = val(iib);

re_predict_order = predict;

%subset order
j = 0;
for i = 1:length(predict)
    if ismember(predict(i),val)
        j=j+1;
        re_predict_order(i) = real_order(j); 
    end
end
