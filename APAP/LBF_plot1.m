%LBF_plot for APAP
% function [LBF]=LBF_plot(node)
load("oneRound_newStrategy--900.mat");
len=ringNow

sumEnergy=0;
for i=1:length(node)-1
    if(node(i).re_energy<=initial_value)
        sumEnergy=sumEnergy+ (initial_value-node(i).re_energy);
    end
end
avgConsum = sumEnergy/(length(node)-1);

% for i=1:length(node)-1
%     ringNum=node(i).ring;
%     if(ringNum~=inf && ringNum~=0)
%         ringsEnergy(ringNum) = (initial_value-node(i).re_energy) + ringsEnergy(ringNum);
%     end
% end

str="node";
LBF1=zeros(1,len);

for i=1:len
     location = strcat(str,string(i));
     Len = length(eval(location));
     Sum=0;
     for j=1:length(node)-1
         if(node(j).ring==i)
            Sum = Sum+((initial_value-node(j).re_energy)- avgConsum)^2;
         end
     end
     i
     Sum
      LBF1(i)= sqrt(Sum/Len);
end
figure;
plot(LBF1,'-d')

    
% end