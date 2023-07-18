%plot the ring area of given netweok
function draw_node_ring(selection_x,selection_y,circle_num, ring)
    
for i=1:1:length(circle_num)
    switch(ring)
        case {1}  %一定要换行，否则会出错
            plot(selection_x,selection_y,'bo','MarkerFaceColor','b'); break;  %画第一环节点
        case {2}   %一定要换行，否则会出错
            plot(selection_x,selection_y,'go','MarkerFaceColor','g'); break;  %画第二环节点
        case {3}   %一定要换行，否则会出错
            plot(selection_x,selection_y,'mo','MarkerFaceColor','m'); break;  %画第三环节点
        case {4}  
            plot(selection_x,selection_y,'yo','MarkerFaceColor','y'); break;  %画第四环节点
        case {5} 
            plot(selection_x,selection_y,'co','MarkerFaceColor','c'); break;  %画第五环节点
        case {6}
            plot(selection_x,selection_y,'ko','MarkerFaceColor','w'); break;  %画第六环节点         
        case {7} 
            plot(selection_x,selection_y,'ko','MarkerFaceColor','k'); break;  %画第七环节点    
        case {8} 
            plot(selection_x,selection_y,'ko','MarkerFaceColor','g'); break;  %画第八环节点    
        case {9} 
            plot(selection_x,selection_y,'ko','MarkerFaceColor','w'); break;  %画第九环节点    
        case {10} 
            plot(selection_x,selection_y,'ko','MarkerFaceColor','w'); break;  %画第十环节点    
        case {11} 
            plot(selection_x,selection_y,'ko','MarkerFaceColor','w'); break;  %画第十一环节点    
        case {12} 
            plot(selection_x,selection_y,'ko','MarkerFaceColor','g'); break;  %画第八环节点    
        case {13} 
            plot(selection_x,selection_y,'ko','MarkerFaceColor','w'); break;  %画第九环节点    
        case {14} 
            plot(selection_x,selection_y,'ko','MarkerFaceColor','w'); break;  %画第十环节点    
        case {15} 
            plot(selection_x,selection_y,'ko','MarkerFaceColor','w'); break;  %画第十一环节点
        case {16}
            plot(selection_x,selection_y,'ko','MarkerFaceColor','w'); break;  %画第六环节点         
        case {17} 
            plot(selection_x,selection_y,'ko','MarkerFaceColor','k'); break;  %画第七环节点    
        case {18} 
            plot(selection_x,selection_y,'ko','MarkerFaceColor','g'); break;  %画第八环节点    
        case {19} 
            plot(selection_x,selection_y,'ko','MarkerFaceColor','w'); break;  %画第九环节点    
        case {20} 
            plot(selection_x,selection_y,'ko','MarkerFaceColor','w'); break;  %画第十环节点    
        case {21} 
            plot(selection_x,selection_y,'ko','MarkerFaceColor','w'); break;  %画第十一环节点    
        case {22} 
            plot(selection_x,selection_y,'ko','MarkerFaceColor','g'); break;  %画第八环节点    
        case {23} 
            plot(selection_x,selection_y,'ko','MarkerFaceColor','w'); break;  %画第九环节点    
        case {24} 
            plot(selection_x,selection_y,'ko','MarkerFaceColor','w'); break;  %画第十环节点    
        case {25} 
            plot(selection_x,selection_y,'ko','MarkerFaceColor','w'); break;  %画第十一环节点   
    end    
    axis on;
    hold on;
end 

