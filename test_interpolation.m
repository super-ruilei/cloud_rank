function abackup = test_interpolation(a,b)
% a = [1,9,5,7,6,10];%predict
% b = [11,8,10,4,5,12];%real order
new_a = test_replace(a,b);
[val,i_a,i_b] = intersect(new_a,b);

aplus = [];
j = 0;
for i = 1:length(b)
    if ~ismember(b(i),a) && i<max(i_b)
        j = j + 1;
        aplus(j) = b(i);      
    end
end
num_minus = floor(length(aplus)/2);

aminus = fliplr(new_a);
j = 0;
for i = 1:length(new_a)
    if ~ismember(aminus(i),b)
        aminus(i) = -1;
        j = j + 1;
    end
    if j == num_minus
        break;
    end
end
aminus(aminus==-1) = [];
aminus = fliplr(aminus);
% abackup = aminus;
abackup = [aminus,aplus(1:num_minus)];

% [vv,ii_am,ii_gt] = intersect(aminus,b);
% ii_am = sort(ii_am);
% for i = 1:length(vv)
%     temp_now = aminus(ii_am(i));
%     
%     j = 1;
%     tempadd = aplus(j);
%     while find(b==11)
%    
%  
% end

% Ô¤¼ÆÊä³ö gt = [11,8,10,4,5,12]
% + [11 8 4]  - [9 7 6] 
% a = [1,9,5,7,6,10]
% new_a = [1,9,10,7,6,5]
% a_ = [1,10,5]
% a+ = [11,8,4] + [1,10,5] 
% predict_a = [1, 11, 8, 10, 4, 5] 
