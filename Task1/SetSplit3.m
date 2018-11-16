function [Data_Tr, Data_Val, Data_T] = SetSplit3 (Data, Ratio_Tr, Ratio_Val, Ratio_T)

Data_Cl1 = [];
Data_Cl2 = [];

Data_Tr_Cl1 = [];
Data_Tr_Cl2 = [];
Data_Val_Cl1 = [];
Data_Val_Cl2 = [];

% 

NPt_Data = size(Data, 1);

for i1 = 1 : NPt_Data
    
    if Data(i1, end) == 1
        Data_Cl1 = [Data_Cl1; Data(i1, :)];
    else
        Data_Cl2 = [Data_Cl2; Data(i1, 1 : end - 1), -1];
    end
    
end

Npt_Data_Cl1 = size(Data_Cl1, 1);
Npt_Data_Cl2 = size(Data_Cl2, 1);


for i1 = 1 : round(Ratio_Tr * Npt_Data_Cl1)

Ind = round(1 + (size(Data_Cl1, 1) -1) * rand);
Data_Tr_Cl1 = [Data_Tr_Cl1; Data_Cl1(Ind, :)];
Data_Cl1(Ind, :) = [];

end

for i1 = 1 : round(Ratio_Val * Npt_Data_Cl1)

Ind = round(1 + (size(Data_Cl1, 1) -1) * rand);
Data_Val_Cl1 = [Data_Val_Cl1; Data_Cl1(Ind, :)];
Data_Cl1(Ind, :) = [];

end

Data_T_Cl1 = Data_Cl1;


for i1 = 1 : round(Ratio_Tr * Npt_Data_Cl2)

Ind = round(1 + (size(Data_Cl2, 1) -1) * rand);
Data_Tr_Cl2 = [Data_Tr_Cl2; Data_Cl2(Ind, :)];
Data_Cl2(Ind, :) = [];

end

for i1 = 1 : round(Ratio_Val * Npt_Data_Cl2)

Ind = round( 1 + (size(Data_Cl2, 1) -1) * rand);
Data_Val_Cl2 = [Data_Val_Cl2; Data_Cl2(Ind, :)];
Data_Cl2(Ind, :) = [];

end

Data_T_Cl2 = Data_Cl2;


Data_Tr = [Data_Tr_Cl1; Data_Tr_Cl2];
Data_Val = [Data_Val_Cl1; Data_Val_Cl2];
Data_T = [Data_T_Cl1; Data_T_Cl2];

end