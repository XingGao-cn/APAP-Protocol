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
 node_x11= [];
 node_x12= [];
 node_x13= [];
 node_x14= [];
 node_x15= [];
 
 node_x16 = [];              %node_x6记录第六环各节点的x坐标
 node_x17 = [];
 node_x18 = [];
 node_x19 = [];
 node_x20= [];
 node_x21= [];
 node_x22= [];
 node_x23= [];
 node_x24= [];
 node_x25= [];
 
 
 
 
 
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
 node_y11= [];
 node_y12= [];
 node_y13= [];
 node_y14= []; 
 node_y15= [];  
 
 
 
 node_y16 = [];              %node_x6记录第六环各节点的x坐标
 node_y17 = [];
 node_y18 = [];
 node_y19 = [];
 node_y20= [];
 node_y21= [];
 node_y22= [];
 node_y23= [];
 node_y24= [];
 node_y25= [];
 
 
 
 
 
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
 circle_11=[];
 circle_12=[];
 circle_13=[];
 circle_14=[];
 circle_15=[];
 
 circle_16=[];               %circle_6记录第六环各节点的序号
 circle_17=[];
 circle_18=[];   
 circle_19=[];
 circle_20=[];
 circle_21=[];
 circle_22=[];
 circle_23=[];
 circle_24=[];
 circle_25=[];
 
 
 
 %=======================================
 %下面进行第一大部分“同跳环状区域形成”
 %=======================================
%采用广播的方式区分各节点到sink的跳数
 num = 1;
 while num<=length(node)-1                                                 % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
     distan2sink = sqrt(node(num).x*node(num).x+node(num).y*node(num).y);  % distan2sink记录各个节点和sink节点的距离
     if   distan2sink <=r                                                  % 节点与sink的距离小于等于60  则属于第一环
          node_x1 = [node_x1,node(num).x];
          node_y1 = [node_y1,node(num).y]; 
          circle_1=[circle_1,num];                                         % circle_1 记录第一环中有哪些节点的序号   
          node(num).ring=1;
         % node(num).father=N+1;
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
%开始找第九跳节点
 for i=1: length(circle_8)
    for num=1:length(node)                                                  % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
         distan2sink =sqrt(((node(circle_8(i)).x-node(num).x).* (node(circle_8(i)).x-node(num).x))+ ((node(circle_8(i)).y-node(num).y).*(node(circle_8(i)).y-node(num).y)));  % distan2sink记录各个节点和第一环各节点的距离
         if   distan2sink <=r                                                 % 节点与第八环的某个节点的距离小于等于60  则属于第九环
              ringNow = node(circle_8(i)).ring+1;
              if  node(num).ring>ringNow
                   node(num).ring=ringNow;
                   node_x9 = [node_x9,node(num).x];
                   node_y9 = [node_y9,node(num).y]; 
                   circle_9=[circle_9,num];                                   % circle_9 记录第九环中有哪些节点的序号   
              end
         end
         num=num+1;
    end
 end          
 %第九跳节点都找出来了
%   %================================================= 
%开始找第十跳节点
 for i=1: length(circle_9)
    for num=1:length(node)                                                  % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
         distan2sink =sqrt(((node(circle_9(i)).x-node(num).x).* (node(circle_9(i)).x-node(num).x))+ ((node(circle_9(i)).y-node(num).y).*(node(circle_9(i)).y-node(num).y)));  % distan2sink记录各个节点和第一环各节点的距离
         if   distan2sink <=r                                                 % 节点与第五环的某个节点的距离小于等于60  则属于第八环
              ringNow = node(circle_9(i)).ring+1;
              if  node(num).ring>ringNow
                   node(num).ring=ringNow;
                   node_x10 = [node_x10,node(num).x];
                   node_y10 = [node_y10,node(num).y]; 
                   circle_10=[circle_10,num];                                   % circle_8 记录第六环中有哪些节点的序号   
              end
         end
         num=num+1;
    end
 end          
 %第十跳节点都找出来了
 %   %================================================= 
