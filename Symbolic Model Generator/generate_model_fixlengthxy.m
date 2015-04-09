%
%
% File to automatically build up the .m-files needed for our simualtor
%

%load Mat/work_symb_model_abs;
%fcn_name = 'dyn_mod_abs';

disp(['[creating ',upper(fcn_name),'.m]']);
fid = fopen([fcn_name,'.m'],'w');
n=max(size(q));
fprintf(fid,['function [D,C,G,B,E,Dlin]=' ...
        ' %s(q,dq,ddq)\n'],fcn_name);
fprintf(fid,'%%%s\n\n',upper(fcn_name));
fprintf(fid,'%%%s\n\n',datestr(now));
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%% Authors: Alexander Yannick  and Franck');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%% Model NOTATION: Spong and Vidyasagar, page 142, Eq. (6.3.12)');
fprintf(fid,'\n%s','%%                 D(q)ddq + C(q,dq)*dq + G(q) = B*tau');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','[g,L1,L2,L3,L4,L5,m1,m2,m3,m4,m5,I1,I2,I3,I4,I5,s1,s2,s3,s4,s5]=modelParameters;');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
if n==5
    fprintf(fid,'\n%s','delta1=q(1);delta2=q(2);delta12=q(3);delta54=q(4);phi=q(5);');
    fprintf(fid,'\n%s','deltap1=dq(1);deltap2=dq(2);deltap12=dq(3);deltap54=dq(4);phip=dq(5);');
    fprintf(fid,'\n%s','deltadp1=ddq(1);deltadp2=ddq(2);deltadp3=ddq(3);deltadp54=ddq(4);phidp=ddq(5);');

else
%     fprintf(fid,'\n%s','q31=q(1);q32=q(2);q41=q(3);q42=q(4);y=q(5);z=q(6);q1=q(7);');
    %fprintf(fid,'\n%s','dq31=dq(1);dq32=dq(2);dq41=dq(3);dq42=dq(4);dy=dq(5);dz=dq(6);dq1=dq(7);');
end

fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s',['D=zeros(',num2str(n),',',num2str(n),');']);
for i=1:n
    for j=1:n
        Temp0=D(i,j);
        if Temp0 ~= 0
            Temp1=char(Temp0);
            Temp2=['D(',num2str(i),',',num2str(j),')=',Temp1,';'];
            Temp3=fixlength(Temp2,'*+-',65,'         ');
            fprintf(fid,'\n%s',Temp3);
        end
    end
end
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s',['C=zeros(',num2str(n),',',num2str(n),');']);
for i=1:n
    for j=1:n
        Temp0=C(i,j);
        if Temp0 ~= 0
            %ttt = char(vectorize(jac_P(2)));
            Temp1=char(Temp0);
            Temp2=['C(',num2str(i),',',num2str(j),')=',Temp1,';'];
            Temp3=fixlength(Temp2,'*+-',65,'         ');
            fprintf(fid,'\n%s',Temp3);
        end
    end
end
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s',['G=zeros(',num2str(n),',1);']);
for i=1:n
    Temp1=char(G(i));
    Temp2=['G(',num2str(i),')=',Temp1,';'];
    Temp3=fixlength(Temp2,'*+-',65,'         ');
    fprintf(fid,'\n%s',Temp3);
end
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
[n,m]=size(B);
fprintf(fid,'\n%s',['B=zeros(',num2str(n),',',num2str(m),');']);
for i=1:n
    for j=1:m
        Temp0=B(i,j);
        if Temp0 ~= 0
            Temp1=char(Temp0);
            Temp2=['B(',num2str(i),',',num2str(j),')=',Temp1,';'];
            Temp3=fixlength(Temp2,'*+-',65,'         ');
            fprintf(fid,'\n%s',Temp3);
        end
    end
end
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
[n,m]=size(Ac1);
fprintf(fid,'\n%s',['Ac1=zeros(',num2str(n),',',num2str(m),');']);
for i=1:n
    for j=1:m
        Temp0=Ac1(i,j);
        if Temp0 ~= 0
            Temp1=char(Temp0);
            Temp2=['Ac1(',num2str(i),',',num2str(j),')=',Temp1,';'];
            Temp3=fixlength(Temp2,'*+-',65,'         ');
            fprintf(fid,'\n%s',Temp3);
        end
    end
end
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
[n,m]=size(Hc1);
fprintf(fid,'\n%s',['Hc1=zeros(',num2str(n),',',num2str(m),');']);
for i=1:n
    for j=1:m
        Temp0=Hc1(i,j);
        if Temp0 ~= 0
            Temp1=char(Temp0);
            Temp2=['Hc1(',num2str(i),',',num2str(j),')=',Temp1,';'];
            Temp3=fixlength(Temp2,'*+-',65,'         ');
            fprintf(fid,'\n%s',Temp3);
        end
    end
end
 
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
[n,m]=size(Ac2);
fprintf(fid,'\n%s',['Ac2=zeros(',num2str(n),',',num2str(m),');']);
for i=1:n
    for j=1:m
        Temp0=Ac2(i,j);
        if Temp0 ~= 0
            Temp1=char(Temp0);
            Temp2=['Ac2(',num2str(i),',',num2str(j),')=',Temp1,';'];
            Temp3=fixlength(Temp2,'*+-',65,'         ');
            fprintf(fid,'\n%s',Temp3);
        end
    end
end
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
[n,m]=size(Hc2);
fprintf(fid,'\n%s',['Hc2=zeros(',num2str(n),',',num2str(m),');']);
for i=1:n
    for j=1:m
        Temp0=Hc2(i,j);
        if Temp0 ~= 0
            Temp1=char(Temp0);
            Temp2=['Hc2(',num2str(i),',',num2str(j),')=',Temp1,';'];
            Temp3=fixlength(Temp2,'*+-',65,'         ');
            fprintf(fid,'\n%s',Temp3);
        end
    end
end
 
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
fprintf(fid,'\n%s','%%');
[n,m]=size(vitcmgtronc);
fprintf(fid,'\n%s',['vitcmgtronc=zeros(',num2str(n),',',num2str(m),');']);
for i=1:n
    for j=1:m
        Temp0=vitcmgtronc(i,j);
        if Temp0 ~= 0
            Temp1=char(Temp0);
            Temp2=['vitcmgtronc(',num2str(i),',',num2str(j),')=',Temp1,';'];
            Temp3=fixlength(Temp2,'*+-',65,'         ');
            fprintf(fid,'\n%s',Temp3);
        end
    end
 end


fprintf(fid,'\n%s','return');
status = fclose(fid)

return

ttt = char(vectorize(jac_P(2)));
fprintf(fid,'jac_P2 = %s;\n\n',fixlength(ttt,'*+-',65,'         '));