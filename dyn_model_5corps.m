function [gamma,ZMP,Reaction_Force,vfoot2_toe,vfoot2_heel,ddCG_Biped]=dyn_model_5corps(q, dq, ddq)

global m1 m2 m3 m4 m5 m6 m7 m8 m9 mp M 
global I1 I2 I3 I4 I5 I6 I7 I8 I9 Ip1 Ip2 
global g L1 L2 L3 L4 L5 L6 L8 s1 s2 s3 s4 s5 s6 s7 s8 s9 sb spx spy 
global Ycp Xcp hp Lp ld lg lp
global foot2 

%% Position vector
q1 = q(1);
q2 = q(2);
q3 = q(3);
q4 = q(4);
q5 = q(5);
q6 = q(6);
q7 = q(7);
q8 = q(8);
q9 = q(9);
qp2 = q(10);
qp1=0; %support foot angle
% q=[q1 q2 q3 q4 q5 q6 q7 q8 q9 qp2].';

%% Velocity vector
dq1 = dq(1);
dq2 = dq(2);
dq3 = dq(3);
dq4 = dq(4);
dq5 = dq(5);
dq6 = dq(6);
dq7 = dq(7);
dq8 = dq(8);
dq9 = dq(9);
dqp2 = dq(10);
dqp1=0;
dq=[dq1 dq2 dq3 dq4 dq5 dq6 dq7 dq8 dq9 dqp2].';

%% Acceleration vector
ddq1 = ddq(1);
ddq2 = ddq(2);
ddq3 = ddq(3);
ddq4 = ddq(4);
ddq5 = ddq(5);
ddq6 = ddq(6);
ddq7 = ddq(7);
ddq8 = ddq(8);
ddq9 = ddq(9);
ddqp2 = ddq(10);
ddqp1 = 0;

%K=12.5;
K=0;
theta_bras=[0 0 ((2*q3-q8-q6)) 0 0 (q6-q3) 0 (q8-q3) 0 0]';
K_THETA=K*theta_bras;