%开始找第十一跳节点
 for i=1: length(circle_10)
    for num=1:length(node)                                                  % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
         distan2sink =sqrt(((node(circle_10(i)).x-node(num).x).* (node(circle_10(i)).x-node(num).x))+ ((node(circle_10(i)).y-node(num).y).*(node(circle_10(i)).y-node(num).y)));  % distan2sink记录各个节点和第一环各节点的距离
         if   distan2sink <=r                                                 % 节点与第五环的某个节点的距离小于等于60  则属于第八环
              ringNow = node(circle_10(i)).ring+1;
              if  node(num).ring>ringNow
                   node(num).ring=ringNow;
                   node_x11 = [node_x11,node(num).x];
                   node_y11 = [node_y11,node(num).y]; 
                   circle_11=[circle_11,num];                                   % circle_8 记录第六环中有哪些节点的序号   
              end
         end
         num=num+1;
    end
 end          
 %第十一跳节点都找出来了
 
  %   %================================================= 
%开始找第十二跳节点
 for i=1: length(circle_11)
    for num=1:length(node)                                                  % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
         distan2sink =sqrt(((node(circle_11(i)).x-node(num).x).* (node(circle_11(i)).x-node(num).x))+ ((node(circle_11(i)).y-node(num).y).*(node(circle_11(i)).y-node(num).y)));  % distan2sink记录各个节点和第一环各节点的距离
         if   distan2sink <=r                                                 % 节点与第五环的某个节点的距离小于等于60  则属于第八环
              ringNow = node(circle_11(i)).ring+1;
              if  node(num).ring>ringNow
                   node(num).ring=ringNow;
                   node_x12 = [node_x12,node(num).x];
                   node_y12 = [node_y12,node(num).y]; 
                   circle_12=[circle_12,num];                                   % circle_8 记录第六环中有哪些节点的序号   
              end
         end
         num=num+1;
    end
 end          
 %第十二跳节点都找出来了
 
   %   %================================================= 
%开始找第十三跳节点
 for i=1: length(circle_12)
    for num=1:length(node)                                                  % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
         distan2sink =sqrt(((node(circle_12(i)).x-node(num).x).* (node(circle_12(i)).x-node(num).x))+ ((node(circle_12(i)).y-node(num).y).*(node(circle_12(i)).y-node(num).y)));  % distan2sink记录各个节点和第一环各节点的距离
         if   distan2sink <=r                                                 % 节点与第五环的某个节点的距离小于等于60  则属于第八环
              ringNow = node(circle_12(i)).ring+1;
              if  node(num).ring>ringNow
                   node(num).ring=ringNow;
                   node_x13 = [node_x13,node(num).x];
                   node_y13 = [node_y13,node(num).y]; 
                   circle_13=[circle_13,num];                                   % circle_8 记录第六环中有哪些节点的序号   
              end
         end
         num=num+1;
    end
 end          
 %第十三跳节点都找出来了
 
    %   %================================================= 
%开始找第十四跳节点
 for i=1: length(circle_13)
    for num=1:length(node)                                                  % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
         distan2sink =sqrt(((node(circle_13(i)).x-node(num).x).* (node(circle_13(i)).x-node(num).x))+ ((node(circle_13(i)).y-node(num).y).*(node(circle_13(i)).y-node(num).y)));  % distan2sink记录各个节点和第一环各节点的距离
         if   distan2sink <=r                                                 % 节点与第五环的某个节点的距离小于等于60  则属于第八环
              ringNow = node(circle_13(i)).ring+1;
              if  node(num).ring>ringNow
                   node(num).ring=ringNow;
                   node_x14 = [node_x14,node(num).x];
                   node_y14 = [node_y14,node(num).y]; 
                   circle_14=[circle_14,num];                                   % circle_8 记录第六环中有哪些节点的序号   
              end
         end
         num=num+1;
    end
 end          
 %第十四跳节点都找出来了
 %=======================================
     %   %================================================= 
%开始找第十五跳节点
 for i=1: length(circle_14)
    for num=1:length(node)                                                  % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
         distan2sink =sqrt(((node(circle_14(i)).x-node(num).x).* (node(circle_14(i)).x-node(num).x))+ ((node(circle_14(i)).y-node(num).y).*(node(circle_14(i)).y-node(num).y)));  % distan2sink记录各个节点和第一环各节点的距离
         if   distan2sink <=r                                                 % 节点与第五环的某个节点的距离小于等于60  则属于第八环
              ringNow = node(circle_14(i)).ring+1;
              if  node(num).ring>ringNow
                   node(num).ring=ringNow;
                   node_x15 = [node_x15,node(num).x];
                   node_y15 = [node_y15,node(num).y]; 
                   circle_15=[circle_15,num];                                   % circle_8 记录第六环中有哪些节点的序号   
              end
         end
         num=num+1;
    end
 end          
 %第十五跳节点都找出来了
  %=======================================
     %   %================================================= 
