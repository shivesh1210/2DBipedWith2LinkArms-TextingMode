function [D,C,G,B,E,Dlin]= dyn_mod_biped_abs_red_arxy(q,dq,ddq)
%DYN_MOD_BIPED_ABS_RED_ARXY

%25-Mar-2015 11:27:41


%%
%% Authors: Alexander Yannick  and Franck
%%
%%
%% Model NOTATION: Spong and Vidyasagar, page 142, Eq. (6.3.12)
%%                 D(q)ddq + C(q,dq)*dq + G(q) = B*tau
%%
%%
[g,L1,L2,L3,L4,L5,m1,m2,m3,m4,m5,I1,I2,I3,I4,I5,s1,s2,s3,s4,s5]=modelParameters;
%%
%%
%%
%%
%%
%%
%%
%%
D=zeros(13,13);
D(1,1)=mp*L1^2 + m1*s1^2 + I1;
D(1,2)=L2*cos(q1 - q2)*(L1*mp + m1*s1);
D(1,10)=L1*hp*mp*cos(q1 - qp1);
D(1,12)=cos(q1)*(L1*mp + m1*s1);
D(1,13)=sin(q1)*(L1*mp + m1*s1);
D(2,1)=L2*cos(q1 - q2)*(L1*mp + m1*s1);
D(2,2)=I2 + L2^2*m1 + L2^2*mp + m2*s2^2;
D(2,10)=L2*hp*mp*cos(q2 - qp1);
D(2,12)=cos(q2)*(L2*m1 + L2*mp + m2*s2);
D(2,13)=sin(q2)*(L2*m1 + L2*mp + m2*s2);
D(3,3)=I3 + m3*s3^2 + 2*m6*sb^2 + 2*m7*sb^2;
D(3,6)=-sb*cos(q3 - q6)*(L6*m7 + m6*s6);
D(3,7)=-m7*s7*sb*cos(q3 - q7);
D(3,8)=-sb*cos(q3 - q8)*(L6*m7 + m6*s6);
D(3,9)=-m7*s7*sb*cos(q3 - q9);
D(3,12)=-cos(q3)*(m3*s3 + 2*m6*sb + 2*m7*sb);
D(3,13)=-sin(q3)*(m3*s3 + 2*m6*sb + 2*m7*sb);
D(4,4)=I2 + L2^2*m1 + L2^2*mp + m2*s2^2;
D(4,5)=L2*cos(q4 - q5)*(L1*mp + m1*s1);
D(4,11)=L2*hp*mp*cos(q4 - qp2);
D(4,12)=cos(q4)*(L2*m1 + L2*mp + m2*s2);
D(4,13)=sin(q4)*(L2*m1 + L2*mp + m2*s2);
D(5,4)=L2*cos(q4 - q5)*(L1*mp + m1*s1);
D(5,5)=mp*L1^2 + m1*s1^2 + I1;
D(5,11)=L1*hp*mp*cos(q5 - qp2);
D(5,12)=cos(q5)*(L1*mp + m1*s1);
D(5,13)=sin(q5)*(L1*mp + m1*s1);
D(6,3)=-sb*cos(q3 - q6)*(L6*m7 + m6*s6);
D(6,6)=m7*L6^2 + m6*s6^2 + I6;
D(6,7)=L6*m7*s7*cos(q6 - q7);
D(6,12)=cos(q6)*(L6*m7 + m6*s6);
D(6,13)=sin(q6)*(L6*m7 + m6*s6);
D(7,3)=-m7*s7*sb*cos(q3 - q7);
D(7,6)=L6*m7*s7*cos(q6 - q7);
D(7,7)=m7*s7^2 + I7;
D(7,12)=m7*s7*cos(q7);
D(7,13)=m7*s7*sin(q7);
D(8,3)=-sb*cos(q3 - q8)*(L6*m7 + m6*s6);
D(8,8)=m7*L6^2 + m6*s6^2 + I6;
D(8,9)=L6*m7*s7*cos(q8 - q9);
D(8,12)=cos(q8)*(L6*m7 + m6*s6);
D(8,13)=sin(q8)*(L6*m7 + m6*s6);
D(9,3)=-m7*s7*sb*cos(q3 - q9);
D(9,8)=L6*m7*s7*cos(q8 - q9);
D(9,9)=m7*s7^2 + I7;
D(9,12)=m7*s7*cos(q9);
D(9,13)=m7*s7*sin(q9);
D(10,1)=L1*hp*mp*cos(q1 - qp1);
D(10,2)=L2*hp*mp*cos(q2 - qp1);
D(10,10)=mp*hp^2 + Ip1;
D(10,12)=hp*mp*cos(qp1);
D(10,13)=hp*mp*sin(qp1);
D(11,4)=L2*hp*mp*cos(q4 - qp2);
D(11,5)=L1*hp*mp*cos(q5 - qp2);
D(11,11)=mp*hp^2 + Ip2;
D(11,12)=hp*mp*cos(qp2);
D(11,13)=hp*mp*sin(qp2);
D(12,1)=cos(q1)*(L1*mp + m1*s1);
D(12,2)=cos(q2)*(L2*m1 + L2*mp + m2*s2);
D(12,3)=-cos(q3)*(m3*s3 + 2*m6*sb + 2*m7*sb);
D(12,4)=cos(q4)*(L2*m1 + L2*mp + m2*s2);
D(12,5)=cos(q5)*(L1*mp + m1*s1);
D(12,6)=cos(q6)*(L6*m7 + m6*s6);
D(12,7)=m7*s7*cos(q7);
D(12,8)=cos(q8)*(L6*m7 + m6*s6);
D(12,9)=m7*s7*cos(q9);
D(12,10)=hp*mp*cos(qp1);
D(12,11)=hp*mp*cos(qp2);
D(12,12)=2*m1 + 2*m2 + m3 + 2*m6 + 2*m7 + 2*mp;
D(13,1)=sin(q1)*(L1*mp + m1*s1);
D(13,2)=sin(q2)*(L2*m1 + L2*mp + m2*s2);
D(13,3)=-sin(q3)*(m3*s3 + 2*m6*sb + 2*m7*sb);
D(13,4)=sin(q4)*(L2*m1 + L2*mp + m2*s2);
D(13,5)=sin(q5)*(L1*mp + m1*s1);
D(13,6)=sin(q6)*(L6*m7 + m6*s6);
D(13,7)=m7*s7*sin(q7);
D(13,8)=sin(q8)*(L6*m7 + m6*s6);
D(13,9)=m7*s7*sin(q9);
D(13,10)=hp*mp*sin(qp1);
D(13,11)=hp*mp*sin(qp2);
D(13,13)=2*m1 + 2*m2 + m3 + 2*m6 + 2*m7 + 2*mp;
%%
%%
%%
%%
C=zeros(13,13);
C(1,2)=L2*dq2*sin(q1 - q2)*(L1*mp + m1*s1);
C(1,10)=L1*dqp1*hp*mp*sin(q1 - qp1);
C(2,1)=-L2*dq1*sin(q1 - q2)*(L1*mp + m1*s1);
C(2,10)=L2*dqp1*hp*mp*sin(q2 - qp1);
C(3,6)=-dq6*sb*sin(q3 - q6)*(L6*m7 + m6*s6);
C(3,7)=-dq7*m7*s7*sb*sin(q3 - q7);
C(3,8)=-dq8*sb*sin(q3 - q8)*(L6*m7 + m6*s6);
C(3,9)=-dq9*m7*s7*sb*sin(q3 - q9);
C(4,5)=L2*dq5*sin(q4 - q5)*(L1*mp + m1*s1);
C(4,11)=L2*dqp2*hp*mp*sin(q4 - qp2);
C(5,4)=-L2*dq4*sin(q4 - q5)*(L1*mp + m1*s1);
C(5,11)=L1*dqp2*hp*mp*sin(q5 - qp2);
C(6,3)=dq3*sb*sin(q3 - q6)*(L6*m7 + m6*s6);
C(6,7)=L6*dq7*m7*s7*sin(q6 - q7);
C(7,3)=dq3*m7*s7*sb*sin(q3 - q7);
C(7,6)=-L6*dq6*m7*s7*sin(q6 - q7);
C(8,3)=dq3*sb*sin(q3 - q8)*(L6*m7 + m6*s6);
C(8,9)=L6*dq9*m7*s7*sin(q8 - q9);
C(9,3)=dq3*m7*s7*sb*sin(q3 - q9);
C(9,8)=-L6*dq8*m7*s7*sin(q8 - q9);
C(10,1)=-L1*dq1*hp*mp*sin(q1 - qp1);
C(10,2)=-L2*dq2*hp*mp*sin(q2 - qp1);
C(11,4)=-L2*dq4*hp*mp*sin(q4 - qp2);
C(11,5)=-L1*dq5*hp*mp*sin(q5 - qp2);
C(12,1)=-dq1*sin(q1)*(L1*mp + m1*s1);
C(12,2)=-dq2*sin(q2)*(L2*m1 + L2*mp + m2*s2);
C(12,3)=dq3*sin(q3)*(m3*s3 + 2*m6*sb + 2*m7*sb);
C(12,4)=-dq4*sin(q4)*(L2*m1 + L2*mp + m2*s2);
C(12,5)=-dq5*sin(q5)*(L1*mp + m1*s1);
C(12,6)=-dq6*sin(q6)*(L6*m7 + m6*s6);
C(12,7)=-dq7*m7*s7*sin(q7);
C(12,8)=-dq8*sin(q8)*(L6*m7 + m6*s6);
C(12,9)=-dq9*m7*s7*sin(q9);
C(12,10)=-dqp1*hp*mp*sin(qp1);
C(12,11)=-dqp2*hp*mp*sin(qp2);
C(13,1)=dq1*cos(q1)*(L1*mp + m1*s1);
C(13,2)=dq2*cos(q2)*(L2*m1 + L2*mp + m2*s2);
C(13,3)=-dq3*cos(q3)*(m3*s3 + 2*m6*sb + 2*m7*sb);
C(13,4)=dq4*cos(q4)*(L2*m1 + L2*mp + m2*s2);
C(13,5)=dq5*cos(q5)*(L1*mp + m1*s1);
C(13,6)=dq6*cos(q6)*(L6*m7 + m6*s6);
C(13,7)=dq7*m7*s7*cos(q7);
C(13,8)=dq8*cos(q8)*(L6*m7 + m6*s6);
C(13,9)=dq9*m7*s7*cos(q9);
C(13,10)=dqp1*hp*mp*cos(qp1);
C(13,11)=dqp2*hp*mp*cos(qp2);
%%
%%
%%
%%
G=zeros(13,1);
G(1)=g*sin(q1)*(L1*mp + m1*s1);
G(2)=g*sin(q2)*(L2*m1 + L1*mp + m2*s2);
G(3)=-g*sin(q3)*(m3*s3 + 2*m6*sb + 2*m7*sb);
G(4)=g*sin(q4)*(L2*m1 + L2*mp + m2*s2);
G(5)=g*sin(q5)*(L1*mp + m1*s1);
G(6)=g*sin(q6)*(L6*m7 + m6*s6);
G(7)=g*m7*s7*sin(q7);
G(8)=g*sin(q8)*(L6*m7 + m6*s6);
G(9)=g*m7*s7*sin(q9);
G(10)=g*mp*(spx*cos(qp1) + spy*sin(qp1));
G(11)=g*mp*(spx*cos(qp2) + spy*sin(qp2));
G(12)=0;
G(13)=g*(2*m1 + 2*m2 + m3 + 2*m6 + 2*m7 + 2*mp);
%%
%%
%%
%%
B=zeros(13,13);
B(1,1)=1;
B(2,2)=1;
B(3,3)=1;
B(4,4)=1;
B(5,5)=1;
B(6,6)=1;
B(7,7)=1;
B(8,8)=1;
B(9,9)=1;
B(10,10)=1;
B(11,11)=1;
B(12,12)=1;
B(13,13)=1;
%%
%%
%%
%%
Ac1=zeros(2,13);
Ac1(1,1)=L1*cos(q1);
Ac1(1,2)=L2*cos(q2);
Ac1(1,10)=hp*cos(qp1);
Ac1(1,12)=1;
Ac1(2,1)=L1*sin(q1);
Ac1(2,2)=L2*sin(q2);
Ac1(2,10)=hp*sin(qp1);
Ac1(2,13)=1;
%%
%%
%%
%%
Hc1=zeros(2,1);
Hc1(1,1)=- L1*sin(q1)*dq1^2 - L2*sin(q2)*dq2^2 - hp*sin(qp1)* ...
         dqp1^2;
