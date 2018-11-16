function [Data_Tr, Data_T] = SetSplit2 (Data, Rate)

% Divide the initial data (Data) set in a training (Data_Tr) and a testing
% data set (Testing_T) regarding the given ratio (Rate)
%
% Input     Data        Initial data set
%           Rate        Ratio of repartition of the training data set
% Ouput     Data_Tr     Training data set
%           Data_T      Testing data set

% Assignment of each element of the initial data set depending of their
% label

Data_Cl1 = Data(find(Data(:, end) == 1), :);
Data_Cl2 = Data(find(Data(:, end) == -1), :);

[~ , Npt_Features] = size(Data);

Npt_Cl1 = size(Data_Cl1, 1);
Npt_Cl2 = size(Data_Cl2, 1);

% Determination of the number of element of each class for each of the
% training and testing data set

Npt_Tr1 = round(Rate * Npt_Cl1); 
Npt_T1 = Npt_Cl1 - Npt_Tr1;

Npt_Tr2 = round(Rate * Npt_Cl2); 
Npt_T2 = Npt_Cl2 - Npt_Tr2;

% Allocation of variables

Data_Tr_Cl1 = zeros(Npt_Tr1, Npt_Features);
Data_Tr_Cl2 = zeros(Npt_Tr2, Npt_Features);

% Random assignment of element of the classes (Data Cl1)(Data Cl2) to the 
% training data set.
% When an element is assigned to the training data set, it is removed from
% its class.
% At the end, the remaining elements in the classes will compose the
% testing data set

for i1 = 1 : Npt_Tr1

Ind = round(1 + (Npt_Cl1 - 1 - i1) * rand);

Data_Tr_Cl1(i1, :) = Data_Cl1(Ind, :); 
Data_Cl1(Ind, :) = [];

end

for i1 = 1 : Npt_Tr2

Ind = round(1 + (Npt_Cl2 - 1 - i1) * rand);

Data_Tr_Cl2(i1, :) = Data_Cl2(Ind, :); 
Data_Cl2(Ind, :) = [];

end

Data_Tr = [Data_Tr_Cl1; Data_Tr_Cl2];
Data_T = [Data_Cl1; Data_Cl2];

end