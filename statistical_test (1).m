%% Statistical analysis - topographic complexity and age
function f = statistics(parameters)

mod1 = fitlm(parameters, 'ruggedness ~ relativeage1')

% check for normal distribution of residuals
figure
qqplot(mod1.Residuals.Raw)
title('QQ Plot of "Ruggedness ~ relative age" model versus Standard Normal')

end

