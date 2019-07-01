%% Analysis Canary islands
function f = analysis_canary(canary)
    
    % standardizing properties
    std_age_canary = (canary.age - mean(canary.age) / std(canary.age));
    std_elev_canary = (canary.elevation - mean(canary.elevation)) / std(canary.elevation);
    std_area_canary = (canary.area - mean(canary.area)) / std(canary.area);
    std_topoc_canary = (canary.ruggedness - mean(canary.ruggedness)) / std(canary.ruggedness);
    
    % plot elevation, area, topographic complexity to see if the theoretical
    % assumption of GDM holds true (topogr compl occurs some time after max
    % elev and area)
    figure
    plot(canary.age, std_elev_canary, '-.')
    hold on 
    plot(canary.age, std_area_canary, '--')
    hold on
    plot(canary.age, std_topoc_canary, '-o')
    islands = {'El Hierro', 'La Palma', 'La Gomera', 'Tenerife', 'Gran Canaria', 'Lanzarote', 'Fuerteventura'}
    text(canary.age, std_topoc_canary, islands);
    legend('elevation', 'area', 'topogr. compl')
    xlabel('age (my)')
    ylabel('standardized scores')
    title('Canary islands') 

    % plot elevation, area, topographic complexity to see if the theoretical
    % assumption of GDM holds true (topographic comp occurs sometime after max
    % elev and area)
    xq = (1.1:0.219:23)
    vxq_elev = pchip(canary.age, std_elev_canary, xq)
    
    % set colors
    c_yellow = [0.9290, 0.6940, 0.1250];
    c_blue = [0 0.4470 0.7410];
    c_red = [0.8500 0.3250 0.0980];
    
    figure   
    plot(xq, vxq_elev, '-.')
    hold on 
    scatter(canary.age, std_elev_canary, [], c_blue)
    hold on
    vxq_area = pchip(canary.age, std_area_canary, xq)
    plot(xq, vxq_area, '--')
    hold on 
    scatter(canary.age, std_area_canary, [], c_red)
    hold on
    vxq_topo = pchip(canary.age, std_topoc_canary, xq)
    plot(xq, vxq_topo)
    hold on
    scatter(canary.age, std_topoc_canary, [], c_yellow)
    %legend('elevation', 'data point', 'area','data point', 'topogr. compl', 'data point')
    xlabel('age (my)')
    ylabel('standardized scores')
    title('Canary')

    % plot topographic complexity to see if middle aged island highest
    % topographic complexity
    figure 
    p_area = polyfit(canary.age,std_elev_canary,2)
    x1_area = canary.age;
    y1_area = polyval(p_area,x1_area);
    hold on
    plot(x1_area,y1_area, '-.')

    hold on
    p_area = polyfit(canary.age,std_area_canary,2)
    x1_area = canary.age;
    y1_area = polyval(p_area,x1_area);
    hold on
    plot(x1_area,y1_area, '--')
    
    hold on
    p_topo = polyfit(canary.age,std_topoc_canary,2)
    x1_topo = canary.age;
    y1_topo = polyval(p_topo,x1_topo);
    hold on
    plot(x1_topo,y1_topo)
    legend('elevation', 'area', 'topogr. compl')
    xlabel('age (my)')
    ylabel('standardized scores')
    title('Canary - 2nd polynomial fit')
end
