clc;
close all;
clear all;
rng('default');

%% step1. load groundtruth data
tpMatrix = load('./tpMatrix');
% usermatrix = load('/Users/rui/PycharmProjects/webservice-core/dataset2/tpMatrix');

%% step2. form sparse data with sparse_rate
[num_usr,num_service] = size(tpMatrix);
sparse_rate = [0.1 0.3 0.5 1.0];

sparse_num = round(sparse_rate * num_service);
k = sparse_num(1);

sparse_matrix = zeros([num_usr,num_service]) - 1;

for i = 1:num_usr
    p = randperm(num_service,k);
    sparse_matrix(i,p) = tpMatrix(i,p);
end

%% step3. split train and test
num_train = 299;
num_test = 1;
test = sparse_matrix(1:num_test,:);%%pick top num_test user as test user
train = sparse_matrix(num_test+1:end,:);
gt_test = tpMatrix(1:num_test,:);


%% step4. call different service rank function(in: sparse data; out:rank)

[b_wkrcc,b_preference_sign,b_higher_weight,b_greedy] = load_config('cloud_rank_1');
similarity = function_similarity(sparse_matrix,test,num_usr,b_wkrcc);
preference = function_preference(sparse_matrix,test,similarity,num_service,b_preference_sign,b_higher_weight);


%% step5. sort preference

[~,gt] = sort(gt_test,'descend');
b_greedy = false;
if b_greedy
    ind_d = function_greedy(preference,100);
    %ind_d = function_greedy2(preference,100);  
else
    [~,ind_d] = sort(sum(preference,2),'descend');
end
b_corr_ind = false;
if b_corr_ind
      ind_d = function_correction_rank(test,ind_d);
%     ind_d = function_correction_rank2(test,ind_d);
%     ind_d = function_correction_rank3(test,ind_d);
end

%% step6. calculate ndcg precision and recall
recall_cloudrank = length(intersect(gt(1:100)',ind_d(1:100)))
ndcg_cloudrank = function_ndcg(gt(1:100)',ind_d(1:100))




