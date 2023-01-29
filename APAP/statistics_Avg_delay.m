function [delay_Arry,avg_Delay]=statistics_Avg_delay(node,N)
    %统计网络平均延迟
    num=length(unique(node(N+1).receive));
    delay_Arry=zeros(1,N*N);
    for i=1:length(node(N+1).Data)-1
        if delay_Arry(i)==0
            delay_Arry(i)=node(N+1).Data(i).delay;
        else
            if node(N+1).Data(i).delay<delay_Arry(i)
                delay_Arry(i)=node(N+1).Data(i).delay;
            end
        end
        
    end
    avg_Delay=sum(delay_Arry)/num;
end