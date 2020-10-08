% ........................................................................

% My template Matlab codes for Linear Regression with single/multiple variables
% Toolbox: Statistics and Machine Learning
% LinearRegressionAutoToolbox.m
% Navid Salami Pargoo
% 2020

% ........................................................................

% Clear memory 
clear;

% Load the dataset into variables X and y
data = readtable ('data1n.txt');   % read tabular data into a table
data.Properties.VariableNames = {'Variable1', 'Variable2', 'Outputs'}; % name the variables: one for each features+one for outputs
summary (data)

% Print out first 10 examples from the dataset
disp('First 10 eamples from the dataset are:');
disp(data(1:10,:));

m = size(data,1); % # of training sets
n = size(data,2)-1; % # of features


% ========================= 2D/3D plot of input data ==========================

if n == 1
    figure;
    plot(data.Variable1, data.Outputs, 'rx', 'MarkerSize', 10); % Plot the data
    xlabel('???variable???'); % Set the x-axis label
    ylabel('???output???'); % Set the y-axis label
    
elseif n == 2
    figure;
    scatter3(data.Variable1, data.Variable2, data.Outputs);
    xlabel('???variable1???'); % Set the x-axis label
    ylabel('???variable2???'); % Set the y-axis label
    zlabel('???output???'); % Set the z-axis label
else
    disp('The dimension of model is greater than 3 => Not possible to be plotted on screen');
end

% ============================================================================

% =============== Fit a linear model using the fitlm function ================

linMdl = fitlm(data);

% Display the coefficient of the linear model
disp('The coefficients of the linear model are:');
disp(linMdl.Coefficients);

theta = linMdl.Coefficients.Estimate;
% Display theta of the linear model
disp('The theta of the linear model are:');
disp(theta);

% ============================================================================

% Estimate (predict) the result of a certain set of inputs
x = zeros(1, n);   % Replace this matrix with the parameters of prediction
prediction = predict(linMdl, x);
disp('Predicted OUTPUT of the set of example x is:');
disp(prediction);    

% ======================== 2D/3D plot of linear fit ==========================

if n == 1
    
    figure;
    plot(data.Variable1, data.Outputs, 'rx', 'MarkerSize', 10); % Plot the data
    hold on;
    output = predict(linMdl, data);
    plot(data.Variable1, output, '-'); % Plot the data
    legend('Training data', 'Linear regression');
    hold off; 
    xlabel('???variable???'); % Set the x-axis label
    ylabel('???output???'); % Set the y-axis label
    
elseif n == 2
    
    figure;
    scatter3(data.Variable1, data.Variable2, data.Outputs);
    hold on;
    
    for i = 1:m
        for j = 1:m
            output(i,j) = predict(linMdl, [data.Variable1(i) data.Variable2(j)]);
        end
    end
    output = output';
    surf(data.Variable1, data.Variable2, output)
    legend('Training data', 'Linear regression'); 
    hold off 
    colorbar 
    xlabel('???variable1???'); % Set the x-axis label
    ylabel('???variable2???'); % Set the y-axis label
    zlabel('???output???'); % Set the z-axis label
    
else
    disp('The dimensions of model and cost function are both greater than 3 => Not possible to be plotted on screen');
end

% ============================================================================




