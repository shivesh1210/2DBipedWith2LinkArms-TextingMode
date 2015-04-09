function [D,C,G,B,E,Dlin]= dyn_mod_biped_abs_red(q,dq,ddq)
%DYN_MOD_BIPED_ABS_RED

%12-Mar-2015 19:41:27


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
D=zeros(10,10);
D(1,1)=I1 + 2*L1^2*m1 + 2*L1^2*m2 + L1^2*m3 + 2*L1^2*m6 + 2*L1^2* ...
         m7 + L1^2*mp + m1*s1^2 - 2*L1*m1*s1;
D(1,2)=L1*cos(q1 - q2)*(L2*m1 + 2*L2*m2 + L2*m3 + 2*L2*m6 + 2*L2* ...
         m7 + L2*mp - m2*s2);
D(1,3)=L1*cos(q1 - q3)*(m3*s3 + 2*m6*sb + 2*m7*sb);
D(1,4)=-L1*cos(q1 - q4)*(L2*m1 + L2*mp + m2*s2);
D(1,5)=-L1*cos(q1 - q5)*(L1*mp + m1*s1);
D(1,6)=-L1*cos(q1 - q6)*(L6*m7 + m6*s6);
D(1,7)=-L1*m7*s7*cos(q1 - q7);
D(1,8)=-L1*cos(q1 - q8)*(L6*m7 + m6*s6);
D(1,9)=-L1*m7*s7*cos(q1 - q9);
D(1,10)=-L1*mp*(spy*cos(q1 - qp2) + spx*sin(q1 - qp2));
D(2,1)=L1*cos(q1 - q2)*(L2*m1 + 2*L2*m2 + L2*m3 + 2*L2*m6 + 2*L2* ...
         m7 + L2*mp - m2*s2);
D(2,2)=I2 + L2^2*m1 + 2*L2^2*m2 + L2^2*m3 + 2*L2^2*m6 + 2*L2^2* ...
         m7 + L2^2*mp + m2*s2^2 - 2*L2*m2*s2;
D(2,3)=L2*cos(q2 - q3)*(m3*s3 + 2*m6*sb + 2*m7*sb);
D(2,4)=-L2*cos(q2 - q4)*(L2*m1 + L2*mp + m2*s2);
D(2,5)=-L2*cos(q2 - q5)*(L1*mp + m1*s1);
D(2,6)=-L2*cos(q2 - q6)*(L6*m7 + m6*s6);
D(2,7)=-L2*m7*s7*cos(q2 - q7);
D(2,8)=-L2*cos(q2 - q8)*(L6*m7 + m6*s6);
D(2,9)=-L2*m7*s7*cos(q2 - q9);
D(2,10)=-L2*mp*(spy*cos(q2 - qp2) + spx*sin(q2 - qp2));
D(3,1)=L1*cos(q1 - q3)*(m3*s3 + 2*m6*sb + 2*m7*sb);
D(3,2)=L2*cos(q2 - q3)*(m3*s3 + 2*m6*sb + 2*m7*sb);
D(3,3)=I3 + m3*s3^2 + 2*m6*sb^2 + 2*m7*sb^2;
D(3,6)=-sb*cos(q3 - q6)*(L6*m7 + m6*s6);
D(3,7)=-m7*s7*sb*cos(q3 - q7);
D(3,8)=-sb*cos(q3 - q8)*(L6*m7 + m6*s6);
D(3,9)=-m7*s7*sb*cos(q3 - q9);
D(4,1)=-L1*cos(q1 - q4)*(L2*m1 + L2*mp + m2*s2);
D(4,2)=-L2*cos(q2 - q4)*(L2*m1 + L2*mp + m2*s2);
D(4,4)=I2 + L2^2*m1 + L2^2*mp + m2*s2^2;
D(4,5)=L2*cos(q4 - q5)*(L1*mp + m1*s1);
D(4,10)=L2*mp*(spy*cos(q4 - qp2) + spx*sin(q4 - qp2));
D(5,1)=-L1*cos(q1 - q5)*(L1*mp + m1*s1);
D(5,2)=-L2*cos(q2 - q5)*(L1*mp + m1*s1);
D(5,4)=L2*cos(q4 - q5)*(L1*mp + m1*s1);
D(5,5)=I1 + L1^2*mp + m1*s1^2;
D(5,10)=L1*mp*(spy*cos(q5 - qp2) + spx*sin(q5 - qp2));
D(6,1)=-L1*cos(q1 - q6)*(L6*m7 + m6*s6);
D(6,2)=-L2*cos(q2 - q6)*(L6*m7 + m6*s6);
D(6,3)=-sb*cos(q3 - q6)*(L6*m7 + m6*s6);
D(6,6)=I6 + L6^2*m7 + m6*s6^2;
D(6,7)=L6*m7*s7*cos(q6 - q7);
D(7,1)=-L1*m7*s7*cos(q1 - q7);
D(7,2)=-L2*m7*s7*cos(q2 - q7);
D(7,3)=-m7*s7*sb*cos(q3 - q7);
D(7,6)=L6*m7*s7*cos(q6 - q7);
D(7,7)=I7 + m7*s7^2;
D(8,1)=-L1*cos(q1 - q8)*(L6*m7 + m6*s6);
D(8,2)=-L2*cos(q2 - q8)*(L6*m7 + m6*s6);
D(8,3)=-sb*cos(q3 - q8)*(L6*m7 + m6*s6);
D(8,8)=I6 + L6^2*m7 + m6*s6^2;
D(8,9)=L6*m7*s7*cos(q8 - q9);
D(9,1)=-L1*m7*s7*cos(q1 - q9);
D(9,2)=-L2*m7*s7*cos(q2 - q9);
D(9,3)=-m7*s7*sb*cos(q3 - q9);
D(9,8)=L6*m7*s7*cos(q8 - q9);
D(9,9)=I7 + m7*s7^2;
D(10,1)=-L1*mp*(spy*cos(q1 - qp2) + spx*sin(q1 - qp2));
D(10,2)=-L2*mp*(spy*cos(q2 - qp2) + spx*sin(q2 - qp2));
D(10,4)=L2*mp*(spy*cos(q4 - qp2) + spx*sin(q4 - qp2));
D(10,5)=L1*mp*(spy*cos(q5 - qp2) + spx*sin(q5 - qp2));
D(10,10)=Ip2 + mp*spx^2 + mp*spy^2;
%%
%%
%%
%%
C=zeros(10,10);
C(1,2)=L1*dq2*sin(q1 - q2)*(L2*m1 + 2*L2*m2 + L2*m3 + 2*L2*m6 + ...
          2*L2*m7 + L2*mp - m2*s2);
