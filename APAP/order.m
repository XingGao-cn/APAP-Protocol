%此函数用以每间断1(单位时间)，网络中n个源节点感应并开始发送数据包.N为网络中节点综述
function [p,Times]=order(N,n)
    Times=N/n;
    p=randperm(N);
end