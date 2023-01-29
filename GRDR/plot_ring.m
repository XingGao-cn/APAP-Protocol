%此文件根据最短路算法对节点进行分环处理

%节点分环状区域进行处理
 node_x1 = [];              %node_x1记录第一环各节点的x坐标
 node_x2 = [];              %node_x2记录第二环各节点的x坐标
 node_x3 = [];              %node_x3记录第三环各节点的x坐标
 node_x4 = [];              %node_x4记录第四环各节点的x坐标
 node_x5 = [];              %node_x5记录第五环各节点的x坐标
 node_x6 = [];              %node_x6记录第六环各节点的x坐标
 node_x7 = [];
 node_x8 = [];
 node_x9 = [];
 node_x10= [];
 
 node_y1 = [];              %node_y1记录第一环各节点的y坐标
 node_y2 = [];              %node_y2记录第二环各节点的y坐标
 node_y3 = [];              %node_y3记录第三环各节点的y坐标
 node_y4 = [];              %node_y4记录第四环各节点的y坐标
 node_y5 = [];              %node_y5记录第五环各节点的y坐标
 node_y6 = [];              %node_y6记录第六环各节点的y坐标
 node_y7 = [];   
 node_y8 = [];  %新添加的七八环数据储存
 node_y9 = [];
 node_y10= [];
 
 circle_1=[];               %circle_1记录第一环各节点的序号  
 circle_2=[];               %circle_2记录第二环各节点的序号
 circle_3=[];               %circle_3记录第三环各节点的序号
 circle_4=[];               %circle_4记录第四环各节点的序号
 circle_5=[];               %circle_5记录第五环各节点的序号
 circle_6=[];               %circle_6记录第六环各节点的序号
 circle_7=[];
 circle_8=[];   %新添加的七八环数据储存
 circle_9=[];
 circle_10=[];
 
 %=======================================
 %下面进行第一大部分“同跳环状区域形成”
 %=======================================
%  
%=================================================
%采用广播的方式区分各节点到sink的跳数
 num = 1;
 while num<=length(node)-1                                                 % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
     distan2sink = sqrt(node(num).x*node(num).x+node(num).y*node(num).y);  % distan2sink记录各个节点和sink节点的距离
     if   distan2sink <=r                                                  % 节点与sink的距离小于等于60  则属于第一环
          node_x1 = [node_x1,node(num).x];
          node_y1 = [node_y1,node(num).y]; 
          circle_1=[circle_1,num];                                         % circle_1 记录第一环中有哪些节点的序号   
          node(num).ring=1;
         % node(num).father=901;
     end
     num=num+1;
 end
%第一跳节点都找出来了
%=================================================          
%开始找第二跳节点
 for i=1: length(circle_1)
    for num=1:length(node)                                                  % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
         distan2sink =sqrt(((node(circle_1(i)).x-node(num).x).* (node(circle_1(i)).x-node(num).x))+ ((node(circle_1(i)).y-node(num).y).*(node(circle_1(i)).y-node(num).y)));  % distan2sink记录各个节点和第一环各节点的距离
         if   distan2sink <=r                                                 % 节点与第一环的某个节点的距离小于等于60  则属于第二环
              ringNow = node(circle_1(i)).ring+1;
              if  node(num).ring>ringNow        %也即node(num).ring=1，就无须再改为第2环
                   node(num).ring=ringNow;
                   node_x2 = [node_x2,node(num).x];
                   node_y2 = [node_y2,node(num).y]; 
                   circle_2=[circle_2,num];                                   % circle_2 记录第二环中有哪些节点的序号   
              end
         end
         num=num+1;
    end
 end          
 %第二跳节点都找出来了  
 %=================================================   
%开始找第三跳节点
 for i=1: length(circle_2)
    for num=1:length(node)                                                  % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
         distan2sink =sqrt(((node(circle_2(i)).x-node(num).x).* (node(circle_2(i)).x-node(num).x))+ ((node(circle_2(i)).y-node(num).y).*(node(circle_2(i)).y-node(num).y)));  % distan2sink记录各个节点和第一环各节点的距离
         if   distan2sink <=r                                                 % 节点与第二环的某个节点的距离小于等于60  则属于第三环
              ringNow = node(circle_2(i)).ring+1;
              if  node(num).ring>ringNow
                   node(num).ring=ringNow;
                   node_x3 = [node_x3,node(num).x];
                   node_y3 = [node_y3,node(num).y]; 
                   circle_3=[circle_3,num];                                  % circle_3 记录第三环中有哪些节点的序号   
              end
         end
         num=num+1;
    end
 end           
 %第三跳节点都找出来了
 %=================================================           
   %开始找第四跳节点
 for i=1: length(circle_3)
    for num=1:length(node)                                                  % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
         distan2sink =sqrt(((node(circle_3(i)).x-node(num).x).* (node(circle_3(i)).x-node(num).x))+ ((node(circle_3(i)).y-node(num).y).*(node(circle_3(i)).y-node(num).y)));  % distan2sink记录各个节点和第一环各节点的距离
         if   distan2sink <=r                                                 % 节点与第三环的某个节点的距离小于等于60  则属于第四环
              ringNow = node(circle_3(i)).ring+1;
              if  node(num).ring>ringNow
                   node(num).ring=ringNow;
                   node_x4 = [node_x4,node(num).x];
                   node_y4 = [node_y4,node(num).y]; 
                   circle_4=[circle_4,num];                                   % circle_4 记录第四环中有哪些节点的序号   
              end
         end
         num=num+1;
    end
 end          
 %第四跳节点都找出来了
