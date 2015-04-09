function Trajectoire=polynome_traj(q_0, q_int, q_fin, dq_0, dq_fin,mc,dom_tra,T);
Precision=mc*dom_tra;
 q0_1=[q_0(1:2);q_0(4:5);q_0(10)];
 q_fin1=[q_fin(1:2);q_fin(4:5);q_fin(10)];
 dq0_1=[dq_0(1:2);dq_0(4:5);dq_0(10)];
 dq_fin1=[dq_fin(1:2);dq_fin(4:5);dq_fin(10)];
 
 
 
%calcul des coefficients 'a' du polynome qt1(t):q1 q2 q4 q5 q6
Acoef1=[T^2/4  T^3/8  T^4/16  ;%q_int
        T^2    T^3    T^4     ;%q_fin 
        2*T    3*T^2  4*T^3  ];%dq_fin
a=[q0_1 dq0_1 zeros(5,3)];
for j=1:5
    Y1=[q_int(j)-(a(j,1)+a(j,2)*T/2); q_fin1(j)-(a(j,1)+a(j,2)*T); dq_fin1(j)-a(j,2)];
    a(j,3:5)=(Acoef1\Y1)';
end
% pour simplifier l'écriture la matrice 'a' est répartie dans 5 vecteurs 
a0=a(:,1); a1=a(:,2); a2=a(:,3); a3=a(:,4); a4=a(:,5);

%%
 q0_2=[q_0(3);q_0(6:9)];
 q_fin2=[q_fin(3);q_fin(6:9)];
 dq0_2=[dq_0(3);dq_0(6:9)];
 dq_fin2=[dq_fin(3);dq_fin(6:9)];
 
%calcul des coefficients 'a' du polynome qt1(t): q1 q2 q4 q5 q6
Acoef2=[T^2    T^3    ;%q_fin 
        2*T    3*T^2 ];%dq_fin

e0=q0_2;e1=dq0_2;
Y2=[(q_fin2-q0_2-dq0_2.*T)  (dq_fin2-dq0_2)]';ae=(Acoef2\Y2)';
e2=ae(:,1);e3=ae(:,2);

%% 
% initialisation des variables globales
%GAMTOT=[]; q_swing=[];critere_vec = 0;R1=[];
pas=T/Precision;ii=0;

% calcul des couples et des trajectoires pour chaque valeur de t
%vec_t=[];
for t=0:pas:T
    ii=ii+1;
    % positions q1:q6 à l'instant t
    qt1= a0 + a1*t + a2*t^2 + a3*t^3 + a4*t^4 ;
    q1=qt1(1);q2=qt1(2);q4=qt1(3);q5=qt1(4);q10=qt1(5);
        % vitesses
    dq1= a1 + 2*a2*t + 3*a3*t^2 + 4*a4*t^3 ;
    q1d=dq1(1);q2d=dq1(2);q4d=dq1(3);q5d=dq1(4);q10d=dq1(5);
        % accélérations
    ddq1= 2*a2 + 6*a3*t + 12*a4*t^2;
    q1dd=ddq1(1);q2dd=ddq1(2);q4dd=ddq1(3);q5dd=ddq1(4);q10dd=ddq1(5);
    
    %positions q7:q10 à l'instant t
    qt2= e0 + e1*t + e2*t^2 + e3*t^3;
    q3=qt2(1);q6=qt2(2);q7=qt2(3);q8=qt2(4);q9=qt2(5);
        % vitesses
    dq2= e1 + 2*e2*t + 3*e3*t^2 ;
    q3d=dq2(1);q6d=dq2(2);q7d=dq2(3);q8d=dq2(4);q9d=dq2(5);
        % accélérations
    ddq2= 2*e2 + 6*e3*t ;
    q3dd=ddq2(1);q6dd=ddq2(2);q7dd=ddq2(3);q8dd=ddq2(4);q9dd=ddq2(5);

    qt(:,ii)=[q1;q2;q3;q4;q5;q6;q7;q8;q9;q10];
    dq(:,ii)=[q1d;q2d;q3d;q4d;q5d;q6d;q7d;q8d;q9d;q10d];
    ddq(:,ii)=[q1dd;q2dd;q3dd;q4dd;q5dd;q6dd;q7dd;q8dd;q9dd;q10dd];
   % vec_t= [vec_t,t]      
end
    %Trajectoire.temps=vec_t;
    Trajectoire.temps=0:pas:T;
    Trajectoire.q=qt;
    Trajectoire.qp=dq;
    Trajectoire.qpp=ddq;

return