%% Model NOTATION: Spong and Vidyasagar, page 142, Eq. (6.3.12)
%%                 D(q)ddq + C(q,dq)*dq + G(q) = B*tau
%%
D =[
 
 I1 + 2*L1^2*m1 + 2*L1^2*m2 + L1^2*m3 + 2*L1^2*m6 + 2*L1^2*m7 + L1^2*mp + m1*s1^2 - 2*L1*m1*s1,               L1*cos(q1 - q2)*(L2*m1 + 2*L2*m2 + L2*m3 + 2*L2*m6 + 2*L2*m7 + L2*mp - m2*s2), L1*cos(q1 - q3)*(m3*s3 + 2*m6*sb + 2*m7*sb),      -L1*cos(q1 - q4)*(L2*m1 + L2*mp + m2*s2),              -L1*cos(q1 - q5)*(L1*mp + m1*s1), -L1*cos(q1 - q6)*(L6*m7 + m6*s6), -L1*m7*s7*cos(q1 - q7), -L1*cos(q1 - q8)*(L6*m7 + m6*s6), -L1*m7*s7*cos(q1 - q9), -L1*mp*(spy*cos(q1 - qp2) + spx*sin(q1 - qp2));
                 L1*cos(q1 - q2)*(L2*m1 + 2*L2*m2 + L2*m3 + 2*L2*m6 + 2*L2*m7 + L2*mp - m2*s2), I2 + L2^2*m1 + 2*L2^2*m2 + L2^2*m3 + 2*L2^2*m6 + 2*L2^2*m7 + L2^2*mp + m2*s2^2 - 2*L2*m2*s2, L2*cos(q2 - q3)*(m3*s3 + 2*m6*sb + 2*m7*sb),      -L2*cos(q2 - q4)*(L2*m1 + L2*mp + m2*s2),              -L2*cos(q2 - q5)*(L1*mp + m1*s1), -L2*cos(q2 - q6)*(L6*m7 + m6*s6), -L2*m7*s7*cos(q2 - q7), -L2*cos(q2 - q8)*(L6*m7 + m6*s6), -L2*m7*s7*cos(q2 - q9), -L2*mp*(spy*cos(q2 - qp2) + spx*sin(q2 - qp2));
                                                   L1*cos(q1 - q3)*(m3*s3 + 2*m6*sb + 2*m7*sb),                                                 L2*cos(q2 - q3)*(m3*s3 + 2*m6*sb + 2*m7*sb),        I3 + m3*s3^2 + 2*m6*sb^2 + 2*m7*sb^2,                                             0,                                             0, -sb*cos(q3 - q6)*(L6*m7 + m6*s6), -m7*s7*sb*cos(q3 - q7), -sb*cos(q3 - q8)*(L6*m7 + m6*s6), -m7*s7*sb*cos(q3 - q9),                                              0;
                                                      -L1*cos(q1 - q4)*(L2*m1 + L2*mp + m2*s2),                                                    -L2*cos(q2 - q4)*(L2*m1 + L2*mp + m2*s2),                                           0,              I2 + L2^2*m1 + L2^2*mp + m2*s2^2,               L2*cos(q4 - q5)*(L1*mp + m1*s1),                                0,                      0,                                0,                      0,  L2*mp*(spy*cos(q4 - qp2) + spx*sin(q4 - qp2));
                                                              -L1*cos(q1 - q5)*(L1*mp + m1*s1),                                                            -L2*cos(q2 - q5)*(L1*mp + m1*s1),                                           0,               L2*cos(q4 - q5)*(L1*mp + m1*s1),                        mp*L1^2 + m1*s1^2 + I1,                                0,                      0,                                0,                      0,  L1*mp*(spy*cos(q5 - qp2) + spx*sin(q5 - qp2));
                                                              -L1*cos(q1 - q6)*(L6*m7 + m6*s6),                                                            -L2*cos(q2 - q6)*(L6*m7 + m6*s6),            -sb*cos(q3 - q6)*(L6*m7 + m6*s6),                                             0,                                             0,           m7*L6^2 + m6*s6^2 + I6,  L6*m7*s7*cos(q6 - q7),                                0,                      0,                                              0;
                                                                        -L1*m7*s7*cos(q1 - q7),                                                                      -L2*m7*s7*cos(q2 - q7),                      -m7*s7*sb*cos(q3 - q7),                                             0,                                             0,            L6*m7*s7*cos(q6 - q7),           m7*s7^2 + I7,                                0,                      0,                                              0;
                                                              -L1*cos(q1 - q8)*(L6*m7 + m6*s6),                                                            -L2*cos(q2 - q8)*(L6*m7 + m6*s6),            -sb*cos(q3 - q8)*(L6*m7 + m6*s6),                                             0,                                             0,                                0,                      0,           m7*L6^2 + m6*s6^2 + I6,  L6*m7*s7*cos(q8 - q9),                                              0;
                                                                        -L1*m7*s7*cos(q1 - q9),                                                                      -L2*m7*s7*cos(q2 - q9),                      -m7*s7*sb*cos(q3 - q9),                                             0,                                             0,                                0,                      0,            L6*m7*s7*cos(q8 - q9),           m7*s7^2 + I7,                                              0;
                                                -L1*mp*(spy*cos(q1 - qp2) + spx*sin(q1 - qp2)),                                              -L2*mp*(spy*cos(q2 - qp2) + spx*sin(q2 - qp2)),                                           0, L2*mp*(spy*cos(q4 - qp2) + spx*sin(q4 - qp2)), L1*mp*(spy*cos(q5 - qp2) + spx*sin(q5 - qp2)),                                0,                      0,                                0,                      0,                      mp*spx^2 + mp*spy^2 + Ip2];

