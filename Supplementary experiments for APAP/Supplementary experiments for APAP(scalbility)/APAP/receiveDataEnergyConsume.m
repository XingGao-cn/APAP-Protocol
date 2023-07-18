%此文件为模拟接受数据能量消耗
%接收功率的大小为定值 l*Elec
function re_energy_consum = receiveDataEnergyConsume(databits,eperbit)
    
       re_energy_consum =  databits*eperbit;%发射电路损耗能量*比特数
end
     