%=================================================          
%开始找第五跳节点
 for i=1: length(circle_4)
    for num=1:length(node)                                                  % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
         distan2sink =sqrt(((node(circle_4(i)).x-node(num).x).* (node(circle_4(i)).x-node(num).x))+ ((node(circle_4(i)).y-node(num).y).*(node(circle_4(i)).y-node(num).y)));  % distan2sink记录各个节点和第一环各节点的距离
         if   distan2sink <=r                                                 % 节点与第四环的某个节点的距离小于等于60  则属于第五环
              ringNow = node(circle_4(i)).ring+1;
              if  node(num).ring>ringNow
                   node(num).ring=ringNow;
                   node_x5 = [node_x5,node(num).x];
                   node_y5 = [node_y5,node(num).y]; 
                   circle_5=[circle_5,num];                                   % circle_5 记录第五环中有哪些节点的序号   
              end
         end
         num=num+1;
    end
 end          
 %第五跳节点都找出来了
%=================================================            
          
%开始找第六跳节点
 for i=1: length(circle_5)
    for num=1:length(node)                                                  % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
         distan2sink =sqrt(((node(circle_5(i)).x-node(num).x).* (node(circle_5(i)).x-node(num).x))+ ((node(circle_5(i)).y-node(num).y).*(node(circle_5(i)).y-node(num).y)));  % distan2sink记录各个节点和第一环各节点的距离
         if   distan2sink <=r                                                 % 节点与第五环的某个节点的距离小于等于60  则属于第六环
              ringNow = node(circle_5(i)).ring+1;
              if  node(num).ring>ringNow
                   node(num).ring=ringNow;
                   node_x6 = [node_x6,node(num).x];
                   node_y6 = [node_y6,node(num).y]; 
                   circle_6=[circle_6,num];                                   % circle_6 记录第六环中有哪些节点的序号   
              end
         end
         num=num+1;
    end
 end          
 %第六跳节点都找出来了
%=================================================     
%额外添加第七八环

%开始找第七跳节点
 for i=1: length(circle_6)
    for num=1:length(node)                                                  % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
         distan2sink =sqrt(((node(circle_6(i)).x-node(num).x).* (node(circle_6(i)).x-node(num).x))+ ((node(circle_6(i)).y-node(num).y).*(node(circle_6(i)).y-node(num).y)));  % distan2sink记录各个节点和第一环各节点的距离
         if   distan2sink <=r                                                 % 节点与第五环的某个节点的距离小于等于60  则属于第七环
              ringNow = node(circle_6(i)).ring+1;
              if  node(num).ring>ringNow
                   node(num).ring=ringNow;
                   node_x7 = [node_x7,node(num).x];
                   node_y7 = [node_y7,node(num).y]; 
                   circle_7=[circle_7,num];                                   % circle_7 记录第七环中有哪些节点的序号   
              end
         end
         num=num+1;
    end
 end          
 %第七跳节点都找出来了
 %================================================= 
%开始找第八跳节点
 for i=1: length(circle_7)
    for num=1:length(node)                                                  % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
         distan2sink =sqrt(((node(circle_7(i)).x-node(num).x).* (node(circle_7(i)).x-node(num).x))+ ((node(circle_7(i)).y-node(num).y).*(node(circle_7(i)).y-node(num).y)));  % distan2sink记录各个节点和第一环各节点的距离
         if   distan2sink <=r                                                 % 节点与第五环的某个节点的距离小于等于60  则属于第八环
              ringNow = node(circle_7(i)).ring+1;
              if  node(num).ring>ringNow
                   node(num).ring=ringNow;
                   node_x8 = [node_x8,node(num).x];
                   node_y8 = [node_y8,node(num).y]; 
                   circle_8=[circle_8,num];                                   % circle_8 记录第八环中有哪些节点的序号   
              end
         end
         num=num+1;
    end
 end          
 %第八跳节点都找出来了
 %=================第九、十跳用于更大规模的网络对比，注释掉================================ 