%%
%%
C =[
 
                                                                                  0, L1*dq2*sin(q1 - q2)*(L2*m1 + 2*L2*m2 + L2*m3 + 2*L2*m6 + 2*L2*m7 + L2*mp - m2*s2), L1*dq3*sin(q1 - q3)*(m3*s3 + 2*m6*sb + 2*m7*sb),      -L1*dq4*sin(q1 - q4)*(L2*m1 + L2*mp + m2*s2),              -L1*dq5*sin(q1 - q5)*(L1*mp + m1*s1), -L1*dq6*sin(q1 - q6)*(L6*m7 + m6*s6), -L1*dq7*m7*s7*sin(q1 - q7), -L1*dq8*sin(q1 - q8)*(L6*m7 + m6*s6), -L1*dq9*m7*s7*sin(q1 - q9),  L1*dqp2*mp*(spx*cos(q1 - qp2) - spy*sin(q1 - qp2));
 -L1*dq1*sin(q1 - q2)*(L2*m1 + 2*L2*m2 + L2*m3 + 2*L2*m6 + 2*L2*m7 + L2*mp - m2*s2),                                                                                 0, L2*dq3*sin(q2 - q3)*(m3*s3 + 2*m6*sb + 2*m7*sb),      -L2*dq4*sin(q2 - q4)*(L2*m1 + L2*mp + m2*s2),              -L2*dq5*sin(q2 - q5)*(L1*mp + m1*s1), -L2*dq6*sin(q2 - q6)*(L6*m7 + m6*s6), -L2*dq7*m7*s7*sin(q2 - q7), -L2*dq8*sin(q2 - q8)*(L6*m7 + m6*s6), -L2*dq9*m7*s7*sin(q2 - q9),  L2*dqp2*mp*(spx*cos(q2 - qp2) - spy*sin(q2 - qp2));
                                   -L1*dq1*sin(q1 - q3)*(m3*s3 + 2*m6*sb + 2*m7*sb),                                  -L2*dq2*sin(q2 - q3)*(m3*s3 + 2*m6*sb + 2*m7*sb),                                               0,                                                 0,                                                 0, -dq6*sb*sin(q3 - q6)*(L6*m7 + m6*s6), -dq7*m7*s7*sb*sin(q3 - q7), -dq8*sb*sin(q3 - q8)*(L6*m7 + m6*s6), -dq9*m7*s7*sb*sin(q3 - q9),                                                   0;
                                        L1*dq1*sin(q1 - q4)*(L2*m1 + L2*mp + m2*s2),                                       L2*dq2*sin(q2 - q4)*(L2*m1 + L2*mp + m2*s2),                                               0,                                                 0,               L2*dq5*sin(q4 - q5)*(L1*mp + m1*s1),                                    0,                          0,                                    0,                          0, -L2*dqp2*mp*(spx*cos(q4 - qp2) - spy*sin(q4 - qp2));
                                                L1*dq1*sin(q1 - q5)*(L1*mp + m1*s1),                                               L2*dq2*sin(q2 - q5)*(L1*mp + m1*s1),                                               0,              -L2*dq4*sin(q4 - q5)*(L1*mp + m1*s1),                                                 0,                                    0,                          0,                                    0,                          0, -L1*dqp2*mp*(spx*cos(q5 - qp2) - spy*sin(q5 - qp2));
                                                L1*dq1*sin(q1 - q6)*(L6*m7 + m6*s6),                                               L2*dq2*sin(q2 - q6)*(L6*m7 + m6*s6),             dq3*sb*sin(q3 - q6)*(L6*m7 + m6*s6),                                                 0,                                                 0,                                    0,  L6*dq7*m7*s7*sin(q6 - q7),                                    0,                          0,                                                   0;
                                                          L1*dq1*m7*s7*sin(q1 - q7),                                                         L2*dq2*m7*s7*sin(q2 - q7),                       dq3*m7*s7*sb*sin(q3 - q7),                                                 0,                                                 0,           -L6*dq6*m7*s7*sin(q6 - q7),                          0,                                    0,                          0,                                                   0;
                                                L1*dq1*sin(q1 - q8)*(L6*m7 + m6*s6),                                               L2*dq2*sin(q2 - q8)*(L6*m7 + m6*s6),             dq3*sb*sin(q3 - q8)*(L6*m7 + m6*s6),                                                 0,                                                 0,                                    0,                          0,                                    0,  L6*dq9*m7*s7*sin(q8 - q9),                                                   0;
                                                          L1*dq1*m7*s7*sin(q1 - q9),                                                         L2*dq2*m7*s7*sin(q2 - q9),                       dq3*m7*s7*sb*sin(q3 - q9),                                                 0,                                                 0,                                    0,                          0,           -L6*dq8*m7*s7*sin(q8 - q9),                          0,                                                   0;
                                 -L1*dq1*mp*(spx*cos(q1 - qp2) - spy*sin(q1 - qp2)),                                -L2*dq2*mp*(spx*cos(q2 - qp2) - spy*sin(q2 - qp2)),                                               0, L2*dq4*mp*(spx*cos(q4 - qp2) - spy*sin(q4 - qp2)), L1*dq5*mp*(spx*cos(q5 - qp2) - spy*sin(q5 - qp2)),                                    0,                          0,                                    0,                          0,                                                   0];
 

%%
%%