%开始找第十六跳节点
 for i=1: length(circle_15)
    for num=1:length(node)                                                  % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
         distan2sink =sqrt(((node(circle_15(i)).x-node(num).x).* (node(circle_15(i)).x-node(num).x))+ ((node(circle_15(i)).y-node(num).y).*(node(circle_15(i)).y-node(num).y)));  % distan2sink记录各个节点和第一环各节点的距离
         if   distan2sink <=r                                                 % 节点与第五环的某个节点的距离小于等于60  则属于第八环
              ringNow = node(circle_15(i)).ring+1;
              if  node(num).ring>ringNow
                   node(num).ring=ringNow;
                   node_x16 = [node_x16,node(num).x];
                   node_y16 = [node_y16,node(num).y]; 
                   circle_16=[circle_16,num];                                   % circle_8 记录第六环中有哪些节点的序号   
              end
         end
         num=num+1;
    end
 end          
 %第十六跳节点都找出来了
   %=======================================
     %   %================================================= 
%开始找第十七跳节点
 for i=1: length(circle_16)
    for num=1:length(node)                                                  % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
         distan2sink =sqrt(((node(circle_16(i)).x-node(num).x).* (node(circle_16(i)).x-node(num).x))+ ((node(circle_16(i)).y-node(num).y).*(node(circle_16(i)).y-node(num).y)));  % distan2sink记录各个节点和第一环各节点的距离
         if   distan2sink <=r                                                 % 节点与第五环的某个节点的距离小于等于60  则属于第八环
              ringNow = node(circle_16(i)).ring+1;
              if  node(num).ring>ringNow
                   node(num).ring=ringNow;
                   node_x17 = [node_x17,node(num).x];
                   node_y17 = [node_y17,node(num).y]; 
                   circle_17=[circle_17,num];                                   % circle_8 记录第六环中有哪些节点的序号   
              end
         end
         num=num+1;
    end
 end          
 %第十七跳节点都找出来了
 
    %=======================================
     %   %================================================= 
%开始找第十八跳节点
 for i=1: length(circle_17)
    for num=1:length(node)                                                  % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
         distan2sink =sqrt(((node(circle_17(i)).x-node(num).x).* (node(circle_17(i)).x-node(num).x))+ ((node(circle_17(i)).y-node(num).y).*(node(circle_17(i)).y-node(num).y)));  % distan2sink记录各个节点和第一环各节点的距离
         if   distan2sink <=r                                                 % 节点与第五环的某个节点的距离小于等于60  则属于第八环
              ringNow = node(circle_17(i)).ring+1;
              if  node(num).ring>ringNow
                   node(num).ring=ringNow;
                   node_x18 = [node_x18,node(num).x];
                   node_y18 = [node_y18,node(num).y]; 
                   circle_18=[circle_18,num];                                   % circle_8 记录第六环中有哪些节点的序号   
              end
         end
         num=num+1;
    end
 end          
 %第十八跳节点都找出来了
     %=======================================
     %   %================================================= 
%开始找第十九跳节点
 for i=1: length(circle_18)
    for num=1:length(node)                                                  % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
         distan2sink =sqrt(((node(circle_18(i)).x-node(num).x).* (node(circle_18(i)).x-node(num).x))+ ((node(circle_18(i)).y-node(num).y).*(node(circle_18(i)).y-node(num).y)));  % distan2sink记录各个节点和第一环各节点的距离
         if   distan2sink <=r                                                 % 节点与第五环的某个节点的距离小于等于60  则属于第八环
              ringNow = node(circle_18(i)).ring+1;
              if  node(num).ring>ringNow
                   node(num).ring=ringNow;
                   node_x19 = [node_x19,node(num).x];
                   node_y19 = [node_y19,node(num).y]; 
                   circle_19=[circle_19,num];                                   % circle_8 记录第六环中有哪些节点的序号   
              end
         end
         num=num+1;
    end
 end          
 %第十九跳节点都找出来了
      %=======================================
     %   %================================================= 
