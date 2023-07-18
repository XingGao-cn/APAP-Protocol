function [loads,ring_avgloads,X,Y,Z]=statistics_net_data_loads(node)
    %统计各环数据总量 ，网络数据量为全局变量All
    
    loads=zeros(1,30);
    for i=1:length(node)-1
        if node(i).ring~=inf
            loads(node(i).ring)=loads(node(i).ring)+length(node(i).receive);
        end
    end
    
    %统计各环节点平均负载
    ring_avgloads=zeros(1,30);
    
    rings=zeros(1,30);
    
    for i=1:length(node)-1
        if node(i).ring~=inf
            ring=node(i).ring;
            rings(ring)=rings(ring)+1;
        end
    end
    
    ring_avgloads=loads./rings;
    
    %统计不同dis2sink数据承载量与剩余能量
    X=[];
    Y=[];
    Z=[];
    
    %距离dis
    for i=1:length(node)
        X=[X,node(i).dis];
    end
    
    %数据量(数据统计用bytes)
    for i=1:length(node)-1
        Y=[Y,length(node(i).receive)];
    end
    
    %剩余能量Remaining energy
    for i=1:length(node)-1
        Z=[Z,node(i).re_energy];
    end
    
%     scatter(X,Y,'MarkerEdgeColor',[0 .5 .5],...
%               'MarkerFaceColor',[0 .7 .7],...
%               'LineWidth',1.5)

end