% Thesis - Matty Vermet
% data macaronesia

% load data
close all
load dataset.mat
parameters = sortrows(dataset, 'age', 'ascend');

% change Gran Canaria from 15 to 15.1 because there are two datapoints with
% same age, which cause errors in analysis
parameters.age(21) = 15.1;

% process data 
ages = parameters.age;
rugg = parameters.ruggedness;
elev = parameters.elevation;
area = parameters.area;
rel_age = parameters.relativeage1;
islands = parameters.island;

azores = table(ages(parameters.archipelago ==  'Azores'), 'VariableNames', {'age'});
azores.ruggedness = rugg(parameters.archipelago ==  'Azores');
azores.elevation = elev(parameters.archipelago == 'Azores');
azores.area = area(parameters.archipelago == 'Azores');
azores.rel_age = rel_age(parameters.archipelago == 'Azores');
azores.islands = islands(parameters.archipelago == 'Azores');

canary = table(ages(parameters.archipelago ==  'Canary Islands'), 'VariableNames', {'age'});
canary.ruggedness = rugg(parameters.archipelago ==  'Canary Islands');
canary.elevation = elev(parameters.archipelago == 'Canary Islands');
canary.area = area(parameters.archipelago == 'Canary Islands');
canary.rel_age = rel_age(parameters.archipelago == 'Canary Islands');
canary.islands = islands(parameters.archipelago == 'Canary Islands');

madeira = table(ages(parameters.archipelago ==  'Madeira'), 'VariableNames', {'age'});
madeira.ruggedness = rugg(parameters.archipelago ==  'Madeira');
madeira.elevation = elev(parameters.archipelago == 'Madeira');
madeira.area = area(parameters.archipelago == 'Madeira');
madeira.rel_age = rel_age(parameters.archipelago == 'Madeira');
madeira.islands = islands(parameters.archipelago == 'Madeira');

capeverde = table(ages(parameters.archipelago ==  'Cape Verde'), 'VariableNames', {'age'});
capeverde.ruggedness = rugg(parameters.archipelago ==  'Cape Verde');
capeverde.elevation = elev(parameters.archipelago == 'Cape Verde');
capeverde.area = area(parameters.archipelago == 'Cape Verde');
capeverde.rel_age = rel_age(parameters.archipelago == 'Cape Verde');
capeverde.islands = islands(parameters.archipelago == 'Cape Verde');

%% Combined plot - quadratic relation
% relative age against topographic complexity

% determine colors for plot
c_yellow = [0.9290, 0.6940, 0.1250];
c_blue = [0 0.4470 0.7410];
c_red = [0.6350 0.0780 0.1840];
c_green = [0.4660 0.6740 0.1880];
c_purp = [0.4940 0.1840 0.5560];

% create table of macaronesia with combined data 
macaron(:,1) = [azores.rel_age; canary.rel_age; madeira.rel_age; capeverde.rel_age];
macaron(:,2) = [azores.ruggedness; canary.ruggedness; madeira.ruggedness; capeverde.ruggedness];
macaronesia = table(macaron(:,1),macaron(:,2));
macaronesia = sortrows(macaronesia,'Var1','ascend')

% plot islands of azores, canary, capeverde, madeira in scatter
% create 2nd polynomial fit lines through data points
figure 
scatter(azores.rel_age, azores.ruggedness, [], c_blue)
hold on 
p_azores = polyfit(azores.rel_age, azores.ruggedness, 2);
y_azores = polyval(p_azores, azores.rel_age)
plot(azores.rel_age, y_azores, 'Color', c_blue, 'Linestyle', ':')

hold on
scatter(canary.rel_age, canary.ruggedness,[], c_green)
p_canary = polyfit(canary.rel_age, canary.ruggedness, 2);
y_canary = polyval(p_canary, canary.rel_age)
plot(canary.rel_age, y_canary, 'Color', c_green, 'Linestyle', '--')

hold on 
scatter(capeverde.rel_age, capeverde.ruggedness, [], c_yellow)
p_capeverde = polyfit(capeverde.rel_age, capeverde.ruggedness, 2);
y_capeverde = polyval(p_capeverde, capeverde.rel_age)
plot(capeverde.rel_age, y_capeverde, 'Color', c_yellow, 'Linestyle', '--')

hold on 
scatter(madeira.rel_age, madeira.ruggedness, [], c_purp)
p_madeira = polyfit(madeira.rel_age, madeira.ruggedness, 2);
y_madeira = polyval(p_madeira, madeira.rel_age)
plot(madeira.rel_age, y_madeira, 'Color', c_purp, 'Linestyle', '-.')

% add overall 2nd polynomial fit line in graph
hold on 
p_maca = polyfit(table2array(macaronesia(:,1)), table2array(macaronesia(:,2)), 2)
x1_maca = table2array(macaronesia(:,1));
y1_maca = polyval(p_maca,x1_maca);
plot(x1_maca, y1_maca, 'Color', c_red, 'LineWidth', 2)

% create lables and legend
ylabel('topographic complexity')
xlabel('relative age (my)')
legend('Azores', ' ', 'Canary islands', '', 'Cape verde', '', 'Madeira', '' , 'Quadratic fit')

% call function to create linear regression model
statistical_test(parameters)

%% Results 
% when running this part, functions in different m-files are activated
% containing the calculation for the results
close all

Azores_results(azores)
Canary_results(canary)
Madeira_results(madeira)
CapeVerde_results(capeverde)


