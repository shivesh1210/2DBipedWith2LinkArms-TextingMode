function trajectory=polynomial(q_ini, q_int, q_fin, qp_ini, qp_int, qp_fin, Tint, T)

global mc dom_tra
global nb_articulations

n_dof = nb_articulations;
Precision=mc*dom_tra;

a0=q_ini;
a1=qp_ini;

%%  Calculation of coefficients of polynomial: q(t) = a0 + a1*t + a2*t^2 + a3*t^3 + a4*t^4´

Acoef1=[Tint^2 Tint^3   Tint^4   Tint^5;     %q_int
        T^2    T^3      T^4      T^5   ;     %q_fin 
        2*Tint 3*Tint^2 4*Tint^3 5*Tint^4 ;  %dq_int
        2*T    3*T^2    4*T^3    5*T^4];     %dq_fin
coeff=[a0, a1, zeros(n_dof,4)];

for j=1:n_dof
    Y1=[q_int(j)-a0(j)-a1(j)*Tint; q_fin(j)-a0(j)-a1(j)*T; qp_int(j)-a1(j); qp_fin(j)-a1(j)];
    coeff(j,3:6)=(Acoef1\Y1)';
end

% pour simplifier l'ï¿½criture la matrice 'a' est rï¿½partie dans 5 vecteurs 
a2=coeff(:,3);
a3=coeff(:,4);
a4=coeff(:,5);
a5=coeff(:,6);

%% 
% initialisation des variables globales

q=zeros(n_dof, Precision);
dq=q;
ddq=q;
vec_T=linspace(0,T,Precision);
% calcul des couples et des trajectoires pour chaque valeur de t
for i=1:Precision
    t=vec_T(i);
    q(:,i)= a0 + a1*t + a2*t^2 + a3*t^3 + a4*t^4 + a5*t^5;
    dq(:,i)= a1 + 2*a2*t + 3*a3*t^2 + 4*a4*t^3 + 5*a5*t^4;
    ddq(:,i)= 2*a2 + 6*a3*t + 12*a4*t^2 + 20*a5*t^3;
end
%% generate output of the function
trajectory.temps=vec_T;
trajectory.q=q;
trajectory.qp=dq;
trajectory.qpp=ddq;

return