% %开始找第九跳节点
%  for i=1: length(circle_8)
%     for num=1:length(node)                                                  % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
%          distan2sink =sqrt(((node(circle_8(i)).x-node(num).x).* (node(circle_8(i)).x-node(num).x))+ ((node(circle_8(i)).y-node(num).y).*(node(circle_8(i)).y-node(num).y)));  % distan2sink记录各个节点和第一环各节点的距离
%          if   distan2sink <=r                                                 % 节点与第八环的某个节点的距离小于等于60  则属于第九环
%               ringNow = node(circle_8(i)).ring+1;
%               if  node(num).ring>ringNow
%                    node(num).ring=ringNow;
%                    node_x9 = [node_x9,node(num).x];
%                    node_y9 = [node_y9,node(num).y]; 
%                    circle_9=[circle_9,num];                                   % circle_9 记录第九环中有哪些节点的序号   
%               end
%          end
%          num=num+1;
%     end
%  end          
%  %第九跳节点都找出来了
%   %================================================= 
% %开始找第十跳节点
%  for i=1: length(circle_9)
%     for num=1:length(node)                                                  % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
%          distan2sink =sqrt(((node(circle_9(i)).x-node(num).x).* (node(circle_9(i)).x-node(num).x))+ ((node(circle_9(i)).y-node(num).y).*(node(circle_9(i)).y-node(num).y)));  % distan2sink记录各个节点和第一环各节点的距离
%          if   distan2sink <=r                                                 % 节点与第五环的某个节点的距离小于等于60  则属于第八环
%               ringNow = node(circle_9(i)).ring+1;
%               if  node(num).ring>ringNow
%                    node(num).ring=ringNow;
%                    node_x10 = [node_x10,node(num).x];
%                    node_y10 = [node_y10,node(num).y]; 
%                    circle_10=[circle_10,num];                                   % circle_8 记录第六环中有哪些节点的序号   
%               end
%          end
%          num=num+1;
%     end
%  end          
%  %第十跳节点都找出来了
 
 


 %=======================================
 %把第一环节点用node1结构体表示
 n=1;
 while n~=length(node_x1)+1   
     node1(n).x=node_x1(n);      %每个节点的x坐标
     node1(n).y=node_y1(n);      %每个节点的y坐标
     node1(n).ID=circle_1(n);    %每个节点的ID
     node1(n).ring=1;            %每个节点的环号为1
     node1(n).label=0;           %每个节点的访问标志设为0
     node1(n).re_energy= initial_value;
     n=n+1;
 end
 ring1=1;   %第一环的环号1赋值给一个变量ring1
 %=======================================        
    
 %=======================================
 %把第二环节点用node2结构体表示
 n=1;
 while n~=length(node_x2)+1   
     node2(n).x=node_x2(n);      %每个节点的x坐标
     node2(n).y=node_y2(n);      %每个节点的y坐标
     node2(n).ID=circle_2(n);    %每个节点的ID
     node2(n).ring=2;            %每个节点的环号为2
     node2(n).label=0;           %每个节点的访问标志设为0
     node2(n).re_energy= initial_value;
     n=n+1;
 end
 ring2=2;   %第二环的环号2赋值给一个变量ring2
 %=======================================
 
 %=======================================
 %把第三环节点用node3结构体表示
 n=1;
 while n~=length(node_x3)+1   
     node3(n).x=node_x3(n);      %每个节点的x坐标
     node3(n).y=node_y3(n);      %每个节点的y坐标
     node3(n).ID=circle_3(n);    %每个节点的ID
     node3(n).ring=3;            %每个节点的环号为3
     node3(n).label=0;           %每个节点的访问标志设为0
     node3(n).re_energy= initial_value;
     n=n+1;
 end
 ring3=3;   %第三环的环号3赋值给一个变量ring3
 %======================================= 
 
   %=======================================
 %把第四环节点用node4结构体表示
 n=1;
 while n~=length(node_x4)+1   
     node4(n).x=node_x4(n);      %每个节点的x坐标
     node4(n).y=node_y4(n);      %每个节点的y坐标
     node4(n).ID=circle_4(n);    %每个节点的ID
     node4(n).ring=4;            %每个节点的环号为4
     node4(n).label=0;           %每个节点的访问标志设为0
     node4(n).re_energy= initial_value;
     n=n+1;
 end
 ring4=4;   %第四环的环号4赋值给一个变量ring4
