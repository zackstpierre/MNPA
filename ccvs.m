function ccvs(nd1,nd2,curr,val)
% Adds the stamp of a dependent voltage-controlled 
% voltage-source(VCVS)to the matrices in circuit 
% representation.
%
%   ni1 O-------(+)        |----------o nd1
%                          |
%                         /+\
%                      | /   \    Vnd1-Vnd2 = val*(Vni1-Vni2)
%                Ivcvs | \   /
%                      V  \-/ 
%                          |
%   ni2 O-------(-)        |----------o nd2
%
%  (1) "nd1 & nd2" are the nodes across the dependent
%                  voltage source.
%  (2) "ni1 & ni2" are the nodes corresponding to the 
%                  controller voltage
%
%   nd1: (+) node   \
%   nd2: (-) node   |----->  Vnd1-Vnd2 = val*(Vni1-Vni2)
%   ni1: (+) node   |
%   ni2: (-) node   /
%---------------------------------------------------------------

global G C b

d = size(G,1);
xr = d +1;
b(xr,1) = 0;
G(xr,xr) = 0;
C(xr,xr) = 0;

G(xr,curr) = val;

if (nd1 ~=0)
   G(xr,nd1) = 1;
   G(nd1,xr) = 1;
end
if(nd2 ~= 0)
    G(xr,nd2) = -1;
    G(nd2,xr) = -1;
end