%开始找第二十跳节点
 for i=1: length(circle_19)
    for num=1:length(node)                                                  % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
         distan2sink =sqrt(((node(circle_19(i)).x-node(num).x).* (node(circle_19(i)).x-node(num).x))+ ((node(circle_19(i)).y-node(num).y).*(node(circle_19(i)).y-node(num).y)));  % distan2sink记录各个节点和第一环各节点的距离
         if   distan2sink <=r                                                 % 节点与第五环的某个节点的距离小于等于60  则属于第八环
              ringNow = node(circle_19(i)).ring+1;
              if  node(num).ring>ringNow
                   node(num).ring=ringNow;
                   node_x20 = [node_x20,node(num).x];
                   node_y20 = [node_y20,node(num).y]; 
                   circle_20 =[circle_20,num];                                   % circle_8 记录第六环中有哪些节点的序号   
              end
         end
         num=num+1;
    end
 end          
 %第二十跳节点都找出来了
       %=======================================
     %   %================================================= 
 %开始找第二十一跳节点
 for i=1: length(circle_20)
    for num=1:length(node)                                                  % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
         distan2sink =sqrt(((node(circle_20(i)).x-node(num).x).* (node(circle_20(i)).x-node(num).x))+ ((node(circle_20(i)).y-node(num).y).*(node(circle_20(i)).y-node(num).y)));  % distan2sink记录各个节点和第一环各节点的距离
         if   distan2sink <=r                                                 % 节点与第五环的某个节点的距离小于等于60  则属于第八环
              ringNow = node(circle_20(i)).ring+1;
              if  node(num).ring>ringNow
                   node(num).ring=ringNow;
                   node_x21 = [node_x21,node(num).x];
                   node_y21 = [node_y21,node(num).y]; 
                   circle_21 =[circle_21,num];                                   % circle_8 记录第六环中有哪些节点的序号   
              end
         end
         num=num+1;
    end
 end 
%第二十一跳节点都找出来了
       %=======================================
     %   %================================================= 
 %开始找第二十二跳节点
 for i=1: length(circle_21)
    for num=1:length(node)                                                  % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
         distan2sink =sqrt(((node(circle_21(i)).x-node(num).x).* (node(circle_21(i)).x-node(num).x))+ ((node(circle_21(i)).y-node(num).y).*(node(circle_21(i)).y-node(num).y)));  % distan2sink记录各个节点和第一环各节点的距离
         if   distan2sink <=r                                                 % 节点与第五环的某个节点的距离小于等于60  则属于第八环
              ringNow = node(circle_21(i)).ring+1;
              if  node(num).ring>ringNow
                   node(num).ring=ringNow;
                   node_x22 = [node_x22,node(num).x];
                   node_y22 = [node_y22,node(num).y]; 
                   circle_22 =[circle_22,num];                                   % circle_8 记录第六环中有哪些节点的序号   
              end
         end
         num=num+1;
    end
 end          
 %第二十二跳节点都找出来了 

       %=======================================
     %   %================================================= 
 %开始找第二十三跳节点
 for i=1: length(circle_22)
    for num=1:length(node)                                                  % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
         distan2sink =sqrt(((node(circle_22(i)).x-node(num).x).* (node(circle_22(i)).x-node(num).x))+ ((node(circle_22(i)).y-node(num).y).*(node(circle_22(i)).y-node(num).y)));  % distan2sink记录各个节点和第一环各节点的距离
         if   distan2sink <=r                                                 % 节点与第五环的某个节点的距离小于等于60  则属于第八环
              ringNow = node(circle_22(i)).ring+1;
              if  node(num).ring>ringNow
                   node(num).ring=ringNow;
                   node_x23 = [node_x23,node(num).x];
                   node_y23 = [node_y23,node(num).y]; 
                   circle_23 =[circle_23,num];                                   % circle_8 记录第六环中有哪些节点的序号   
              end
         end
         num=num+1;
    end
 end          
 %第二十三跳节点都找出来了 
        %=======================================
     %   %================================================= 
 %开始找第二十四跳节点
 for i=1: length(circle_23)
    for num=1:length(node)                                                  % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
         distan2sink =sqrt(((node(circle_23(i)).x-node(num).x).* (node(circle_23(i)).x-node(num).x))+ ((node(circle_23(i)).y-node(num).y).*(node(circle_23(i)).y-node(num).y)));  % distan2sink记录各个节点和第一环各节点的距离
         if   distan2sink <=r                                                 % 节点与第五环的某个节点的距离小于等于60  则属于第八环
              ringNow = node(circle_23(i)).ring+1;
              if  node(num).ring>ringNow
                   node(num).ring=ringNow;
                   node_x24 = [node_x24,node(num).x];
                   node_y24 = [node_y24,node(num).y]; 
                   circle_24 =[circle_24,num];                                   % circle_8 记录第六环中有哪些节点的序号   
              end
         end
         num=num+1;
    end
 end          
 %第二十四跳节点都找出来了 
         %=======================================
     %   %================================================= 
 %开始找第二十五跳节点
 for i=1: length(circle_24)
    for num=1:length(node)                                                  % 900个节点，node是个结构体变量，包括sink节点共901个节点，其中sink节点的编号为901
         distan2sink =sqrt(((node(circle_24(i)).x-node(num).x).* (node(circle_24(i)).x-node(num).x))+ ((node(circle_24(i)).y-node(num).y).*(node(circle_24(i)).y-node(num).y)));  % distan2sink记录各个节点和第一环各节点的距离
         if   distan2sink <=r                                                 % 节点与第五环的某个节点的距离小于等于60  则属于第八环
              ringNow = node(circle_24(i)).ring+1;
              if  node(num).ring>ringNow
                   node(num).ring=ringNow;
                   node_x25 = [node_x25,node(num).x];
                   node_y25 = [node_y25,node(num).y]; 
                   circle_25 =[circle_25,num];                                   % circle_8 记录第六环中有哪些节点的序号   
              end
         end
         num=num+1;
    end
 end          
 %第二十五跳节点都找出来了 
 
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
  %把第九环节点用node9结构体表示
 n=1;
 while n~=length(node_x9)+1   
     node9(n).x=node_x9(n);      %每个节点的x坐标
     node9(n).y=node_y9(n);      %每个节点的y坐标
     node9(n).ID=circle_9(n);    %每个节点的ID
     node9(n).ring=9;            %每个节点的环号为9
     node9(n).label=0;           %每个节点的访问标志设为0
     node9(n).re_energy= initial_value;
     n=n+1;
 end
 ring9=9;   %第七环的环号7赋值给一个变量ring9