C(1,3)=L1*dq3*sin(q1 - q3)*(m3*s3 + 2*m6*sb + 2*m7*sb);
C(1,4)=-L1*dq4*sin(q1 - q4)*(L2*m1 + L2*mp + m2*s2);
C(1,5)=-L1*dq5*sin(q1 - q5)*(L1*mp + m1*s1);
C(1,6)=-L1*dq6*sin(q1 - q6)*(L6*m7 + m6*s6);
C(1,7)=-L1*dq7*m7*s7*sin(q1 - q7);
C(1,8)=-L1*dq8*sin(q1 - q8)*(L6*m7 + m6*s6);
C(1,9)=-L1*dq9*m7*s7*sin(q1 - q9);
C(1,10)=L1*dqp2*mp*(spx*cos(q1 - qp2) - spy*sin(q1 - qp2));
C(2,1)=-L1*dq1*sin(q1 - q2)*(L2*m1 + 2*L2*m2 + L2*m3 + 2*L2*m6 + ...
          2*L2*m7 + L2*mp - m2*s2);
C(2,3)=L2*dq3*sin(q2 - q3)*(m3*s3 + 2*m6*sb + 2*m7*sb);
C(2,4)=-L2*dq4*sin(q2 - q4)*(L2*m1 + L2*mp + m2*s2);
C(2,5)=-L2*dq5*sin(q2 - q5)*(L1*mp + m1*s1);
C(2,6)=-L2*dq6*sin(q2 - q6)*(L6*m7 + m6*s6);
C(2,7)=-L2*dq7*m7*s7*sin(q2 - q7);
C(2,8)=-L2*dq8*sin(q2 - q8)*(L6*m7 + m6*s6);
C(2,9)=-L2*dq9*m7*s7*sin(q2 - q9);
C(2,10)=L2*dqp2*mp*(spx*cos(q2 - qp2) - spy*sin(q2 - qp2));
C(3,1)=-L1*dq1*sin(q1 - q3)*(m3*s3 + 2*m6*sb + 2*m7*sb);
C(3,2)=-L2*dq2*sin(q2 - q3)*(m3*s3 + 2*m6*sb + 2*m7*sb);
C(3,6)=-dq6*sb*sin(q3 - q6)*(L6*m7 + m6*s6);
C(3,7)=-dq7*m7*s7*sb*sin(q3 - q7);
C(3,8)=-dq8*sb*sin(q3 - q8)*(L6*m7 + m6*s6);
C(3,9)=-dq9*m7*s7*sb*sin(q3 - q9);
C(4,1)=L1*dq1*sin(q1 - q4)*(L2*m1 + L2*mp + m2*s2);
C(4,2)=L2*dq2*sin(q2 - q4)*(L2*m1 + L2*mp + m2*s2);
C(4,5)=L2*dq5*sin(q4 - q5)*(L1*mp + m1*s1);
C(4,10)=-L2*dqp2*mp*(spx*cos(q4 - qp2) - spy*sin(q4 - qp2));
C(5,1)=L1*dq1*sin(q1 - q5)*(L1*mp + m1*s1);
C(5,2)=L2*dq2*sin(q2 - q5)*(L1*mp + m1*s1);
C(5,4)=-L2*dq4*sin(q4 - q5)*(L1*mp + m1*s1);
C(5,10)=-L1*dqp2*mp*(spx*cos(q5 - qp2) - spy*sin(q5 - qp2));
C(6,1)=L1*dq1*sin(q1 - q6)*(L6*m7 + m6*s6);
C(6,2)=L2*dq2*sin(q2 - q6)*(L6*m7 + m6*s6);
C(6,3)=dq3*sb*sin(q3 - q6)*(L6*m7 + m6*s6);
C(6,7)=L6*dq7*m7*s7*sin(q6 - q7);
C(7,1)=L1*dq1*m7*s7*sin(q1 - q7);
C(7,2)=L2*dq2*m7*s7*sin(q2 - q7);
C(7,3)=dq3*m7*s7*sb*sin(q3 - q7);
C(7,6)=-L6*dq6*m7*s7*sin(q6 - q7);
C(8,1)=L1*dq1*sin(q1 - q8)*(L6*m7 + m6*s6);
C(8,2)=L2*dq2*sin(q2 - q8)*(L6*m7 + m6*s6);
C(8,3)=dq3*sb*sin(q3 - q8)*(L6*m7 + m6*s6);
C(8,9)=L6*dq9*m7*s7*sin(q8 - q9);
C(9,1)=L1*dq1*m7*s7*sin(q1 - q9);
C(9,2)=L2*dq2*m7*s7*sin(q2 - q9);
C(9,3)=dq3*m7*s7*sb*sin(q3 - q9);
C(9,8)=-L6*dq8*m7*s7*sin(q8 - q9);
C(10,1)=-L1*dq1*mp*(spx*cos(q1 - qp2) - spy*sin(q1 - qp2));
C(10,2)=-L2*dq2*mp*(spx*cos(q2 - qp2) - spy*sin(q2 - qp2));
C(10,4)=L2*dq4*mp*(spx*cos(q4 - qp2) - spy*sin(q4 - qp2));
C(10,5)=L1*dq5*mp*(spx*cos(q5 - qp2) - spy*sin(q5 - qp2));
%%
%%
%%
%%
G=zeros(10,1);
G(1)=-g*sin(q1)*(2*L1*m1 + 2*L1*m2 + L1*m3 + 2*L1*m6 + 2*L1*m7 + ...
          L1*mp - m1*s1);
