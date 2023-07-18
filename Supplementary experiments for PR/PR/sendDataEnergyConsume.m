    %此函数为发送能量损耗模型
%databits为数据包的比特数，也就是数据包大小
%eperbit即为elec
function send_energy_consum = sendDataEnergyConsume(distance,databits,thresholdDistance,eperbit,amp,fs)

         if distance <= thresholdDistance
    		send_energy_consum = (eperbit+fs*distance*distance)*databits;
    	 else
    		 send_energy_consum = (eperbit+amp*distance*distance*distance*distance)*databits;
    	 
         end
     