% function [q,flag] = MGI(xh,zh,d)
% donne les orientation absolues de la jambe arriere en fonction des autres
% orientation
% orientation en phase de double support talon pointe

function [q,flag] = MGI_Arnaud(xh,zh,d)
global L1 L2 L4 L5 Hp lp Lp 
flag = 0;
l1 = L1; l2 = L2; l3 = L4; l4 = L5;
%% solution des angles absolues de la jambe de support

%% equation de type 7
%- l1 * sin(q1) -l2 * sin(q2) = xh
% l1 * cos(q1) + l2 * cos(q2) = zh

W = l1;
X = -l2;
Z2 = - xh;
Z1 = zh;

%% solution pour q4
% equation de type 2

B1 = 2 * Z2 * X;
B2 = 2 * Z1 * X;
B3 = W^2 - X^2 - Z1^2 - Z2^2;

e  = -1;
Sq2 = (B1 * B3 + e * B2 * sqrt(max(B1^2 + B2^2 - B3^2,0))) / (B1^2 + B2^2);
Cq2 = (B2 * B3 - e * B1 * sqrt(max(B1^2 + B2^2 - B3^2,0))) / (B1^2 + B2^2);
if max(B1^2 + B2^2 - B3^2,0) == 0
    flag = 1;
end

q2 = atan2( Sq2 , Cq2 );

%% solution pour q3
% equation de type 3 

V1 = l1;
V2 = l1;
W1 = -xh - l2 * sin(q2);
W2 = zh - l2 * cos(q2);

q1 = atan2( W1/V1 , W2/V2 );

%% solution des angles absolues de la jambe libre

%% equation de type 7
% xh + l3 * sin(q3) + l4 * sin(q4) = d
% zh - l3 * cos(q3) - l4 * cos(q4) = 0

W = l3;
X = -l4;
Z2 = d - xh;
Z1 = zh;

%% solution pour q4
% equation de type 2

B1 = 2 * Z2 * X;
B2 = 2 * Z1 * X;
B3 = W^2 - X^2 - Z1^2 - Z2^2;

e  = 1;

Sq4 = (B1 * B3 + e * B2 * sqrt(max(B1^2 + B2^2 - B3^2,0))) / (B1^2 + B2^2);
Cq4 = (B2 * B3 - e * B1 * sqrt(max(B1^2 + B2^2 - B3^2,0))) / (B1^2 + B2^2);
if max(B1^2 + B2^2 - B3^2,0) == 0
    flag = 1;
end

q4 = atan2( Sq4 , Cq4 );

%% solution pour q3
% equation de type 3 

V1 = l1;
V2 = l1;
W1 = d - xh - l4 * sin(q4);
W2 = zh - l4 * cos(q4);

q3 = atan2( W1/V1 , W2/V2 );


q = [q1 ; q2 ; q3 ; q4];


return


