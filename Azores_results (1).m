%% Function analysis Azores
function f = analysis_azores(azores)
    
    % standardizing properties
    std_age_azores = (azores.age - mean(azores.age) / std(azores.age));
    std_elev_azores = (azores.elevation - mean(azores.elevation)) / std(azores.elevation);
    std_area_azores = (azores.area - mean(azores.area)) / std(azores.area);
    std_topoc_azores = (azores.ruggedness - mean(azores.ruggedness)) / std(azores.ruggedness);

    % plot elevation, area, topographic complexity to see if the theoretical
    % assumption of GDM holds true (topogr compl occurs some time after max
    % elev and area)
    figure
    plot(azores.age, std_elev_azores, '-.')
    hold on 
    plot(azores.age, std_area_azores, '--')
    hold on
    plot(azores.age, std_topoc_azores, '-o')
    islands = {'Pico', 'Terceira', 'Corvo', 'Faial', 'S. Miguel', 'Graciosa', 'S. Jorge', 'Flores', 'S. Maria'}
    text(azores.age, std_topoc_azores, islands);
    legend('elevation', 'area', 'topogr. compl')
    xlabel('age (my)')
    ylabel('standardized scores')
    title('Azores') 

    % smoothening the lines by interpolation
    % zooming in by removing the "outlier?", last point
    xq = (0.27:0.0189:2.16)
    vxq_elev = pchip(azores.age, std_elev_azores, xq)
    
    % set colors
    c_yellow = [0.9290, 0.6940, 0.1250];
    c_blue = [0 0.4470 0.7410];
    c_red = [0.8500 0.3250 0.0980];
    
    figure        
    plot(xq, vxq_elev, '-.')
    hold on
    scatter(azores.age(1:8), std_elev_azores(1:8), [], c_blue)
    hold on
    vxq_area = pchip(azores.age, std_area_azores, xq)
    plot(xq, vxq_area, '--')
    hold on 
    scatter(azores.age(1:8), std_area_azores(1:8), [], c_red)
    hold on
    vxq_topo = pchip(azores.age, std_topoc_azores, xq)
    plot(xq, vxq_topo)
    hold on
    scatter(azores.age(1:8), std_topoc_azores(1:8), [], c_yellow)
    %legend('elevation', 'data point', 'area','data point', 'topogr. compl', 'data point')
    xlim([0.2 2.2])
    xlabel('age (my)')
    ylabel('standardized scores')
    title('Azores')

    % plot topographic complexity to see if middle aged island highest
    % topographic complexity
    figure 
    p_area = polyfit(azores.age,std_elev_azores,2)
    x1_area = azores.age;
    y1_area = polyval(p_area,x1_area);
    hold on
    plot(x1_area,y1_area, '-.')

    hold on
    p_area = polyfit(azores.age,std_area_azores,2)
    x1_area = azores.age;
    y1_area = polyval(p_area,x1_area);
    hold on
    plot(x1_area,y1_area, '--')
    
    hold on
    p_topo = polyfit(azores.age,std_topoc_azores,2)
    x1_topo = azores.age;
    y1_topo = polyval(p_topo,x1_topo);
    hold on
    plot(x1_topo,y1_topo)
    legend('elevation', 'area','topogr. compl')
    xlabel('age (my)')
    ylabel('standardized scores')
    title('Azores - 2nd polynomial fit')
end