%此函数模拟单跳可靠性 保证一定丢包率
%This function simulates the single hop reliability to ensure a certain packet loss rate

function [rand_num]=reliability_rand
%r = a + (b-a).*rand(N,1) 生成区间 (a,b) 内的 N 个随机数。
%调用随机函数，该随机函数根据可靠性0.85  产生0 or 1 ，即85%产生1,15%产生0
alphabet= [0 1]; 
prob = [0.15 0.85];
rand_num=randsrc(1,1,[alphabet; prob]) ;  %rand_num的值为0 或者 1
end

