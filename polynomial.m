function trajectory=polynomial(q_ini, q_fin, qp_ini, qp_fin, T)

global mc dom_tra
global nb_articulations

n_dof = nb_articulations;
Precision=mc*dom_tra;

a0=q_ini;
a1=qp_ini;

%%  Calculation of coefficients of polynomial: q(t) = a0 + a1*t + a2*t^2 + a3*t^3 + a4*t^4´

Acoef1=[T^2    T^3   ;     %q_fin 
        2*T    3*T^2];     %dq_fin
coeff=[a0, a1, zeros(n_dof,2)];

for j=1:n_dof
    Y1=[q_fin(j)-a0(j)-a1(j)*T; qp_fin(j)-a1(j)];
    coeff(j,3:4)=(Acoef1\Y1)';
end

% pour simplifier l'ï¿½criture la matrice 'a' est rï¿½partie dans 5 vecteurs 
a2=coeff(:,3);
a3=coeff(:,4);

%% 
% initialisation des variables globales

q=zeros(n_dof, Precision);
dq=zeros(n_dof, Precision);
ddq=zeros(n_dof, Precision);
vec_T=linspace(0,T,Precision);
% calcul des couples et des trajectoires pour chaque valeur de t
for i=1:Precision
    t=vec_T(i);
    q(:,i)= a0 + a1*t + a2*t^2 + a3*t^3;
    dq(:,i)= a1 + 2*a2*t + 3*a3*t^2;
    ddq(:,i)= 2*a2 + 6*a3*t;
end
%% generate output of the function
trajectory.temps=vec_T;
trajectory.q=q;
trajectory.qp=dq;
trajectory.qpp=ddq;

return