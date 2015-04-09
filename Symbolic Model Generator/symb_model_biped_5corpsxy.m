%
% symb_model_quad_red
%
clear all
clc
% This is for the quadruped model, with the rear foot on the ground, walking left to right. The model is 
% for five degrees of freedom of the robot, with Foot1 touching the ground
%
syms q1 q2 q3 q4 q5 q6 q7 q8 q9 qp1 qp2 xh yh real
syms dq1 dq2 dq3 dq4 dq5 dq6 dq7 dq8 dq9 dqp1 dqp2 dxh dyh real
syms ddq1 ddq2 ddq3 ddq4 ddq5 ddq6 ddq7 ddq8 ddq9 ddqp1 ddqp2 ddxh ddyh real
syms m1 m2 m3 m4 m5 m6 m7 m8 m9 mp M real  
syms I1 I2 I3 I4 I5 I6 I7 I8 I9 Ip1 Ip2 Front real
syms g L1 L2 L3 L4 L5 L6 L8 s1 s2 s3 s4 s5 s6 s7 s8 s9 sb spx spy real
syms Ycp Xcp hp Lp ld lg lp real
syms G1 G2 G3 G4 G5 G6 G7 G8 G9 FG1 FG2
syms xh yh CG_Biped dCG_Biped ddCG_Biped real
syms Reaction_Force gravity real

% Auteur Yannick
% reference = see schematic with angles defined
%

M=m1+m2+m3+m4+m5++m6+m7+m8+m9+2*mp;
q=[q1 q2 q3 q4 q5 q6 q7 q8 q9 qp1 qp2 xh yh].';
dq=[dq1 dq2 dq3 dq4 dq5 dq6 dq7 dq8 dq9 dqp1 dqp2 dxh dyh].';
ddq=[ddq1 ddq2 ddq3 ddq4 ddq5 ddq6 ddq7 ddq8 ddq9 ddqp1 ddqp2 ddxh ddyh].';
I4 = I2;
I5 = I1;
I8 = I6;
I9 = I7;
m5 = m1;
m4 = m2;
m8 = m6;
m9 = m7;
s4 = s2;
s5 = s1;
s8 = s6;
s9 = s7;
L5 = L1;
L4 = L2;
L8 = L6;


%% Centre of gravity of links
G1 = [xh + L2*sin(q2) + s1*sin(q1), yh - L2*cos(q2) - s1*cos(q1)];
G2 = [xh + s2*sin(q2), yh - s2*cos(q2)];
G3 = [xh - s3*sin(q3), yh + s3*cos(q3)]; %Tronc
G4 = [xh + s4*sin(q4), yh - s4*cos(q4)];
G5 = [xh + L4*sin(q4) + s5*sin(q5), yh - L4*cos(q4) - s5*cos(q5)];

    %1ere bras
G6=[xh-sb*sin(q3)+s6*sin(q6),yh+sb*cos(q3)-s6*cos(q6)];
G7=[xh-sb*sin(q3)+L6*sin(q6)+s7*sin(q7),yh+sb*cos(q3)-L6*cos(q6)-s7*cos(q7)];
    %2eme bras
G8=[xh-sb*sin(q3)+s8*sin(q8),yh+sb*cos(q3)-s8*cos(q8)];
G9=[xh-sb*sin(q3)+L8*sin(q8)+s9*sin(q9),yh+sb*cos(q3)-L8*cos(q8)-s9*cos(q9)]; 

%% Centre of gravity of feeti
FG1 = [xh + L2*sin(q2) + L1*sin(q1) + spy*sin(qp1) + spx*cos(qp1), yh - L1*cos(q2) - L1*cos(q1) - spy*cos(qp1) + spx*sin(qp1)]; % for the foot touching ground
FG2 = [xh  + L4*sin(q4)+ L5*sin(q5) + spy*sin(qp2) + spx*cos(qp2), yh - L4*cos(q4) - L5*cos(q5) - spy*cos(qp2) + spx*sin(qp2)];
foot1 = [xh + L2*sin(q2) + L1*sin(q1) + hp*sin(qp1), yh - L2*cos(q2) - L1*cos(q1) - hp*cos(qp1)]; % for the foot touching ground
foot2 = [xh  + L4*sin(q4)+ L5*sin(q5) + hp*sin(qp2), yh - L4*cos(q4) - L5*cos(q5) - hp*cos(qp2)];

% foot1 = [x + L2*sin(q2) + L1*sin(q1) + hp*sin(qp1), y - L2*cos(q2) - L1*cos(q1) - hp*cos(qp1)]; % for the foot touching ground
% foot2 = [x + L3*sin(q3) + L4*sin(q4) + hp*sin(qp2), y - L3*cos(q3) - L4*cos(q4) - hp*cos(qp2)];
%% Centre of Gravity CG of the biped
gravity=[0;-g];
CG_Biped=(m1*G1+m2*G2+m3*G3+m4*G4+m5*G5+m6*G6+m7*G7+m8*G8+m9*G9+mp*FG1+mp*FG2)/M;
dCG_Biped=jacobian(CG_Biped,q)*dq;
dCG_Biped =simple(dCG_Biped);
ddCG_Biped=jacobian(dCG_Biped,q)*dq + jacobian(CG_Biped,q)*ddq;
ddCG_Biped=simple(ddCG_Biped);

% Reaction_Force=M*(ddCG_Biped-gravity);
% Reaction_Force=simple(Reaction_Force);

