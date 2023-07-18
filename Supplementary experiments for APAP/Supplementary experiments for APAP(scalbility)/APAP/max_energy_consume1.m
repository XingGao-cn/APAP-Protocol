%此脚本用于统计一轮后能量消耗最大节点的花费
max_energy_consume = inf;

for i=1:length(node)
    if node(i).re_energy<max_energy_consume
        max_energy_consume=node(i).re_energy;
    end
end

figure;
    q1=bar(initial_value-max_energy_consume);
    axis([0 2 0 0.5]);
    xtips1 = q1(1).XEndPoints;
    ytips1 = q1(1).YEndPoints;
    
labels1 = string(q1(1).YData);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')
title("一轮结束消耗最大节点能量开销");