% Malcolm D. Forbes
% ME 341
% Studio Project 1

clc
clear
close all

%Force on A gear
F_a = 15*10^3; %N
alpha_a = 0; %deg
beta_a = toRadians('degrees', 70); %deg
gamma_a = toRadians('degrees', 20); %deg
FA = F_a*[0 0 0;0 -1 0; 0 0 -1]*[cos(alpha_a); cos(beta_a); cos(gamma_a)];

%Force on B gear
alpha_b = 0; %deg
beta_b = toRadians('degrees', 65); %deg
gamma_b = toRadians('degrees', 155); %deg
F_b = -0.3*FA(3)/(0.15*cos(gamma_b)); %N
FB = F_b*[0 0 0;0 -1 0; 0 0 1]*[cos(alpha_b); cos(beta_b); cos(gamma_b)];

%Reaction force at 0
R0 = [0;(0.3*FB(2)+0.65*FA(2))/1.05;(0.65*FA(3)-0.3*FB(3))/1.05];

%Reaction force at C
RC = [0;FA(2)+FB(2)-R0(2);FA(3)-FB(3)-R0(3)];

%Physical Characteristics
E = 207.0*10^9; %Pa
rho = (76.5*10^3)/9.80; %kg/m^3

%Moment of Inertia
    %Asuuming a rod
    Iy = pi*0.05^2*1.05^3*rho/48;
    Iz = pi*0.05^2*1.05^3*rho/48;

%Constants of integration
C1(1) = (FA(2)*0.65^3/6 + FB(2)*0.3^3/6 - R0(2)*1.05^3/6)/1.05;
C2(1) = 0;

C1(2) = (FA(3)*0.65^3/6 - FB(3)*0.3^3/6 - R0(3)*1.05^3/6)/1.05;
C2(2) = 0;


x1 = linspace(0,0.4);
x2 = linspace(0.4,0.75);
x3 = linspace(0.75,1.05);

for i = 1:length(x1)
[Vy1(i),Vz1(i),My1(i),Mz1(i), thetaY1(i), thetaZ1(i), y1(i), z1(i), tau1(i)] = zshear(x1(i), R0, FA, FB, RC, E, Iz, Iy, C1, C2);
end

for i = 1:length(x2)
[Vy2(i),Vz2(i),My2(i),Mz2(i),thetaY2(i), thetaZ2(i), y2(i), z2(i), tau2(i)] = zshear(x2(i), R0, FA, FB, RC, E, Iz, Iy, C1, C2);
end

for i = 1:length(x3)
[Vy3(i),Vz3(i),My3(i),Mz3(i),thetaY3(i), thetaZ3(i), y3(i), z3(i), tau3(i)] = zshear(x3(i), R0, FA, FB, RC, E, Iz, Iy, C1, C2);
end

%Loading Diagrams
figure
subplot (3,2,1)
title('Loading components in x-y plane')
xlabel('x [m]')
ylabel('q_y [N]')
axis([0 1.05 -3*10^4 3*10^4])
grid on
hold on
plot([0 0.4 0.75 1.05; 0 0.4 0.75 1.05],[0 0 0 0;R0(2) FA(2) FB(2) RC(2)], '.k-')
ax = gca;
ax.XAxisLocation = 'origin';
hold off

subplot (3,2,2)
title('Loading components in x-z plane')
xlabel('x [m]')
ylabel('q_z [N]')
axis([0 1.05 -3*10^4 3*10^4])
grid on
hold on
plot([0 0.4 0.75 1.05; 0 0.4 0.75 1.05],[0 0 0 0;R0(3) FA(3) FB(3) RC(3)], '.k-')
ax = gca;
ax.XAxisLocation = 'origin';
hold off

%Shear Diagrams
subplot(3,2,3)
title('Shear component in x-y plane')
xlabel('x [m]')
ylabel('V_y [N]')
axis([0 1.05 -20*10^3 26*10^3])
grid on
hold on
plot(x1,Vy1,'k')
plot(x2,Vy2,'k')
plot(x3,Vy3,'k')
ax = gca;
ax.XAxisLocation = 'origin';
hold off

subplot(3,2,4)
title('Shear component in x-z plane')
xlabel('x [m]')
ylabel('V_z [N]')
axis([0 1.05 -20*10^3 26*10^3])
grid on
hold on
plot(x1,Vz1,'k')
plot(x2,Vz2,'k')
plot(x3,Vz3,'k')
ax = gca;
ax.XAxisLocation = 'origin';
hold off

