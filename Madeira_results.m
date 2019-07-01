%% Standardizing ages - Madeira
function f = analysis_madeira(madeira)

    % standardizing properties
    std_age_madeira = (madeira.age - mean(madeira.age) / std(madeira.age));
    std_elev_madeira = (madeira.elevation - mean(madeira.elevation)) / std(madeira.elevation);
    std_area_madeira = (madeira.area - mean(madeira.area)) / std(madeira.area);
    std_topoc_madeira = (madeira.ruggedness - mean(madeira.ruggedness)) / std(madeira.ruggedness);

    % plot elevation, area, topographic complexity to see if the theoretical
    % assumption of GDM holds true (topographic comp occurs sometime after max
    % elev and area)
    figure
    plot(madeira.age, std_elev_madeira, '-.')
    hold on 
    plot(madeira.age, std_area_madeira, '--')
    hold on
    plot(madeira.age, std_topoc_madeira, '-o')
    islands = {'Madeira', 'Porto Santo'}
    text(madeira.age, std_topoc_madeira, islands)
    legend('elevation', 'area', 'topogr. compl')
    xlabel('time (my)')
    ylabel('standardized scores')
    title('Madeira') 


end
