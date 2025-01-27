%% Load data

load('currwork.mat')

%%
A = linsys1.A;
B = linsys1.B;
C = linsys1.C;
D = linsys1.D;

%%
Qc = ctrb(A,B);
Q = eye(3);
Q(1,1) = 1;
Q(2,2) = 10;
Q(3,3) = 1/100;
R = 10;
[K S P] = lqr(A,B,Q,R)

