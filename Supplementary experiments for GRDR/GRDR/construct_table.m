function [node]=construct_table(node,circle_n,r,L)
%circle为所想要维持表所在的环，r是维持表的节点的通信半径,L是每个表的容量(记录数据的份数上限)
   %node所嵌套的结构体pass  用以记录接收到的数据

for i=1:(length(node)-1)
    if node(i).ring==circle_n
           node(i).table_member=[];
       for j=1:20
           node(i).pass(j).id=0;
           node(i).pass(j).copies=[];
           node(i).pass(j).gap_time=0;
       end
    for j=1:length(node(i).neighbors)
        if j==0
            break;
        end
        if node(i).neighbors(j).dis<=r &&node(node(i).neighbors(j).id).ring==circle_n  %通信范围 r 内并且处于同一环
            node(i).table_member=[node(i).table_member,node(i).neighbors(j).id];
        end
    end
    plot_circle(node(i).x,node(i).y,20);
    end
end
% end
