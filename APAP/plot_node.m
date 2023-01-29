%节点的生成在topology.m文件中，结果保存在network8.txt(1000节点) 文件中
%此处的函数根据读取txt文件的数据获得节点和网络的相关信息

%预处理
clc;
clear all;
close all;
%节点参数
R = 400;             %网络半径
r=60;                %节点的发射半径
N = 900;            %节点个数

packet_size = 1024  ;%假设每个数据包的比特数为1024
%能量消耗有关参数
d0 = 87; %临界距离
elec = 50*10^(-9);%10-9 发射电路损耗能量
fs = 10*10^(-12); %10-12  发射功率放大所需能量功率
amp = 0.0013*10^(-12);%10-12  接收功率放大所需能量功率
initial_value = 0.5;   %各节点的初始剩余能量
inward_delay=1;     %一跳延迟为1ms
PR_dalay=2;         %一次PR延迟为2ms

node_x = [];            %其余节点的x坐标
node_y = [];            %其余节点的y坐标
sink_x = 0;             %sink节点的x坐标
sink_y = 0;             %sink节点的y坐标

n=1; %控制结构体node 的序号
%对生成的网络参数保存在文件中，从文件中读取生成的网络拓扑
fid = fopen('.\network8.txt','rt');%'D:\matlabwork\network8.txt','rt');

while ~feof(fid)       
    line1 =fgetl(fid);
    line2 = fgetl(fid);
    ps= regexp(line1,'=');%此处有修改
    ps= ps +1;
    str1 = line1(ps:end);
    str2 = line2(ps:end);
    x = str2num(str1);
    y = str2num(str2);
    node_x = [node_x,x];
    node_y = [node_y,y];
    node(n).ID=n;                       %存放每个节点的ID号
    node(n).x=node_x(n);                %用结构体node存放900个节点每个节点的x坐标   node(1).x   node(2).x   node(3).x  node(4).x  ......
    node(n).y=node_y(n);                %用结构体node存放900个节点每个节点的y坐标        node(1).y   node(2).y   node(3).y  node(4).y  ......
    node(n).re_energy= initial_value;   %用结构体node存放每个节点的剩余能量    node(1).re_energy   node(2).re_energy   node(3).re_energy  node(4).re_energy  ......
    node(n).ring=inf;                   %用结构体node存放900个节点每个节点的跳数即环数，初始设为无穷大
    node(n).packet=packet_size;
   % node(n).flag=0;                     %flag==0则不可感知数据，flag==1时可以感知数据。
    node(n).neighbors.id=0;
    node(n).neighbors.rad=0;
    %添加结构体变量dis
 	node(n).dis= sqrt(node(n).x*node(n).x+node(n).y*node(n).y);
    

    %text(node(n).x,node(n).y,num2str(n));
    n=n+1; 
    axis on;
    hold on;   
end
 fclose(fid);%关闭文件
 
    node_x = [node_x,sink_x];                   %sink节点的x坐标为0
    node_y = [node_y,sink_y];                   %sink节点的y坐标为0
    node(N+1).x=0;                 %sink节点的序号为N+1号节点
    node(N+1).y=0;  
    node(N+1).re_energy= inf;           %sink节点的能量无限大
    %绘制节点
    plot(node_x,node_y,'o','color',[0.3010 0.7450 0.9330]);
    plot(0,0,'rp','LineWidth', 3);
    text(0.2,0.2,'sink');
    %绘制外环
    alpha=0:pi/50:2*pi;
    R=400;
    x=R*cos(alpha); 
    y=R*sin(alpha); 
    plot(x,y,'--')
    axis on;
    hold on;
    

    
   
    
    