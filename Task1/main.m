close all;
clear all;
clc;

DATA_RAW = load('hw1data.mat');
DATA = DATA_RAW.Bdata;  
% training_set_percentage = 75;
% [training_set_pos, training_set_neg, test_set_pos, test_set_neg, prob_pos] = GetTrainingSet(training_set_percentage * length(DATA) /100, DATA);
% 
% training_set = [training_set_pos; training_set_pos];
[training_set test_set] = SetSplit2(DATA, 0.75);

% ClassifyKNN(DATA(1:4000,1:10), DATA(1:4000,11), DATA(4001:8000,1:10), DATA(4001:8000,11));
% mod = sequentialfs(@KnnClassify, DATA(:,1:10), DATA(:,11),'nfeatures',3);

% training_sequential_set = training_set(:,mod);


[alt_training_set alt_validation_set alt_test_set] = SetSplit3(DATA, 0.4, 0.4, 0.2); 
% for i=1:100
 alt_seq = sequentialfs(@KnnClassify, alt_training_set(:,1:end-1), alt_training_set(:,end),'nfeatures',5);
%  disp(alt_seq);
% end
% alt_seq = [1 2 3 7 9]; %most common result for feature selection in case of 5 features
Auc_Max = 0;
Auc_Max_i = 0;
% for i=1:10
%     disp(i);
%     SVM_Opt = optimset('maxiter', 1000000);
%     SVMStruct = svmtrain(alt_training_set(:, alt_seq), alt_training_set(:, end), 'boxconstraint', i, 'kernel_function', 'polynomial' ,'polyorder', 2, 'kktviolationlevel', 0.1, 'quadprog_opts', SVM_Opt);
% 
%     Gr = svmclassify(SVMStruct, alt_validation_set(:,alt_seq));
% 
%     [Roc, Auc(i)] = EvalRoc([Gr alt_validation_set(:,end)], 1, -1);
%     if(Auc(i)>Auc_Max) 
%             Auc_Max = Auc(i);
%             Auc_Max_i = i;
%     end
%         
%     disp(Auc(i));
% end
SVM_Opt = optimset('maxiter', 1000000);
SVMStruct = svmtrain(alt_training_set(:, alt_seq), alt_training_set(:, end), 'boxconstraint', 1, 'kernel_function', 'polynomial' ,'polyorder', 2, 'kktviolationlevel', 0.1, 'quadprog_opts', SVM_Opt);

Gr2 = svmclassify(SVMStruct, alt_test_set(:,alt_seq));

[Roc, Auc_fin] = EvalRoc([Gr2 alt_test_set(:,end)], 1, -1);
disp('Final AUC');
disp(Auc_fin);

