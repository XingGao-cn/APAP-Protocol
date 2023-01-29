function [node,messages]=inform_energy_consume(node,send_id,receive_id,distance,messages)
         %能量消耗有关参数
         d0 = 87; %临界距离
         elec = 50*10^(-9);%10-9 发射电路损耗能量
         fs = 10*10^(-12); %10-12  发射功率放大所需能量功率
         amp = 0.0013*10^(-12);%10-12  接收功率放大所需能量功率
         databits=128;  %hotspots区域邻居间交换的数据包大小为128bits
         
         send_energy_consum = sendDataEnergyConsume(distance,databits,d0,elec,amp,fs);
         re_energy_consum = receiveDataEnergyConsume(databits,elec);
         node(send_id).re_energy=node(send_id).re_energy-send_energy_consum ;
         node(receive_id).re_energy=node(receive_id).re_energy-re_energy_consum;
         
         %记录消息数量和通信能耗
         messages(1)=messages(1)+1;
         messages(2)=messages(2)+send_energy_consum+re_energy_consum;
end