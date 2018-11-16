function Error = KnnClassify (Data_Tr,  Label_Tr, Data_T, Label_T)
K =1;
% Evaluate the performances of the classifier (Linear or Quadratic) by
% comparing for each element of the testing data set the label decision 
% (Label) to its true label (Label_T). Return the ROC curve 
%
% Input     Data_Tr             Training data set without the labels
%           Data_T              Testing data set without the labels
%           K                   Number of Nearest Neighbors
% Output    Ind_Min_EuclDist    Indices of the K Nearest Neighbors for each
%                               element of the testing data set

% Allocation of variables

Npt_T = size(Data_T, 1);
Ind_Min_EuclDist = zeros(K, Npt_T);
Rate = zeros(Npt_T, 1);

% Computation of the distances for each element of the testing set to all
% the elements of the training set

EuclDist = pdist2(Data_Tr, Data_T);

% Iteratively, research the Nearest Neighbor of the training set for each element of the
% testing set, store its indice and remove the value to avoir doubles

for i1 = 1 : K
    
    [~ , Ind_Min_EuclDist(i1, :)] = min(EuclDist);
    
    for i2 = 1 : Npt_T
        
        EuclDist(Ind_Min_EuclDist(i1, i2), i2) = NaN;
        
    end
end



% Assignement of the labels

for i1 = 1 : Npt_T
    
    % Determination of the rate of correct matches between the K Nearest
    % Neighbors and the True labels of the training set
    
 
        
       if ( Label_Tr(Ind_Min_EuclDist(1, i1)) == 1)
           
           Rate(i1, 1) =  1;
       else
           Rate(i1, 1) = - 1;
       end
        
    
    
    
end

ConfusionM = confusionmat(Label_T, Rate);

Accuracy = sum(diag(ConfusionM))/sum(sum(ConfusionM));

Error = 1 - Accuracy;

end

