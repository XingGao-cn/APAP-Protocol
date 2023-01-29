%此函数为模拟随机创建N个node，坐标数据保存在text8中
%This function creates N nodes randomly for simulation, and the coordinate
%data is saved in text8.txt
%Monte Carlo Simulation was adopted
function topology
clc;
clear ;
%Network scale
R  = 400;
N = 900;
%************
number = 1;
  fid = fopen('.\network8.txt','w');  %'D:\matlabwork\network22.txt','w'); file address
while (number<=N)
    node_x = rand*2*R-R;%r = a + (b-a).*rand(N,1) 生成区间 (a,b) 内的 N 个随机数。
    node_y = rand*2*R-R;%Generate N random numbers in the range (a, b).
    if sqrt(node_x*node_x + node_y* node_y) <=R
      
        line1 = ['WSN.node[',num2str(number) ,'].x=' ,num2str(node_x)];
        line2 = ['WSN.node[',num2str(number) ,'].y=' ,num2str(node_y)];
        fprintf(fid,'%s\r\n',line1);
        fprintf(fid,'%s\r\n',line2);
        number = number + 1;
        
    end
   
end
 fclose(fid);% Close one or all open files