G =[
 
 -g*sin(q1)*(2*L1*m1 + 2*L1*m2 + L1*m3 + 2*L1*m6 + 2*L1*m7 + L1*mp - m1*s1);
   -g*sin(q2)*(L2*m1 + 2*L2*m2 + L2*m3 + 2*L2*m6 + 2*L2*m7 + L2*mp - m2*s2);
                                     -g*sin(q3)*(m3*s3 + 2*m6*sb + 2*m7*sb);
                                          g*sin(q4)*(L2*m1 + L2*mp + m2*s2);
                                                  g*sin(q5)*(L1*mp + m1*s1);
                                                  g*sin(q6)*(L6*m7 + m6*s6);
                                                            g*m7*s7*sin(q7);
                                                  g*sin(q8)*(L6*m7 + m6*s6);
                                                            g*m7*s7*sin(q9);
                                         g*mp*(spx*cos(qp2) + spy*sin(qp2))];
 
%%
%%
%% The matric B for virtual work is
% B=eye(6);
% B(1,2) = -1;
% B(2,3)= -1;
% B(3,4)= -1;
% B(4,5)= -1;
% B(5,6)= -1;

B =[
 1, -1,  0,  0,  0,  0,  0,  0, 0, 0;
 0,  1, -1,  0,  0,  0,  0,  0, 0, 0;
 0,  0,  1, -1,  0, -1,  0, -1, 0, 0;
 0,  0,  0,  1, -1,  0,  0,  0, 0, 0;
 0,  0,  0,  0,  1,  0,  0,  0, 0,-1;
 0,  0,  0,  0,  0,  1, -1,  0, 0, 0;
 0,  0,  0,  0,  0,  0,  1,  0, 0, 0;
 0,  0,  0,  0,  0,  0,  0,  1,-1, 0;
 0,  0,  0,  0,  0,  0,  0,  0, 1, 0;
 0,  0,  0,  0,  0,  0,  0,  0, 0, 1];


%% Dynamic Model
%% D(q)ddq + C(q,dq)*dq + G(q) = B*tau
% to calculate joint torques we have
gamma=B\(D*ddq + C*dq + G);
%gamma=B\(D*ddq + C*dq + G + K_THETA);
%%
gravity=[0;-g];
%acceleration and reaction forces calculated by reduced model

