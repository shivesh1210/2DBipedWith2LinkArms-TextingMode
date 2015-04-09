
global L1 L2 L3 L4 L5 L6 L7 L8 L9
global m1 m2 m3 m4 m5 m6 m7 m8 m9 mp   
global I1 I2 I3 I4 I5 I6 I7 I8 I9 Ip1 Ip2 
global s1 s2 s3 s4 s5 s6 sb s7 s8 s9
global nb_articulations M H_Hydroid
global g dom_tra mc mu
global hp Lp ld lg spx spy
global Walk_Speed degree

degree = pi/180;

H_Hydroid=1.3111;
dom_tra =25;
mc = 2;
mu=0.8; %Friction co-efficient
nb_articulations=10;
g=9.81;

%Length of body parts
L1=0.392;
L2=0.392;
L3=0.460;
L4=L2;
L5=L1;
Lp2=0.0;%Lp2=0.050;
ld=0.135+Lp2
lg=0.072
hp=0.06425;
Lp=0.207;%Lp=0.257;
L6=0.293;%(upper arm)
L7 = 0.293; % fore arm
L9 = L7;
L8=L6;
sb =0.3804;

% longeur=ld+lp;

%Mass of articulations
m1=2.188;
m2=5.025;
m3=24.97; % with mass of the arms
m4=m2;
m5=m1;
mp1=0.678;
m_toe=0;%0.155;
mp=mp1+m_toe
m6 = 1.3;%Upper bras 1:
m7 = 0.85;%avant bras 1
m8=m6;
m9=m7;
mass_phone = 0.139      % Mass of smartphone
m9new = m9 + mass_phone;
M=(m1 + m2 + m3 + m4 + m5 + 2 * m6 + m7 + m9new +2 * mp + mass_phone)

%Moment of Inertia of articulations at CoG
I1 = 0.02765;
I2 = 0.06645;
I3 =0.6848405
I4=I2;
I5=I1;
Ip1=0.001753;%0.00393697; %including the inertia of the toe
Ip2 =Ip1;
I6=0.009303;
I7=0.004422;
I8=I6;
I9=I7;
I9new = I9 + mass_phone*(L9)^2;

%Centre of Gravity of articulations
s1= 0.16856;
s2= 0.16856;
s3= 0.20128; % with mass of the arms
s4=s2;
s5=s1;

spx= 0.0135;
spy= 0.032125;
s6=0.126;
s7=0.126;
s8=s6;
s9=s7;
s9new = (m9*s9 + mass_phone*L9)/(mass_phone+m9);

% New assignments so that we dont have to modify a lot of code
m9 = m9new;
s9 = s9new;
I9 = I9new;
