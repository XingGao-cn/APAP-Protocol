%此文件为随机分离算法1
function [dirctions,w]=seed_random_dispersity1(node,ID,M)
%ID为中继节点号，M为种子分离份数
%r = a + (b-a).*rand(N,1) 生成区间 (a,b) 内的 N 个随机数。
   % r=(2*pi).*rand(M,1);
   % r=r./pi
   r=2*rand(1,M);
   w=1;%暂定随机游走步数=1
    dirctions=[];%用以记录n份数据包的下一跳方向，即邻居节点ID
%***********四象限法*************    
for i=1:M
    if 0<=r(i)&&r(i)<0.5
        qu=1;
    elseif 0.5<=r(i)&&r(i)<1
        qu=2;
    elseif 1<=r(i)&&r(i)<1.5
        qu=3;
    elseif 1.5<=r(i)&&r(i)<=2
        qu=4;  
    end
    
        switch(qu)%注意此处以ring为判定
        case {1}  %一定要换行，否则会出错
            h=length(node(ID).nei.quadrant1);  
            num=ceil(1+(h-1).*rand(1,1));
            a=length(node(ID).nei.quadrant3);  
            NUM=ceil(1+(a-1).*rand(1,1));
            if h==0
                dirctions=[dirctions,node(ID).nei.quadrant3(NUM)];
            else
            	dirctions=[dirctions,node(ID).nei.quadrant1(num)];
            end
        case {2}   %一定要换行，否则会出错
            h=length(node(ID).nei.quadrant2);  
            num=ceil(1+(h-1).*rand(1,1));
            a=length(node(ID).nei.quadrant4);  
            NUM=ceil(1+(a-1).*rand(1,1));
            if h==0
                dirctions=[dirctions,node(ID).nei.quadrant4(NUM)];
            else
            	dirctions=[dirctions,node(ID).nei.quadrant2(num)];
            end          
        case {3}   %一定要换行，否则会出错
            h=length(node(ID).nei.quadrant3);  
            num=ceil(1+(h-1).*rand(1,1));
            a=length(node(ID).nei.quadrant1);  
            NUM=ceil(1+(a-1).*rand(1,1));
            if h==0
                dirctions=[dirctions,node(ID).nei.quadrant1(NUM)];
            else
            	dirctions=[dirctions,node(ID).nei.quadrant3(num)];
            end          
        case {4}  
            h=length(node(ID).nei.quadrant4);  
            num=ceil(1+(h-1).*rand(1,1));
            a=length(node(ID).nei.quadrant2);  
            NUM=ceil(1+(a-1).*rand(1,1));
            if h==0
                dirctions=[dirctions,node(ID).nei.quadrant2(NUM)];
            else
            	dirctions=[dirctions,node(ID).nei.quadrant4(num)];
            end         
    end 
end



