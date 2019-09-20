clear;
%% Question 1
X = [1, 1.5, 3:5, 7, 9, 10]; 
% Note the sub-vector initialization inside []
Y1 = -2 + .5*X;
Y2 = -2 + .5*X.^2;

plot(X,Y1,'--',X,Y2,'-'); 
% note line settings
legend('Y1','Y2','Location','NW');
% label axises
xlabel('X');
ylabel('Y');

% save picture
saveas(gca, 'pic_ha_1.eps','epsc');
%% Question 2
X = -10:(20+10)/199:20;

% alternative to the previous command
X = linspace(-10,20,200);
fprintf('Sum of vector elements is %13.25f\n',sum(X))

% note, there is no numerical error of summation of small numbers.

%% Question 3
A = [2 4 6; 1 7 5; 3 12 4];
b = [-2; 3; 10];
C = A'*b
D = (A'*A)\b
E = sum(b'*A)
F = A([1,3],1:2)
x = A\b

%% Question 4
B = kron(eye(5),A)

%% Question 5
A = random('norm',10,5,5,3)
A = A>=10
% note that matlab random number generator parameters are mean and standard
% deviation. 
%% Question 6
% import data as table
dat = readtable('datahw1.csv','ReadVariableNames',false);
%% Question 6 (cont)
% alternatively, one can import as matrix
M = csvread('datahw1.csv');
%%
% give variables names
dat.Properties.VariableNames = {'firm_id','year','Export','RD','prod','cap'};
% create deletion index to remove observations with NaNs
del_ind = sum(isnan(dat{:,:}),2);
% delete rows with NaNs 
dat(del_ind>0,:) = [];

% estimate linear model by matlab econometrics toolbox (it will
% automatically ignore NaNs, but you should inspect data for it anyway)
lm1 = fitlm(dat,'prod~Export+RD+cap');
% display all the statistics of estimation 
lm1

% or display only coefficients and standard errors
fprintf('beta \t\t SE \n');
fprintf('%f \t %f \n', lm1.Coefficients.Estimate, lm1.Coefficients.SE);


% or use old-school estimation method
X = [ones(height(dat),1) dat.Export dat.RD dat.cap];
b = (X'*X)\X'*dat.prod
