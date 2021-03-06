clc; close all; clear all;

global G C b;

NrNodes = 5;

G = sparse(NrNodes,NrNodes); 
C = sparse(NrNodes,NrNodes);
b = sparse(NrNodes,1);

OutputNodes = [ 3 5 ];


vol(1,0,1);
res(1,2,1);
cap(1,2,0.25);
res(2,0,2);
ind(2,3,0.2);
xr = res_curr(3,0,10);
ccvs(4,0,xr,100);
res(4,5,0.1);
res(5,0,1000);


Vin_start = -10;
Vin_stop = 10;
step_size = 0.2;

Vin_vec = Vin_start:step_size:Vin_stop;

X_old = zeros(size(G,1),1);



for n = 1:numel(Vin_vec)
    V = Vin_vec(n);
    
    LHS = G + C/step_size;

    RHS = C/step_size * X_old + b*V;

    X_old = LHS\RHS;

    V3(n) = X_old(3);
    VOUT(n) = X_old(5);
end

figure()
plot(Vin_vec,VOUT)
hold on
plot(Vin_vec, V3)
legend('Vout','V3')


fmin = 0;
fmax = 100/(2*pi);
nrpt = 1000;

F = linspace(fmin,fmax,nrpt);

for n = 1:nrpt
    w = 2*pi*F(n);
    s = 1i*w;
    A = G+s*C;

    [L,U,P,Q] = lu(sparse(A));
    z = L\(P*b);
    y = U\z;
    X = Q*y;

    V3_2(n) = X(3);
    VOUT_2(n) = X(5);

    Gain(n) = 20 * log(X(5)/X(1));

end

figure()
plot(F,VOUT_2)
hold on
plot(F, V3_2)
legend('Vout','V3')

figure()
plot(F,Gain)

caps = randn(1,1000) * 0.05;
caps = caps + 0.25;

figure()
histogram(caps)

w = pi;
s = 1i * w;


for n = 1:length(caps)

    G = sparse(NrNodes,NrNodes); 
C = sparse(NrNodes,NrNodes);
b = sparse(NrNodes,1);

    vol(1,0,1);
    res(1,2,1);
    cap(1,2,caps(n));
    res(2,0,2);
    ind(2,3,0.2);
    xr = res_curr(3,0,10);
    ccvs(4,0,xr,100);
    res(4,5,0.1);
    res(5,0,1000);

    A = G + s *C;

    [L,U,P,Q] = lu(sparse(A));
    z = L\(P*b);
    y = U\z;
    X = Q*y;

    Gain_caps(n) = 20 * log(X(5)/X(1));

end

real_gain = real(Gain_caps);

figure()
histogram(real_gain)