%% Calculation of Potential Energy of the robot U=m*g*h
PE = m1*g*G1(2) + m2*g*G2(2) + m3*g*G3(2) + m4*g*G4(2)+ m5*g*G5(2)+ m6*g*G6(2) + m7*g*G7(2) + m8*g*G8(2)+ m9*g*G9(2) + mp*g*FG1(2) + mp*g*FG2(2);
PE=simple(PE);
%pretty(PE)

%% Calculation of Kinetic Energy of the robot E = 1/2*m*v² + 1/2*I*dq²
vc1=jacobian(G1,q)*dq;
vc2=jacobian(G2,q)*dq;
vc3=jacobian(G3,q)*dq;
vc4=jacobian(G4,q)*dq;
vc5=jacobian(G5,q)*dq;
vc6=jacobian(G6,q)*dq;
vc7=jacobian(G7,q)*dq;
vc8=jacobian(G8,q)*dq;
vc9=jacobian(G9,q)*dq;
vFG1=jacobian(FG1,q)*dq;
vFG2=jacobian(FG2,q)*dq;
vfoot1=jacobian(foot1,q)*dq;
vfoot2=jacobian(foot2,q)*dq;

KE1=simplify((1/2)*m1*(vc1.')*vc1 + (1/2)*I1*dq1.'*dq1);
KE2=simplify((1/2)*m2*(vc2.')*vc2 + (1/2)*I2*dq2.'*dq2);
KE3=simplify((1/2)*m3*(vc3.')*vc3 + (1/2)*I3*dq3.'*dq3);
KE4=simplify((1/2)*m4*(vc4.')*vc4 + (1/2)*I4*dq4.'*dq4);
KE5=simplify((1/2)*m5*(vc5.')*vc5 + (1/2)*I5*dq5.'*dq5);
KE6=simplify((1/2)*m6*(vc6.')*vc6 + (1/2)*I6*dq6.'*dq6);
KE7=simplify((1/2)*m7*(vc7.')*vc7 + (1/2)*I7*dq7.'*dq7);
KE8=simplify((1/2)*m8*(vc8.')*vc8 + (1/2)*I8*dq8.'*dq8);
KE9=simplify((1/2)*m9*(vc9.')*vc9 + (1/2)*I9*dq9.'*dq9);
KE_foot1=simplify((1/2)*mp*(vfoot1.')*vfoot1 + (1/2)*Ip1*dqp1.'*dqp1);
KE_foot2=simplify((1/2)*mp*(vfoot2.')*vfoot2 + (1/2)*Ip2*dqp2.'*dqp2);

KE  = simple(KE1+KE2+KE3+KE4+KE5+KE6+KE7+KE8+KE9+KE_foot1+KE_foot2);

%% Model NOTATION: Spong and Vidyasagar, page 142, Eq. (6.3.12)
%                 D(q)ddq + C(q,dq)*dq + G(q) = B*tau + E2*F_external
%Ecriture du Lagrangien
L=KE-PE;

%return
G=jacobian(PE,q).';
G=simple(G);
D=simple(jacobian(KE,dq).');
D=simple(jacobian(D,dq));


syms C real
n=max(size(q));
for k=1:n
   for j=1:n
      C(k,j)=0*g;
      for i=1:n
         C(k,j)=C(k,j)+(1/2)*(diff(D(k,j),q(i))+diff(D(k,i),q(j))-diff(D(i,j),q(k)))*dq(i);
      end
   end
end
C=simple(C);
E=[q(1) q(2) q(3) q(4) q(5) q(6) q(7) q(8) q(9) q(10) q(11) q(12) q(13)];
B=jacobian(E,q);
B=transpose(B);


%calcul de la matrice de contact

Pied1 = foot1;
Pied1p=jacobian(Pied1,q)*dq;
Pied1dp=jacobian(Pied1p,q)*dq + jacobian(Pied1,q)*ddq;

Pied2 = foot2;
Pied2p=jacobian(Pied2,q)*dq;
Pied2dp=jacobian(Pied2p,q)*dq + jacobian(Pied2,q)*ddq;

%Calcul de la vitesse absolue du centre de gravité du tronc
vitcmgtronc = [dq(12)-Pied1p(1);dq(13)-Pied1p(2)];

%% Calculation of Jacobian matrix of foot_1 Ac1

Ac1 = jacobian(Pied1,q);
Ac1qseconde = Ac1*ddq;
Hc1=expand(Pied1dp)-expand(Ac1qseconde);
Hc1=simple(Hc1);

Ac2 = jacobian(Pied2,q);
Ac2qseconde = Ac2*ddq;
Hc2=expand(Pied2dp)-expand(Ac2qseconde);
Hc2=simple(Hc2);


save work_symb_model_biped_abs_redxy
fcn_name = 'dyn_mod_biped_abs_red_arxy';
generate_model_fixlengthxy

%%%
%%% compute the linearized model in second order form
%%%

%% D(qr) ddq + 2C(qr,dqr) dq+ [d(D(qr)ddqr+C(qr,dqr)dqr+G(qr))/dq ] q = B u

%% Only thing to compute is the partials with respect to the configuration variables

%syms ddq1 ddq2 ddq3  real
%ddq=[ddq1; ddq2; ddq3];

%Dlin=jacobian(D*ddq+C*dq+G,q);
%Dlin=simple(Dlin);


return

