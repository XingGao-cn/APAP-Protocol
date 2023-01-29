function [Sum,E2E,redundancy]=statistics_net_realibility(node,N)
    %此函数统计运行一轮后sink接收的数据包数量与端到端可靠性+sink数据包冗余数量
    Sum=length(node(N+1).receive);
    Re=length(unique(node(N+1).receive));
    E2E=Re/N;
    redundancy=Sum-Re;
end