ddCG_Biped =[
                                                      (dq3*(dq3*m3*s3*sin(q3) + 2*dq3*m6*sb*sin(q3) + 2*dq3*m7*sb*sin(q3)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) + (dq1*(2*L1*dq1*m1*sin(q1) + 2*L1*dq1*m2*sin(q1) + L1*dq1*m3*sin(q1) + 2*L1*dq1*m6*sin(q1) + 2*L1*dq1*m7*sin(q1) + L1*dq1*mp*sin(q1) - dq1*m1*s1*sin(q1)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) + (dq2*(L2*dq2*m1*sin(q2) + 2*L2*dq2*m2*sin(q2) + L2*dq2*m3*sin(q2) + 2*L2*dq2*m6*sin(q2) + 2*L2*dq2*m7*sin(q2) + L2*dq2*mp*sin(q2) - dq2*m2*s2*sin(q2)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) - (ddq1*(m1*(L1*cos(q1) - s1*cos(q1)) + L1*m1*cos(q1) + 2*L1*m2*cos(q1) + L1*m3*cos(q1) + 2*L1*m6*cos(q1) + 2*L1*m7*cos(q1) + L1*mp*cos(q1)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) - (ddq2*(m2*(L2*cos(q2) - s2*cos(q2)) + L2*m1*cos(q2) + L2*m2*cos(q2) + L2*m3*cos(q2) + 2*L2*m6*cos(q2) + 2*L2*m7*cos(q2) + L2*mp*cos(q2)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) - (dq6*(L6*dq6*m7*sin(q6) + dq6*m6*s6*sin(q6)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) - (dq8*(L6*dq8*m7*sin(q8) + dq8*m6*s6*sin(q8)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) - (dq5*(L1*dq5*mp*sin(q5) + dq5*m1*s1*sin(q5)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) + (ddq4*(m2*s2*cos(q4) + L2*m1*cos(q4) + L2*mp*cos(q4)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) + (ddq6*(m6*s6*cos(q6) + L6*m7*cos(q6)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) + (ddq8*(m6*s6*cos(q8) + L6*m7*cos(q8)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) + (ddq5*(m1*s1*cos(q5) + L1*mp*cos(q5)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) - (dqp2*(dqp2*mp*spx*cos(qp2) + dqp2*mp*spy*sin(qp2)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) - (ddq3*(m3*s3*cos(q3) + 2*m6*sb*cos(q3) + 2*m7*sb*cos(q3)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) - (dq4*(L2*dq4*m1*sin(q4) + L2*dq4*mp*sin(q4) + dq4*m2*s2*sin(q4)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) + (ddqp2*mp*(spy*cos(qp2) - spx*sin(qp2)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) - (dq7^2*m7*s7*sin(q7))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) - (dq9^2*m7*s7*sin(q9))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) + (ddq7*m7*s7*cos(q7))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) + (ddq9*m7*s7*cos(q9))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp);
 (dq6*(L6*dq6*m7*cos(q6) + dq6*m6*s6*cos(q6)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) - (dq2*(L2*dq2*m1*cos(q2) + 2*L2*dq2*m2*cos(q2) + L2*dq2*m3*cos(q2) + 2*L2*dq2*m6*cos(q2) + 2*L2*dq2*m7*cos(q2) - L1*dq2*mp*cos(q2) + 2*L2*dq2*mp*cos(q2) - dq2*m2*s2*cos(q2)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) - (ddq2*(m2*(L2*sin(q2) - s2*sin(q2)) - mp*(L1*sin(q2) - L2*sin(q2)) + L2*m1*sin(q2) + L2*m2*sin(q2) + L2*m3*sin(q2) + 2*L2*m6*sin(q2) + 2*L2*m7*sin(q2) + L2*mp*sin(q2)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) + (dq8*(L6*dq8*m7*cos(q8) + dq8*m6*s6*cos(q8)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) + (dq5*(L1*dq5*mp*cos(q5) + dq5*m1*s1*cos(q5)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) + (dqp2*(dqp2*mp*spy*cos(qp2) - dqp2*mp*spx*sin(qp2)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) + (dq4*(L2*dq4*m1*cos(q4) + L2*dq4*mp*cos(q4) + dq4*m2*s2*cos(q4)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) + (ddq4*(m2*s2*sin(q4) + L2*m1*sin(q4) + L2*mp*sin(q4)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) + (ddq6*(m6*s6*sin(q6) + L6*m7*sin(q6)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) + (ddq8*(m6*s6*sin(q8) + L6*m7*sin(q8)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) + (ddq5*(m1*s1*sin(q5) + L1*mp*sin(q5)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) - (ddq1*(m1*(L1*sin(q1) - s1*sin(q1)) + L1*m1*sin(q1) + 2*L1*m2*sin(q1) + L1*m3*sin(q1) + 2*L1*m6*sin(q1) + 2*L1*m7*sin(q1) + L1*mp*sin(q1)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) - (dq1*(2*L1*dq1*m1*cos(q1) + 2*L1*dq1*m2*cos(q1) + L1*dq1*m3*cos(q1) + 2*L1*dq1*m6*cos(q1) + 2*L1*dq1*m7*cos(q1) + L1*dq1*mp*cos(q1) - dq1*m1*s1*cos(q1)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) - (dq3*(dq3*m3*s3*cos(q3) + 2*dq3*m6*sb*cos(q3) + 2*dq3*m7*sb*cos(q3)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) - (ddq3*(m3*s3*sin(q3) + 2*m6*sb*sin(q3) + 2*m7*sb*sin(q3)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) + (ddqp2*mp*(spx*cos(qp2) + spy*sin(qp2)))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) + (dq7^2*m7*s7*cos(q7))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) + (dq9^2*m7*s7*cos(q9))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) + (ddq7*m7*s7*sin(q7))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp) + (ddq9*m7*s7*sin(q9))/(m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8 + m9 + 2*mp)];
 

Reaction_Force = M*(ddCG_Biped-gravity);
ZMP=(gamma(1)+spx*mp*g-hp*Reaction_Force(1))/Reaction_Force(2);

vfoot2_toe =[ L2*dq4*cos(q4) - L1*dq1*cos(q1) - L2*dq2*cos(q2) - dqp2*((ld*sin(qp2)) - hp*cos(qp2)) + L1*dq5*cos(q5);
              L2*dq4*sin(q4) - L1*dq1*sin(q1) - L2*dq2*sin(q2) + dqp2*((ld*cos(qp2)) + hp*sin(qp2)) + L1*dq5*sin(q5)];

 
vfoot2_heel =[ dqp2*((lg*sin(qp2))+ hp*cos(qp2)) - L1*dq1*cos(q1) - L2*dq2*cos(q2) + L2*dq4*cos(q4) + L1*dq5*cos(q5);
                L2*dq4*sin(q4) - L1*dq1*sin(q1) - L2*dq2*sin(q2) - dqp2*((lg*cos(qp2)) - hp*sin(qp2)) + L1*dq5*sin(q5)];
            
return
 
 