Hc1(2,1)=L1*cos(q1)*dq1^2 + L2*cos(q2)*dq2^2 + hp*cos(qp1)* ...
         dqp1^2;
%%
%%
%%
%%
Ac2=zeros(2,13);
Ac2(1,4)=L2*cos(q4);
Ac2(1,5)=L1*cos(q5);
Ac2(1,11)=hp*cos(qp2);
Ac2(1,12)=1;
Ac2(2,4)=L2*sin(q4);
Ac2(2,5)=L1*sin(q5);
Ac2(2,11)=hp*sin(qp2);
Ac2(2,13)=1;
%%
%%
%%
%%
Hc2=zeros(2,1);
Hc2(1,1)=- L2*sin(q4)*dq4^2 - L1*sin(q5)*dq5^2 - hp*sin(qp2)* ...
         dqp2^2;
Hc2(2,1)=L2*cos(q4)*dq4^2 + L1*cos(q5)*dq5^2 + hp*cos(qp2)* ...
         dqp2^2;
%%
%%
%%
%%
vitcmgtronc=zeros(2,1);
vitcmgtronc(1,1)=- dqp1*hp*cos(qp1) - L1*dq1*cos(q1) - L2*dq2* ...
         cos(q2);
vitcmgtronc(2,1)=- dqp1*hp*sin(qp1) - L1*dq1*sin(q1) - L2*dq2* ...
         sin(q2);
return