%=======================================
 
  
%=======================================
 %把第五环节点用node5结构体表示
 n=1;
 while n~=length(node_x5)+1   
     node5(n).x=node_x5(n);      %每个节点的x坐标
     node5(n).y=node_y5(n);      %每个节点的y坐标
     node5(n).ID=circle_5(n);    %每个节点的ID
     node5(n).ring=5;            %每个节点的环号为5
     node5(n).label=0;           %每个节点的访问标志设为0
     node5(n).re_energy= initial_value;
     n=n+1;
 end
 ring5=5;   %第五环的环号5赋值给一个变量ring5
 %=======================================
 
 
 %=======================================
 %把第六环节点用node6结构体表示
 n=1;
 while n~=length(node_x6)+1   
     node6(n).x=node_x6(n);      %每个节点的x坐标
     node6(n).y=node_y6(n);      %每个节点的y坐标
     node6(n).ID=circle_6(n);    %每个节点的ID
     node6(n).ring=6;            %每个节点的环号为6
     node6(n).label=0;           %每个节点的访问标志设为0
     node6(n).re_energy= initial_value;
     n=n+1;
 end
 ring6=6;   %第六环的环号6赋值给一个变量ring6
 %=======================================
 %开始新添加的ring6、7
  %把第七环节点用node7结构体表示
 n=1;
 while n~=length(node_x7)+1   
     node7(n).x=node_x7(n);      %每个节点的x坐标
     node7(n).y=node_y7(n);      %每个节点的y坐标
     node7(n).ID=circle_7(n);    %每个节点的ID
     node7(n).ring=7;            %每个节点的环号为6
     node7(n).label=0;           %每个节点的访问标志设为0
     node7(n).re_energy= initial_value;
     n=n+1;
 end
 ring7=7;   %第七环的环号7赋值给一个变量ring7
 %=======================================
  %把第八环节点用node8结构体表示
 n=1;
 while n~=length(node_x8)+1   
     node8(n).x=node_x8(n);      %每个节点的x坐标
     node8(n).y=node_y8(n);      %每个节点的y坐标
     node8(n).ID=circle_8(n);    %每个节点的ID
     node8(n).ring=8;            %每个节点的环号为6
     node8(n).label=0;           %每个节点的访问标志设为0
     node8(n).re_energy= initial_value;
     n=n+1;
 end
 ring8=8;   %第七环的环号7赋值给一个变量ring8
 %=======================================
  %=======================================
%   %把第九环节点用node9结构体表示
%  n=1;
%  while n~=length(node_x9)+1   
%      node9(n).x=node_x9(n);      %每个节点的x坐标
%      node9(n).y=node_y9(n);      %每个节点的y坐标
%      node9(n).ID=circle_9(n);    %每个节点的ID
%      node9(n).ring=9;            %每个节点的环号为9
%      node9(n).label=0;           %每个节点的访问标志设为0
%      node9(n).re_energy= initial_value;
%      n=n+1;
%  end
%  ring9=9;   %第七环的环号7赋值给一个变量ring9
%  %=======================================
%    %=======================================
%   %把第十环节点用node10结构体表示
%  n=1;
%  while n~=length(node_x10)+1   
%      node10(n).x=node_x10(n);      %每个节点的x坐标
%      node10(n).y=node_y10(n);      %每个节点的y坐标
%      node10(n).ID=circle_10(n);    %每个节点的ID
%      node10(n).ring=10;            %每个节点的环号为10
%      node10(n).label=0;           %每个节点的访问标志设为0
%      node10(n).re_energy= initial_value;
%      n=n+1;
%  end
%  ring10=10;   %第七环的环号7赋值给一个变量ring9
 %=======================================
 %以上第一大部分“同跳环状区域形成”完成
 %=======================================
 
% 
draw_node_ring(node_x1,node_y1, circle_1,ring1);   %调用函数draw_node_ring画第一环节点
draw_node_ring(node_x2,node_y2, circle_2,ring2);   %调用函数draw_node_ring画第二环节点
draw_node_ring(node_x3,node_y3, circle_3,ring3);   %调用函数draw_node_ring画第三环节点 
draw_node_ring(node_x4,node_y4, circle_4,ring4);   %调用函数draw_node_ring画第四环节点 
draw_node_ring(node_x5,node_y5, circle_5,ring5);   %调用函数draw_node_ring画第五环节点 
draw_node_ring(node_x6,node_y6, circle_6,ring6);   %调用函数draw_node_ring画第六环节点 
draw_node_ring(node_x7,node_y7, circle_7,ring7);
draw_node_ring(node_x8,node_y8, circle_8,ring8);
% draw_node_ring(node_x9,node_y9, circle_9,ring9);
% draw_node_ring(node_x10,node_y10, circle_10,ring10);
%最后绘制sink，将不被遮挡
    alpha=0:pi/50:2*pi;
    R=400;
    x=R*cos(alpha); 
    y=R*sin(alpha); 
    plot(x,y,'r:')
    axis on;
    hold on;
    axis equal;

plot(node_x,node_y,'o','color',[0.3010 0.7450 0.9330]);
plot(0,0,'rp','LineWidth', 3);
text(0.25,0.25,'sink');


