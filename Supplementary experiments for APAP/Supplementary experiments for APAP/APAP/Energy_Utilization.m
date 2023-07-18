%Compute the energy utilize ratio 
Energy_effiency=0;
totall=0;
for i=1:length(node)-1
    totall=totall+node(i).re_energy;
end


Energy_effiency=totall/(initial_value*(length(node)-1));