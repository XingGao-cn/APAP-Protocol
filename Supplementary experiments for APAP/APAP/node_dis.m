%此函数用以计算两点间距离
function [dist]=node_dis(node,ss,rr)
%其中，ss与rr为两节点ID号
    x1=node(ss).x;
    y1=node(ss).y;
    x2=node(rr).x;
    y2=node(rr).y;

dist=sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)); 
end
