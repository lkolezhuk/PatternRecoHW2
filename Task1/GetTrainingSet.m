function [train_pos, train_neg, test_pos, test_neg, prob_pos] = GetTrainingSet(set_size, data)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
        
    data_pos = data(find(data(:,11) == 1),:);
    data_neg = data(find(data(:,11) == -1),:);
    
    coef = size(data_pos,1) / size(data,1);
    
    indexes_pos = randperm(size(data_pos, 1), round(set_size * coef));
    train_pos = data_pos(indexes_pos,:);
    k = setdiff(1:length(data_pos), indexes_pos);
    test_pos = data_pos(k,:);
    
    indexes_neg = randperm(size(data_neg, 1), set_size - round(set_size * coef));
    train_neg = data_neg(indexes_neg,:);
    kn = setdiff(1:length(data_neg), indexes_neg);
    test_neg = data_neg(kn, :);
    prob_pos = coef;
    
end

