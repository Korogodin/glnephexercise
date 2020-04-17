function [math ] = math(xa,ya,za,vxa,vya,vza,Jsm_x,Jsm_y,Jsm_z,time_start,time_final, te,T)
%������ ���� ���������� � ���������, �.�. ����� ���������� ���� ������� ��
%����� ������ �����, � ����� �� ����� �������
%��� ������� �������
dt=1;
if(te<=time_start&&te<time_final)
    t=time_start:dt:time_final-dt;
    result=nan(length(t),6);
    XA=zeros(length(t),1);
    XA(1,:)=xa;
    YA=zeros(length(t),1);
    YA(1,:)=ya;
    ZA=zeros(length(t),1);
    ZA(1,:)=za;
    VXA=zeros(length(t),1);
    VXA(1,:)=vxa;
    VYA=zeros(length(t),1);
    VYA(1,:)=vya;
    VZA=zeros(length(t),1);
    VZA(1,:)=vza;
    result=RungKUTT( t,dt,XA,YA,ZA,VXA,VYA,VZA, T ); 
    ti=t;
elseif(te>time_start&&te<time_final)
    t1=te:dt:time_final-dt;
    result=nan(length(t1),7);
    XA=zeros(length(t1),1);
    XA(1,:)=xa;
    YA=zeros(length(t1),1);
    YA(1,:)=ya;
    ZA=zeros(length(t1),1);
    ZA(1,:)=za;
    VXA=zeros(length(t1),1);
    VXA(1,:)=vxa;
    VYA=zeros(length(t1),1);
    VYA(1,:)=vya;
    VZA=zeros(length(t1),1);
    VZA(1,:)=vza;
    result=RungKUTT( t1,dt,XA,YA,ZA,VXA,VYA,VZA, T ); 
    ti=t1;
end
%%�������� �� �������� ����
tu=ti-te;
for i=1:length(tu)
    tau(i,:)=tu(i);
    tpz(i,:)=ti(i);
end
NEB_TEL=sun_moon(T, xa,ya,za,vxa,vya,vza);

dx=(NEB_TEL(1)+(4))*0.5*tau.^2;
dy=(NEB_TEL(2)+(5))*0.5*tau.^2;
dz=(NEB_TEL(3)+(6))*0.5*tau.^2;

dvx=(NEB_TEL(1)+(4))*tau;
dvy=(NEB_TEL(2)+(5))*tau;
dvz=(NEB_TEL(3)+(6))*tau;


result(:,1)=result(:,1)+dvx;
result(:,2)=result(:,2)+dvy;
result(:,3)=result(:,3)+dvz;

result(:,4)=result(:,4)+dvx;
result(:,5)=result(:,5)+dvy;
result(:,6)=result(:,6)+dvz;

[math]=[result tpz];
end

