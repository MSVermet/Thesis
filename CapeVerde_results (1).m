%% Function analysis Cape Verde

function f = analysis_capeverde(capeverde)
    
    % Standardizing properties
    std_age_capeverde = (capeverde.age - mean(capeverde.age) / std(capeverde.age));
    std_elev_capeverde = (capeverde.elevation - mean(capeverde.elevation)) / std(capeverde.elevation);
    std_area_capeverde = (capeverde.area - mean(capeverde.area)) / std(capeverde.area);
    std_topoc_capeverde = (capeverde.ruggedness - mean(capeverde.ruggedness)) / std(capeverde.ruggedness);

    % plot elevation, area, topographic complexity to see if the theoretical
    % assumption of GDM holds true (topogr compl occurs some time after max
    % elev and area)
    figure
    plot(capeverde.age, std_elev_capeverde, '-.')
    hold on 
    plot(capeverde.age, std_area_capeverde, '--')
    hold on
    plot(capeverde.age, std_topoc_capeverde, '-o')
    islands = {'Brava', 'Fogo', 'Santiago', 'S. Nicolau', 'S. Vicente', 'S. Antao', 'Sal', 'Boa Vista', 'Maio'}
    text(capeverde.age + 0.5, std_topoc_capeverde, islands)
    legend('elevation', 'area', 'topogr. compl')
    xlabel('age (my)')
    ylabel('standardized scores')
    title('Cape Verde') 

    % smoothening the lines by interpolation
    % zooming in by removing the "outlier?", last point
    xq = (4.4:0.166:21);
    vxq_elev = pchip(capeverde.age, std_elev_capeverde, xq)
    
    % set colors
    c_yellow = [0.9290, 0.6940, 0.1250];
    c_blue = [0 0.4470 0.7410];
    c_red = [0.8500 0.3250 0.0980];
    
    figure
    plot(xq, vxq_elev, '-.')
    hold on
    scatter(capeverde.age, std_elev_capeverde, [], c_blue)
    hold on
    vxq_area = pchip(capeverde.age, std_area_capeverde, xq)
    plot(xq, vxq_area, '--')
    hold on
    scatter(capeverde.age, std_area_capeverde, [], c_red)
    hold on
    vxq_topo = pchip(capeverde.age, std_topoc_capeverde, xq)
    plot(xq, vxq_topo)
    hold on
    scatter(capeverde.age, std_topoc_capeverde, [], c_yellow)
    %legend('elevation', 'area', 'topogr. compl')
    xlabel('age (my)')
    ylabel('standardized scores')
    title('Cape Verde')

    % plot topographic complexity to see if middle aged island highest
    % topographic complexity
    figure 
    p_area = polyfit(capeverde.age,std_elev_capeverde,2)
    x1_area = capeverde.age;
    y1_area = polyval(p_area,x1_area);
    hold on
    plot(x1_area,y1_area, '-.')

    hold on
    p_area = polyfit(capeverde.age,std_area_capeverde,2)
    x1_area = capeverde.age;
    y1_area = polyval(p_area,x1_area);
    hold on
    plot(x1_area,y1_area, '--')
    
    hold on
    p_topo = polyfit(capeverde.age,std_topoc_capeverde,2)
    x1_topo = capeverde.age;
    y1_topo = polyval(p_topo,x1_topo);
    hold on
    plot(x1_topo,y1_topo)
    legend('elevation', 'area','topogr. compl')
    xlabel('age (my)')
    ylabel('standardized scores')
    title('Cape Verde - 2nd polynomial fit')
end