%Bending Moment Diagrams
subplot(3,2,5)
title('Bending Moment component in x-y plane')
xlabel('x [m]')
ylabel('M_y [N-m]')
axis([0 1.05 -8*10^3 3*10^3])
grid on
hold on
plot(x1,My1,'k')
plot(x2,My2,'k')
plot(x3,My3,'k')
ax = gca;
ax.XAxisLocation = 'origin';
hold off

subplot(3,2,6)
title('Bending Moment component in x-z plane')
xlabel('x [m]')
ylabel('M_z [N-m]')
axis([0 1.05 -8*10^3 3*10^3])
grid on
hold on
plot(x1,Mz1,'k')
plot(x2,Mz2,'k')
plot(x3,Mz3,'k')
ax = gca;
ax.XAxisLocation = 'origin';
hold off

%Torsional Torque Diagrams
figure
title('Torsional Torque Diagram')
xlabel('x [m]')
ylabel('T [N-m]')
axis([0 1.05 -4.5*10^3 0.1*10^3])
grid on
hold on
plot(x1,tau1,'k')
plot(x2,tau2,'k')
plot(x3,tau3,'k')
ax = gca;
ax.XAxisLocation = 'origin';
hold off

%Combined Magnitude Diagrams
%{
x = linspace(0,1.05);
%for i = 1:length(x)
    [M(i), V(i), tau(i)] = zloading(x(i), R0, FA, FB, RC);
end

disp('Max Bending Moment:')
[Mmax,Im] = max(M);
disp(Mmax)
disp('at:')
disp(x(Im))
thetaM = atan(max(Mz2)/max(My2));
yM = 0.15*cos(thetaM);
zM = 0.15*sin(thetaM);
disp(yM)
disp(zM)

disp('Max Shear Force:')
[Vmax,Iv] = max(V);
disp(Vmax)
disp('at:')
disp(x(Iv))
thetaV = atan(max(Vz2)/max(Vy2));
yV = 0*cos(thetaV);
zV = 0*sin(thetaV);
disp(yV)
disp(zV)

disp('Max Torque:')
[Tmax,It] = min(tau);
disp(Tmax)
disp('at:')
disp(x(It))

figure
subplot(3,1,1)
plot(x,M)
subplot(3,1,2)
plot(x, V)
subplot(3,1,3)
plot(x, tau)
%}

%Angle of Deflection Plots
figure
subplot(1,2,1)
title('Angle of Deflection in y')
xlabel('x [m]')
ylabel('\theta_y [deg]')
axis([0 1.05 -5*10^-7 4.6*10^-7])
grid on
hold on
plot(x1,thetaY1,'k')
plot(x2,thetaY2,'k')
plot(x3,thetaY3,'k')
ax = gca;
ax.XAxisLocation = 'origin';
hold off

subplot(1,2,2)
title('Angle of Deflection in z')
xlabel('x [m]')
ylabel('\theta_z [deg]')
axis([0 1.05 -5*10^-7 4.6*10^-7])
grid on
hold on
plot(x1,thetaZ1,'k')
plot(x2,thetaZ2,'k')
plot(x3,thetaZ3,'k')
ax = gca;
ax.XAxisLocation = 'origin';
hold off

%Deflection plots
figure
subplot(1,2,1)
title('Deflection in y')
xlabel('x [m]')
ylabel('y [m]')
axis([0 1.05 -4.6*10^-10 2.8*10^-9])
grid on
hold on
plot(x1,y1,'k')
plot(x2,y2,'k')
plot(x3,y3,'k')
ax = gca;
ax.XAxisLocation = 'origin';
hold off

subplot(1,2,2)
title('Deflection in z')
xlabel('x [m]')
ylabel('z [m]')
axis([0 1.05 -4.6*10^-10 2.8*10^-9])
grid on
hold on
plot(x1,z1,'k')
plot(x2,z2,'k')
plot(x3,z3,'k')
ax = gca;
ax.XAxisLocation = 'origin';
hold off

%{
%Torsional Shear Stress Computation
tauT = 32*Tmax*0.15/(pi*0.3^4)

%Bending Moment Stress Computation
sigmaM = -4*Mmax*0.15/(pi*0.15^4) %principal stresses; no shear
sigmaM_y = sigmaM*cos(thetaM)
sigmaM_z = sigmaM*sin(thetaM)

%Shear Stress Computation
tauS = 16*Vmax/(6*pi*0.15*0.3) %maximum shear

%}
