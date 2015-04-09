function [output, ZMPx_impact, R_Force_impact_foot2] = model_Impact_SS1(q_dq)

global m1 m2 m3 m4 m5 m6 m7 m8 m9 mp M 
global I1 I2 I3 I4 I5 I6 I7 I8 I9 Ip1 Ip2 
global g L1 L2 L3 L4 L5 L6 L8 s1 s2 s3 s4 s5 s6 s7 s8 s9 sb spx spy 
global Ycp Xcp hp Lp ld lg lp
global dq_minus dela_impact

%% Position vector
q1 = q_dq(1);
q2 = q_dq(2);
q3 = q_dq(3);
q4 = q_dq(4);
q5 = q_dq(5);
q6 = q_dq(6);
q7 = q_dq(7);
q8 = q_dq(8);
q9 = q_dq(9);
qp2 = q_dq(10);
qp1=0;

% q=[q1 q2 q3 q4 q5 q6 q7 q8 q9 qp1 qp2 xh yh].';

%% Position vector
dq1 = q_dq(11);
dq2 = q_dq(12);
dq3 = q_dq(13);
dq4 = q_dq(14);
dq5 = q_dq(15);
dq6 = q_dq(16);
dq7 = q_dq(17);
dq8 = q_dq(18);
dq9 = q_dq(19);
dqp2 = q_dq(20);
dqp1=0;
dxh = -L1*dq1*cos(q1) - L2*dq2*cos(q2);
dyh= -L1*dq1*sin(q1) - L2*dq2*sin(q2);

dq=[dq1 dq2 dq3 dq4 dq5 dq6 dq7 dq8 dq9 dqp1 dqp2 dxh dyh].';

