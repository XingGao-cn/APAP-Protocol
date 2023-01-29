function [loads,xy]=statistics_rings_data_loads(node)
    %统计各环数据总量 ，网络数据量为全局变量All
    loads=zeros(1,15);
    for i=1:length(node)
       loads(node(i).ring)=loads(node(i).ring)+length(node(i).receive);
    end
    %统计不同dis2sink数据承载量
    for i=1:length(node)
        X=[X,node(i).dis];
    end
    for i=1:length(node)
        Y=[Y,length(node(i).receive)];
    end
    
    xy=[X;Y];
end