function [ y ] = test( A )
Db = load ('hw1data.mat');
Db = Db.Bdata;

featureset = [ 1     2     3     7     9  ];
DB_train = Db(:, featureset);
A_valid = A(:, featureset);

SVM_Opt = optimset('maxiter', 1000000);

SVM_valid = svmtrain(DB_train,  Db(:,end),'boxconstraint',2.4,'kernel_function', 'polynomial', 'polyorder',2,'kktviolationlevel', 0.1,'quadprog_opts',SVM_Opt);
y = svmclassify (SVM_valid, A_valid);
end