%  %=======================================
%    %=======================================
  %把第十环节点用node10结构体表示
 n=1;
 while n~=length(node_x10)+1   
     node10(n).x=node_x10(n);      %每个节点的x坐标
     node10(n).y=node_y10(n);      %每个节点的y坐标
     node10(n).ID=circle_10(n);    %每个节点的ID
     node10(n).ring=10;            %每个节点的环号为10
     node10(n).label=0;           %每个节点的访问标志设为0
     node10(n).re_energy= initial_value;
     n=n+1;
 end
 ring10=10;   %第七环的环号7赋值给一个变量ring9
 %=======================================
 
 %    %=======================================
  %把第十一环节点用node11结构体表示
 n=1;
 while n~=length(node_x11)+1   
     node11(n).x=node_x11(n);      %每个节点的x坐标
     node11(n).y=node_y11(n);      %每个节点的y坐标
     node11(n).ID=circle_11(n);    %每个节点的ID
     node11(n).ring=11;            %每个节点的环号为10
     node11(n).label=0;           %每个节点的访问标志设为0
     node11(n).re_energy= initial_value;
     n=n+1;
 end
 ring11=11;   %第七环的环号7赋值给一个变量ring9
 %=======================================
 
 %    %=======================================
  %把第十二环节点用node12结构体表示
 n=1;
 while n~=length(node_x12)+1   
     node12(n).x=node_x12(n);      %每个节点的x坐标
     node12(n).y=node_y12(n);      %每个节点的y坐标
     node12(n).ID=circle_12(n);    %每个节点的ID
     node12(n).ring=12;            %每个节点的环号为10
     node12(n).label=0;           %每个节点的访问标志设为0
     node12(n).re_energy= initial_value;
     n=n+1;
 end
 ring12=12;   %第七环的环号7赋值给一个变量ring9
 %=======================================
 
  %    %=======================================
  %把第十三环节点用node12结构体表示
 n=1;
 while n~=length(node_x13)+1   
     node13(n).x=node_x13(n);      %每个节点的x坐标
     node13(n).y=node_y13(n);      %每个节点的y坐标
     node13(n).ID=circle_13(n);    %每个节点的ID
     node13(n).ring=13;            %每个节点的环号为10
     node13(n).label=0;           %每个节点的访问标志设为0
     node13(n).re_energy= initial_value;
     n=n+1;
 end
 ring13=13;   %第七环的环号7赋值给一个变量ring9
 %=======================================
   %    %=======================================
  %把第十四环节点用node14结构体表示
 n=1;
 while n~=length(node_x14)+1   
     node14(n).x=node_x14(n);      %每个节点的x坐标
     node14(n).y=node_y14(n);      %每个节点的y坐标
     node14(n).ID=circle_14(n);    %每个节点的ID
     node14(n).ring=14;            %每个节点的环号为10
     node14(n).label=0;           %每个节点的访问标志设为0
     node14(n).re_energy= initial_value;
     n=n+1;
 end
 ring14=14;   %第七环的环号7赋值给一个变量ring9
 %=======================================
 
   %把第十五环节点用node14结构体表示
 n=1;
 while n~=length(node_x15)+1   
     node15(n).x=node_x15(n);      %每个节点的x坐标
     node15(n).y=node_y15(n);      %每个节点的y坐标
     node15(n).ID=circle_15(n);    %每个节点的ID
     node15(n).ring=15;            %每个节点的环号为10
     node15(n).label=0;           %每个节点的访问标志设为0
     node15(n).re_energy= initial_value;
     n=n+1;
 end
 ring15=15;   %第七环的环号7赋值给一个变量ring9
 %=======================================
  
   %把第十六环节点用node16结构体表示
 n=1;
 while n~=length(node_x16)+1   
     node16(n).x=node_x16(n);      %每个节点的x坐标
     node16(n).y=node_y16(n);      %每个节点的y坐标
     node16(n).ID=circle_16(n);    %每个节点的ID
     node16(n).ring=16;            %每个节点的环号为10
     node16(n).label=0;           %每个节点的访问标志设为0
     node16(n).re_energy= initial_value;
     n=n+1;
 end
 ring16=16;   %第七环的环号7赋值给一个变量ring9
 %=======================================
   %把第十七环节点用node17结构体表示
 n=1;
 while n~=length(node_x17)+1   
     node17(n).x=node_x17(n);      %每个节点的x坐标
     node17(n).y=node_y17(n);      %每个节点的y坐标
     node17(n).ID=circle_17(n);    %每个节点的ID
     node17(n).ring=17;            %每个节点的环号为10
     node17(n).label=0;           %每个节点的访问标志设为0
     node17(n).re_energy= initial_value;
     n=n+1;
 end
 ring17=17;   
 %=======================================
   %把第十八环节点用node18结构体表示
 n=1;
 while n~=length(node_x18)+1   
     node18(n).x=node_x18(n);      %每个节点的x坐标
     node18(n).y=node_y18(n);      %每个节点的y坐标
     node18(n).ID=circle_18(n);    %每个节点的ID
     node18(n).ring=18;            %每个节点的环号为10
     node18(n).label=0;           %每个节点的访问标志设为0
     node18(n).re_energy= initial_value;
     n=n+1;
 end
 ring18=18;   
 %=======================================
    %把第十九环节点用node19结构体表示
 n=1;
 while n~=length(node_x19)+1   
     node19(n).x=node_x19(n);      %每个节点的x坐标
     node19(n).y=node_y19(n);      %每个节点的y坐标
     node19(n).ID=circle_19(n);    %每个节点的ID
     node19(n).ring=19;            %每个节点的环号为10
     node19(n).label=0;           %每个节点的访问标志设为0
     node19(n).re_energy= initial_value;
     n=n+1;
 end
 ring19=19;   
 %=======================================
 %把第二十环节点用node20结构体表示
 n=1;
 while n~=length(node_x20)+1   
     node20(n).x=node_x20(n);      %每个节点的x坐标
     node20(n).y=node_y20(n);      %每个节点的y坐标
     node20(n).ID=circle_20(n);    %每个节点的ID
     node20(n).ring=20;            %每个节点的环号为10
     node20(n).label=0;           %每个节点的访问标志设为0
     node20(n).re_energy= initial_value;
     n=n+1;
 end
 ring20=20;   
 %=======================================
 %把第二十一环节点用node21结构体表示
 n=1;
 while n~=length(node_x21)+1   
     node21(n).x=node_x21(n);      %每个节点的x坐标
     node21(n).y=node_y21(n);      %每个节点的y坐标
     node21(n).ID=circle_21(n);    %每个节点的ID
     node21(n).ring=21;            %每个节点的环号为10
     node21(n).label=0;           %每个节点的访问标志设为0
     node21(n).re_energy= initial_value;
     n=n+1;
 end
 ring21=21;   
 %=======================================
  %把第二十二环节点用node22结构体表示
 n=1;
 while n~=length(node_x22)+1   
     node22(n).x=node_x22(n);      %每个节点的x坐标
     node22(n).y=node_y22(n);      %每个节点的y坐标
     node22(n).ID=circle_22(n);    %每个节点的ID
     node22(n).ring=22;            %每个节点的环号为10
     node22(n).label=0;           %每个节点的访问标志设为0
     node22(n).re_energy= initial_value;
     n=n+1;
 end
 ring22=22;   
 %=======================================
   %把第二十三环节点用node23结构体表示
 n=1;
 while n~=length(node_x23)+1   
     node23(n).x=node_x23(n);      %每个节点的x坐标
     node23(n).y=node_y23(n);      %每个节点的y坐标
     node23(n).ID=circle_23(n);    %每个节点的ID
     node23(n).ring=23;            %每个节点的环号为10
     node23(n).label=0;           %每个节点的访问标志设为0
     node23(n).re_energy= initial_value;
     n=n+1;
 end
 ring23=23;   
 %=======================================
    %把第二十四环节点用node24结构体表示
 n=1;
 while n~=length(node_x24)+1   
     node24(n).x=node_x24(n);      %每个节点的x坐标
     node24(n).y=node_y24(n);      %每个节点的y坐标
     node24(n).ID=circle_24(n);    %每个节点的ID
     node24(n).ring=24;            %每个节点的环号为10
     node24(n).label=0;           %每个节点的访问标志设为0
     node24(n).re_energy= initial_value;
     n=n+1;
 end
 ring24=24;
 %=======================================
     %把第二十五环节点用node25结构体表示
 n=1;
 while n~=length(node_x25)+1   
     node25(n).x=node_x25(n);      %每个节点的x坐标
     node25(n).y=node_y25(n);      %每个节点的y坐标
     node25(n).ID=circle_25(n);    %每个节点的ID
     node25(n).ring=25;            %每个节点的环号为10
     node25(n).label=0;           %每个节点的访问标志设为0
     node25(n).re_energy= initial_value;
     n=n+1;
 end
 ring25=25;
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
draw_node_ring(node_x9,node_y9, circle_9,ring9);
draw_node_ring(node_x10,node_y10, circle_10,ring10);
draw_node_ring(node_x11,node_y11, circle_11,ring11);
draw_node_ring(node_x12,node_y12, circle_12,ring12);
draw_node_ring(node_x13,node_y13, circle_13,ring13);
draw_node_ring(node_x14,node_y14, circle_14,ring14);
draw_node_ring(node_x15,node_y15, circle_15,ring15);

draw_node_ring(node_x16,node_y16, circle_16,ring16);   %调用函数draw_node_ring画第六环节点 
draw_node_ring(node_x17,node_y17, circle_17,ring17);
draw_node_ring(node_x18,node_y18, circle_18,ring18);
draw_node_ring(node_x19,node_y19, circle_19,ring19);
draw_node_ring(node_x20,node_y20, circle_20,ring20);
draw_node_ring(node_x21,node_y21, circle_21,ring21);
draw_node_ring(node_x22,node_y22, circle_22,ring22);
draw_node_ring(node_x23,node_y23, circle_23,ring23);
draw_node_ring(node_x24,node_y24, circle_24,ring24);
draw_node_ring(node_x25,node_y25, circle_25,ring25);


%最后绘制sink，将不被遮挡
    alpha=0:pi/50:2*pi;
    R=600;
    x=R*cos(alpha); 
    y=R*sin(alpha); 
    plot(x,y,'r:')
    axis on;
    hold on;
    axis equal;

plot(node_x,node_y,'o','color',[0.3010 0.7450 0.9330]);
plot(0,0,'rp','LineWidth', 3);
text(0.25,0.25,'sink');


