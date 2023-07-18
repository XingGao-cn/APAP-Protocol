%此函数用以将node结构体完善，向其中添加必要的数据成员(另一部分在plot_node中已经实现)
for i=1:(length(node)-1)
   node(i).receive=[];%本地存储,用以记录接收到的数据包ID
   %node所嵌套的结构体Data  用以记录自身数据
   
   for j=1:1500%预分配内存
   node(i).Data(j).ID=0;
   node(i).Data(j).PRs=0;%PRs为seed数量，也为Data(n)的数量
   node(i).Data(j).start_time=0;
   node(i).Data(j).num=0;%每份数据包都有自己的编号 RRs记录之前复制的份数
   node(i).Data(j).TTL=0;
   node(i).Data(j).delay=0;
   node(i).Data(j).w=1;%随机游走步数，根据数据包份数与end2end概率确定
   end
   node(i).flag=true;%单份数据包能否发送的标志
   %***划分随机扩散算法邻居节点所在象限
   node(i).nei.quadrant1=[];
   node(i).nei.quadrant2=[];
   node(i).nei.quadrant3=[];
   node(i).nei.quadrant4=[];
   node(i).short_hop=inf;%最短路算法下一跳节点
end

for i=1:15000
   node(N+1).Data(i).ID=0; 
   node(N+1).Data(i).PRs=0;
   node(N+1).Data(i).start_time=0;
   node(N+1).Data(i).num=0;
   node(N+1).Data(i).TTL=0;
   node(N+1).Data(i).delay=0;
   node(N+1).Data(i).w=1;
end

%通信范围r内全部邻居节点
dist=inf;
for i=1:(length(node)-1)
        num=1;
   for j=1: (length(node)-1)
       if i==j
           continue;
       end
       dist=node_dis(node,i,j);
       if dist<=r && node(j).ring~=inf          
           node(i).neighbors(num).id=node(j).ID;
           node(i).neighbors(num).dis=dist;
           num=num+1;           
       end
   end
   %node(i).neighbors(node(i).neighbors==node(i).ID)=[];%在邻居节点中去掉自己的ID号
end


for i = 1:length(node)-1
    if node(i).ring==inf
        num=1;
           node(i).neighbors(num).id=0;
           node(i).neighbors(num).dis=0;
           num=num+1;    
    end
end

%*****弧度制坐标（R==dis）*************
for i=1:length(node)
       [TH,~] = cart2pol(node(i).x,node(i).y);
       node(i).rad=TH;
end
%*****邻居节点弧度制******
for i=1:(length(node)-1)
    h=length(node(i).neighbors);
    if h==0
        continue;
    else
    for j=1:h
            i;
            j;
        id=node(i).neighbors(j).id;
        if id==0
            continue;
        end
        [TH,~] = cart2pol(node(id).x-node(i).x,node(id).y-node(i).y);
        node(i).neighbors(j).rad=TH;
    end
    end
end

%进行邻居节点四象限的划分
% for i=1:(length(node)-1)
%     k=length(node(i).neighbors);
%     if k==0
%         continue;
%     else
%     for j=1:k
%         id=node(i).neighbors(j).id;
%     if node(id).x-node(i).x>0&&node(id).y-node(i).y>=0
%         
%         node(i).nei.quadrant1=[node(i).nei.quadrant1,id];
%     elseif node(id).x-node(i).x<=0&&node(id).y-node(i).y>0
%         node(i).nei.quadrant2=[node(i).nei.quadrant2,id];
%     elseif node(id).x-node(i).x<0&&node(id).y-node(i).y<=0    
%         node(i).nei.quadrant3=[node(i).nei.quadrant3,id];   
%     else
%         node(i).nei.quadrant4=[node(i).nei.quadrant4,id];
%     end
%     end
%     end
% end

%对邻居节点象限进行去重
for i=1:(length(node)-1)
    node(i).nei.quadrant1=unique( node(i).nei.quadrant1);
    node(i).nei.quadrant2=unique( node(i).nei.quadrant2);
    node(i).nei.quadrant3=unique( node(i).nei.quadrant3);
    node(i).nei.quadrant4=unique( node(i).nei.quadrant4);
end

%**********记录每个节点下一跳最短路ID*****************
for i=1:(length(node)-1)
    if node(i).ring==1
        node(i).short_hop=N+1;
    else
    dis=inf;
    k=inf;
    h=length(node(i).neighbors);
     if h==0
        continue;
     end
    for j=1:h
       id=node(i).neighbors(j).id;
       if id==0
           node(i).short_hop=i;
           continue;
       end
       if node(id).dis<dis
           dis=node(id).dis;
           k=id;
       end
    end
    node(i).short_hop=k;
    end
end
node(N+1).ring=0;
%***********************************
