% This script will train a RBFN for modelling Rossler chaotic system

% number of training, validation, and test data
num_train = 5000;
num_valid = 3000;
num_test = 2000;
num_discard = 10000;
num = num_discard+num_train+num_valid+num_test;

% Use a time step of 0.01 when solving the
% Rossler system of equations
dt = 0.01;

% Time values for training, validation, test
% data - for potential use in plotting
train_t = dt:dt:num_train*dt;
valid_t = dt:dt:num_valid*dt;
test_t = dt:dt:num_test*dt;
t = dt:dt:num*dt;

% Initial values for the system
x = 0;
y = 0;
z = 0;

% Create two empty time series lists.
% One will be for the inputs, one will
% be for the targets
time_series = zeros(3, num);
time_series_targets = zeros(3, num);

% Generate 20000 points of time series data.
% Also fill out 20000 points of time series
% that are offset by 1 (these are the targets).
for i = 1:num
    time_series(:, i) = [x;y;z];
    [x,y,z] = next_rossler(x, y, z, dt);
    time_series_targets(:, i) = [x;y;z];
end

% Plot the full time series data to view attractor.
%scatter3(time_series(1,:), time_series(2,:), time_series(3,:),'filled');
%%
% Disregard first 10000 data points to reduce effect of transition
time_series_sub = time_series(:, num_discard+1:num);
time_series_targets_sub = time_series_targets(:, num_discard+1:num);

% Take the first 5000 remaining data points for training
train_data = time_series_sub(:, 1:num_train);
train_targets = time_series_targets_sub(:, 1:num_train);
% Take the next 3000 remaining data points for validation
valid_data = time_series_sub(:, num_train+1:num_train+num_valid);
valid_targets = time_series_targets_sub(:, num_train+1:num_train+num_valid);
% Take the last 2000 remaining data points for testing
test_data = time_series_sub(:, num_train+num_valid+1:num_train+num_valid+num_test);
test_targets = time_series_targets_sub(:, num_train+num_valid+1:num_train+num_valid+num_test);

% In order to find the best spread, multiple networks will
% be trained, and their performances checked against 
% validation data. A spread, and mse that is known to not be
% the best are set as the initial best spread, and minimum mse
min_mse = 30;
best_spread = 0.5;
% Spreads of 1, 3, ... 100, will be examined
spread_list = 1:2:150;
mse_list = zeros(1, 75);

for i = 1:75
    spread = spread_list(i);
    disp(spread);
    
    % Train a rbfn with the goal of acheiving 1e-8
    % performance, using the spread that is currently
    % being tested.
    goal = 1e-06;
    rbf_net = newrb(train_data,train_targets,goal,spread,50,100);

    % Generate predictions based on validation data
    predictions = zeros(3, num_valid);
    for j = 1:num_test
        predictions(:, j) = sim(rbf_net, valid_data(:, j));
    end
    
    % Calculate mean squared error and add to list
    error = valid_targets - predictions;
    squared_error = error.^2;
    rbfn_mse = mean(mean(squared_error));
    %rbfn_mse = mse(rbf_net, valid_targets, predictions);
    mse_list(i) = rbfn_mse;
    
    % Update best spread if current mse is less than 
    % best mse up to this point. Save current network.
    if rbfn_mse < min_mse
        min_mse = rbfn_mse;
        best_net = rbf_net;
        best_spread = spread;
    end
end
%%
% Train new network based on best spread
rbf_net = newrb(train_data, train_targets, goal, best_spread, 250, 1);

% Use the best found network to generate predictions
% based on test data.
test_predictions = zeros(3, num_test);
for i = 1:num_test
    test_predictions(:, i) = sim(rbf_net, test_data(:, i));
end

% Calculate prediction errors and mse
error_x = test_targets(1,:) - test_predictions(1,:);
error_y = test_targets(2,:) - test_predictions(2,:);
error_z = test_targets(3,:) - test_predictions(3,:);
error = test_targets - test_predictions;
squared_error = error.^2;
rbfn_mse = mean(mean(squared_error));
%test_mse = mse(best_net, test_targets, test_predictions);

% Plot the mse of the network vs the spread
figure;
plot(spread_list, mse_list)
title('Test MSE vs Spread');
xlabel('spread');
ylabel('MSE');

% Plot actual test outputs
figure;
scatter3(test_targets(1,:), test_targets(2,:), test_targets(3,:),'filled');
title('Actual');
xlabel('x');
ylabel('y');
zlabel('z');

% Plot predicted test outputs
figure;
scatter3(test_predictions(1,:), test_predictions(2,:), test_predictions(3,:),'filled');
title('Predicted');
xlabel('x');
ylabel('y');
zlabel('z');
%%
% Plot predicted and actual x outputs on same plot
figure;
plot(test_t, test_predictions(1,:), test_t, test_targets(1,:));
title('Predicted vs Actual - x');
xlabel('t');
ylabel('x');
legend('predictions', 'actual');

% Plot error between predicted and actual x outputs
figure;
plot(test_t, error_x);
title('Error - x');
xlabel('t');
ylabel('error');

% Plot predicted and actual y outputs on same plot
figure;
plot(test_t, test_predictions(2,:), test_t, test_targets(2,:));
title('Predicted vs Actual - y');
xlabel('t');
ylabel('y');
legend('predictions', 'actual');

% Plot error between predicted and actual y outputs
figure;
plot(test_t, error_y);
title('Error - y');
xlabel('t');
ylabel('error');

% Plot predicted and actual z outputs on same plot
figure;
plot(test_t, test_predictions(3,:), test_t, test_targets(3,:));
title('Predicted vs Actual - z');
xlabel('t');
ylabel('z');
legend('predictions', 'actual');

% Plot error between predicted and actual z outputs
figure;
plot(test_t, error_z);
title('Error - z');
xlabel('t');
ylabel('error');

% Predict the next 120 data points
future_predictions = zeros(3, num_test);
input = test_data(:, 1);
for i = 1:num_test
    future_predictions(:, i) = sim(rbf_net, input);
    input = future_predictions(:, i);
end

% Calculate MSE on predictions
error = test_targets - future_predictions;
squared_error = error.^2;
rbfn_mse_2000 = mean(mean(squared_error));

% Plot actual next 2000 vs predicted - x
figure;
plot(test_t, future_predictions(1,:), test_t, test_targets(1,:));
title('Predicted vs Actual (2000 data points) - X');
xlabel('t');
ylabel('x');
legend('predictions', 'actual');

% Plot actual next 2000 vs predicted - y
figure;
plot(test_t, future_predictions(2,:), test_t, test_targets(2,:));
title('Predicted vs Actual (2000 data points) - Y');
xlabel('t');
ylabel('y');
legend('predictions', 'actual');

% Plot actual next 2000 vs predicted - z
figure;
plot(test_t, future_predictions(3,:), test_t, test_targets(3,:));
title('Predicted vs Actual (2000 data points) - Z');
xlabel('t');
ylabel('z');
legend('predictions', 'actual');