G(2)=-g*sin(q2)*(L2*m1 + 2*L2*m2 + L2*m3 + 2*L2*m6 + 2*L2*m7 + ...
          L2*mp - m2*s2);
G(3)=-g*sin(q3)*(m3*s3 + 2*m6*sb + 2*m7*sb);
G(4)=g*sin(q4)*(L2*m1 + L2*mp + m2*s2);
G(5)=g*sin(q5)*(L1*mp + m1*s1);
G(6)=g*sin(q6)*(L6*m7 + m6*s6);
G(7)=g*m7*s7*sin(q7);
G(8)=g*sin(q8)*(L6*m7 + m6*s6);
G(9)=g*m7*s7*sin(q9);
G(10)=g*mp*(spx*cos(qp2) + spy*sin(qp2));
%%
%%
%%
%%
B=zeros(10,10);
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
%%
%%
%%
%%
Ac1=zeros(2,10);
%%
%%
%%
%%
Hc1=zeros(2,1);
%%
%%
%%
%%
Ac2=zeros(2,10);
Ac2(1,1)=-L1*cos(q1);
Ac2(1,2)=-L2*cos(q2);
Ac2(1,4)=L2*cos(q4);
Ac2(1,5)=L1*cos(q5);
Ac2(1,10)=hp*cos(qp2);
Ac2(2,1)=-L1*sin(q1);
Ac2(2,2)=-L2*sin(q2);
Ac2(2,4)=L2*sin(q4);
Ac2(2,5)=L1*sin(q5);
Ac2(2,10)=hp*sin(qp2);
%%
%%
%%
%%
Hc2=zeros(2,1);
Hc2(1,1)=L1*dq1^2*sin(q1) + L2*dq2^2*sin(q2) - L2*dq4^2*sin(q4) - ...
          L1*dq5^2*sin(q5) - dqp2^2*hp*sin(qp2);
Hc2(2,1)=L2*dq4^2*cos(q4) - L2*dq2^2*cos(q2) - L1*dq1^2*cos(q1) + ...
          L1*dq5^2*cos(q5) + dqp2^2*hp*cos(qp2);
%%
%%
%%
%%
vitcmgtronc=zeros(2,1);
vitcmgtronc(1,1)=- dq3*s3*cos(q3) - L1*dq1*cos(q1) - L2*dq2* ...
         cos(q2);
vitcmgtronc(2,1)=- dq3*s3*sin(q3) - L1*dq1*sin(q1) - L2*dq2* ...
         sin(q2);
return