%% Model NOTATION: Spong and Vidyasagar, page 142, Eq. (6.3.12)
%%                 D(q)ddq + C(q,dq)*dq + G(q) = B*tau
D =[
                                                                                    mp*L1^2 + m1*s1^2 + I1, mp*sin(q1)*sin(q2)*L1^2 + L2*mp*cos(q1)*cos(q2)*L1 + L2*m1*s1*cos(q1)*cos(q2) + L2*m1*s1*sin(q1)*sin(q2),                                    0,                                             0,                                             0,                                0,                      0,                                0,                      0,                                             L1*mp*(spy*cos(q1 - qp1) + spx*sin(q1 - qp1)),                                             0,               cos(q1)*(L1*mp + m1*s1),               sin(q1)*(L1*mp + m1*s1);
 mp*sin(q1)*sin(q2)*L1^2 + L2*mp*cos(q1)*cos(q2)*L1 + L2*m1*s1*cos(q1)*cos(q2) + L2*m1*s1*sin(q1)*sin(q2),                                 mp*L1^2 - mp*L1^2*cos(q2)^2 + mp*L2^2*cos(q2)^2 + m1*L2^2 + m2*s2^2 + I2,                                    0,                                             0,                                             0,                                0,                      0,                                0,                      0, L2*mp*cos(q2)*(spy*cos(qp1) - spx*sin(qp1)) + L1*mp*sin(q2)*(spx*cos(qp1) + spy*sin(qp1)),                                             0,       cos(q2)*(L2*m1 + L2*mp + m2*s2),       sin(q2)*(L2*m1 + L1*mp + m2*s2);
                                                                                                        0,                                                                                                        0, I3 + m3*s3^2 + 2*m6*sb^2 + 2*m7*sb^2,                                             0,                                             0, -sb*cos(q3 - q6)*(L6*m7 + m6*s6), -m7*s7*sb*cos(q3 - q7), -sb*cos(q3 - q8)*(L6*m7 + m6*s6), -m7*s7*sb*cos(q3 - q9),                                                                                         0,                                             0,  -cos(q3)*(m3*s3 + 2*m6*sb + 2*m7*sb),  -sin(q3)*(m3*s3 + 2*m6*sb + 2*m7*sb);
                                                                                                        0,                                                                                                        0,                                    0,              I2 + L2^2*m1 + L2^2*mp + m2*s2^2,               L2*cos(q4 - q5)*(L1*mp + m1*s1),                                0,                      0,                                0,                      0,                                                                                         0, L2*mp*(spy*cos(q4 - qp2) + spx*sin(q4 - qp2)),       cos(q4)*(L2*m1 + L2*mp + m2*s2),       sin(q4)*(L2*m1 + L2*mp + m2*s2);
                                                                                                        0,                                                                                                        0,                                    0,               L2*cos(q4 - q5)*(L1*mp + m1*s1),                        mp*L1^2 + m1*s1^2 + I1,                                0,                      0,                                0,                      0,                                                                                         0, L1*mp*(spy*cos(q5 - qp2) + spx*sin(q5 - qp2)),               cos(q5)*(L1*mp + m1*s1),               sin(q5)*(L1*mp + m1*s1);
                                                                                                        0,                                                                                                        0,     -sb*cos(q3 - q6)*(L6*m7 + m6*s6),                                             0,                                             0,           m7*L6^2 + m6*s6^2 + I6,  L6*m7*s7*cos(q6 - q7),                                0,                      0,                                                                                         0,                                             0,               cos(q6)*(L6*m7 + m6*s6),               sin(q6)*(L6*m7 + m6*s6);
                                                                                                        0,                                                                                                        0,               -m7*s7*sb*cos(q3 - q7),                                             0,                                             0,            L6*m7*s7*cos(q6 - q7),           m7*s7^2 + I7,                                0,                      0,                                                                                         0,                                             0,                         m7*s7*cos(q7),                         m7*s7*sin(q7);
                                                                                                        0,                                                                                                        0,     -sb*cos(q3 - q8)*(L6*m7 + m6*s6),                                             0,                                             0,                                0,                      0,           m7*L6^2 + m6*s6^2 + I6,  L6*m7*s7*cos(q8 - q9),                                                                                         0,                                             0,               cos(q8)*(L6*m7 + m6*s6),               sin(q8)*(L6*m7 + m6*s6);
                                                                                                        0,                                                                                                        0,               -m7*s7*sb*cos(q3 - q9),                                             0,                                             0,                                0,                      0,            L6*m7*s7*cos(q8 - q9),           m7*s7^2 + I7,                                                                                         0,                                             0,                         m7*s7*cos(q9),                         m7*s7*sin(q9);
                                                            L1*mp*(spy*cos(q1 - qp1) + spx*sin(q1 - qp1)),                L2*mp*cos(q2)*(spy*cos(qp1) - spx*sin(qp1)) + L1*mp*sin(q2)*(spx*cos(qp1) + spy*sin(qp1)),                                    0,                                             0,                                             0,                                0,                      0,                                0,                      0,                                                                 mp*spx^2 + mp*spy^2 + Ip1,                                             0,      mp*(spy*cos(qp1) - spx*sin(qp1)),      mp*(spx*cos(qp1) + spy*sin(qp1));
                                                                                                        0,                                                                                                        0,                                    0, L2*mp*(spy*cos(q4 - qp2) + spx*sin(q4 - qp2)), L1*mp*(spy*cos(q5 - qp2) + spx*sin(q5 - qp2)),                                0,                      0,                                0,                      0,                                                                                         0,                     mp*spx^2 + mp*spy^2 + Ip2,      mp*(spy*cos(qp2) - spx*sin(qp2)),      mp*(spx*cos(qp2) + spy*sin(qp2));
                                                                                  cos(q1)*(L1*mp + m1*s1),                                                                          cos(q2)*(L2*m1 + L2*mp + m2*s2), -cos(q3)*(m3*s3 + 2*m6*sb + 2*m7*sb),               cos(q4)*(L2*m1 + L2*mp + m2*s2),                       cos(q5)*(L1*mp + m1*s1),          cos(q6)*(L6*m7 + m6*s6),          m7*s7*cos(q7),          cos(q8)*(L6*m7 + m6*s6),          m7*s7*cos(q9),                                                          mp*(spy*cos(qp1) - spx*sin(qp1)),              mp*(spy*cos(qp2) - spx*sin(qp2)), 2*m1 + 2*m2 + m3 + 2*m6 + 2*m7 + 2*mp,                                     0;
                                                                                  sin(q1)*(L1*mp + m1*s1),                                                                          sin(q2)*(L2*m1 + L1*mp + m2*s2), -sin(q3)*(m3*s3 + 2*m6*sb + 2*m7*sb),               sin(q4)*(L2*m1 + L2*mp + m2*s2),                       sin(q5)*(L1*mp + m1*s1),          sin(q6)*(L6*m7 + m6*s6),          m7*s7*sin(q7),          sin(q8)*(L6*m7 + m6*s6),          m7*s7*sin(q9),                                                          mp*(spx*cos(qp1) + spy*sin(qp1)),              mp*(spx*cos(qp2) + spy*sin(qp2)),                                     0, 2*m1 + 2*m2 + m3 + 2*m6 + 2*m7 + 2*mp];
 
%%
Ac2 =[
 0, 0, 0, L2*cos(q4), L1*cos(q5), 0, 0, 0, 0, 0, hp*cos(qp2), 1, 0;
 0, 0, 0, L2*sin(q4), L1*sin(q5), 0, 0, 0, 0, 0, hp*sin(qp2), 0, 1;
 0, 0, 0, 	0       ,       0   , 0, 0, 0, 0, 0,        1   , 0, 0];

%% Dynamic Model in Single Support Phase
 % D(q)ddq + C(q,dq)*dq + G(q) = B*tau + Ac2*R2
 % Ac2*ddq + Hc2*dq^2 = 0

dq_minus=dq;  %velocities just before impact
A_comp = [D   -Ac2';
          Ac2  zeros(3,3)];
B_comp = [D*dq_minus;
           zeros(3,1)];
Res = A_comp\B_comp;
dq_plus = Res(1:13); %Velocities just after impact including dx and dy
R_Force_impact_foot2 = Res(14:16); %[Ix, Iy, Mz]

ZMPx_impact=(R_Force_impact_foot2(3)-hp*R_Force_impact_foot2(1))/R_Force_impact_foot2(2);

dq_plus_red=dq_plus(1:10);
dela_impact=D*(dq_plus-dq_minus);
output = dq_plus_red;

return
 



