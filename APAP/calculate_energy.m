%当有链路成功传输时，调用这个函数，可以计算出链路的两端节点的能量消耗，即接收端节点减去接收能量消耗。发送端减去发送能量消耗
%m为发送节点，n为接收节点
%alive1为节点存活标志
function [node,alive1,die_node] = calculate_energy(node,m,n,alive1,die_node)

packet_size =1024;  %注意在每个文件中统一参数
%能量消耗有关参数
d0 = 87;
elec = 50*10^(-9);       %10-9
fs = 10*10^(-12);        %10-12
amp = 0.0013*10^(-12);   %10-12
%***************
  if node(m).re_energy<=0 
    node(m).re_energy=0;
    alive1=0;
    die_node=m;
  end
     if node(n).re_energy<=0
    node(n).re_energy=0;
    alive1=0;
    die_node=n;
     end
     
 x1=node(m).x;                                %发送端节点的x坐标   
 x2=node(n).x;                                %接收端节点的x坐标 
 
 y1=node(m).y;                                %发送端节点的y坐标   
 y2=node(n).y;                                %接收端节点的y坐标 
 
 
 distance=sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2));

 send_consum = sendDataEnergyConsume(distance,packet_size,d0,elec,amp,fs);     %发送端节点计算发送一个数据包的能量消耗
 rece_consum = receiveDataEnergyConsume(packet_size,elec);                     %接收端节点计算接收一个数据包的能量消耗
 
 node(m).re_energy= node(m).re_energy - send_consum ;              %发送端节点的剩余能量
 
 node(n).re_energy= node(n).re_energy-rece_consum ;                %接收端节点的剩余能量
 
  if node(m).re_energy<=0 
    node(m).re_energy=0;
    alive1=0;
    die_node=m;
  end
     if node(n).re_energy<=0
    node(n).re_energy=0;
    alive1=0;
    die_node=n;
     end
     
 X=[x1;x2];
 Y=[y1;y2];
 line(X,Y,'color','r','linestyle','-','LineWidth',2);  %使用到了line进行连线
 %quiver(x1,y1,x1-x2,y1-y2,3);
 %annotation('arrow',X,Y,'LineStyle','-','color',[1 1 0],'HeadStyle','plain');
  
end
 
 
 