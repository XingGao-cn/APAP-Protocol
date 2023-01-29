%此文件之间运行，导出一张路由路径图
clear,clc;
t=cputime;
%topology;
plot_node;
plot_ring;
complete_node_struct;
container=randperm(N);
%清除变量
clear alpha;
clear h;
clear i;
clear id;
clear j;
clear k;
clear n;
clear ps;
clear TH;
clear num;
clear str1;
clear str2;
clear x;
clear y;
queue=[];
L=100;
Time=3; 
%下面在第1、2、3环每环区域内维持通信记录表 ，函数原型：[node]=construct_table(node,circle_n,r,L)
Cost=0;%记录三环内因额外通信开销所消耗的能量
Save=0;%记录拦截数据包所节省的能量 
 %每环拦截数据包的数量
intercepts=[];
intercept1=0; 
intercept2=0;
intercept3=0;
[node]=construct_table(node,1,10,20);
[node]=construct_table(node,2,20,20);
[node]=construct_table(node,3,20,20);
 [node,alive1,die_node]=PRUncertain_stage(node,15,15,Time,3,1);
 [node,alive1,die_node]=PRUncertain_stage(node,19,19,Time,3,1);
 [node,alive1,die_node]=PRUncertain_stage(node,21,21,Time,3,1);
 [node,alive1,die_node]=PRUncertain_stage(node,34,34,Time,3,1);

for i=1:100  
    for j=1:(length(node)-1)
    [node,alive1,die_node,intercepts] = per_hop(node,j,Time,intercepts) ;
    end
    Time=Time+1;
    %更新表的时间
    [node]=Update_table(node,circle_1,2);
    [node]=Update_table(node,circle_2,2);
    [node]=Update_table(node,circle_3,2);
end

%最后绘制sink，将不被遮挡
plot(0,0,'rp','LineWidth', 3);
text(0.2,0.2,'sink');

