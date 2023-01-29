function [Saving] = energySaving(nodee,id,packet_size)
%id为拦截节点号，packet_size为数据包大小
d0 = 87;                 %临界距离  
%packet_size=1024;       %根据论文数据包大小为1024bits
elec = 50*10^(-9);       %10-9 发射电路损耗能量
fs = 10*10^(-12);        %10-12  发射功率放大所需能量功率
amp = 0.0013*10^(-12) ;  %10-12  接收功率放大所需能量功率
    distance=nodee(id).dis;
    send_energy_consum = sendDataEnergyConsume(distance,packet_size,d0,elec,amp,fs);
    re_energy_consum = receiveDataEnergyConsume(packet_size,elec);
    Saving=send_energy_consum+re_energy_consum;
end

