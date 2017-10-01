% Malcolm D. Forbes
% ME 341
% Studio Project 1

clc
clear
close all

%Force on A gear
F_a = 11*10^3; %N
alpha_a = toRadians('degrees', 90); %deg
beta_a = toRadians('degrees', 70); %deg
gamma_a = toRadians('degrees', 20); %deg
FA = F_a*[0 0 0;0 -1 0; 0 0 -1]*[cos(alpha_a); cos(beta_a); cos(gamma_a)];

%Force on B gear
alpha_b = toRadians('degrees', 90); %deg
beta_b = toRadians('degrees', 65); %deg
gamma_b = toRadians('degrees', 25); %deg
F_b = -0.3*FA(3)/(0.15*cos(gamma_b)); %N
FB = F_b*[0 0 0;0 -1 0; 0 0 1]*[cos(alpha_b); cos(beta_b); cos(gamma_b)];

%Reaction force at C
RC = [0;-(0.4*FA(2)+0.75*FB(2))/1.05;(0.4*FA(3)+0.75*FB(3))/1.05];

%Reaction force at 0
R0 = [0;-FA(2)-FB(2)-RC(2);-FA(3)-FB(3)+RC(3)];

%Physical Characteristics
E = 207.0*10^9; %Pa
rho = (76.5*10^3)/9.80; %kg/m^3

%Moment of Inertia
    %Asuuming a rod
    Iy = pi*0.05^2/64;
    Iz = pi*0.05^2/64;
    I = pi*0.05^2/64;

%Constants of integration
C1(1) = (FA(2)*0.65^3/6 + FB(2)*0.3^3/6 - R0(2)*1.05^3/6)/1.05; %FIXME
C2(1) = 0;

C1(2) = (FA(3)*0.65^3/6 - FB(3)*0.3^3/6 - R0(3)*1.05^3/6)/1.05; %FIXME
C2(2) = 0;

X = linspace(0,1.05);
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
loading = loading(R0, FA, FB, RC);
savefig(loading, 'loading_diagram.fig')

%Shear Diagrams
[shear, Vy, Vz] = shear(X, R0, FA, FB, RC);
savefig(shear, 'shear_diagram.fig')

%Bending Moment Diagrams
[bending, My, Mz] = bending(X, R0, FA, FB, RC);
savefig(bending, 'bending_diagram.fig')

%Torsional Torque Diagrams
[torque, Tx] = torque(X, R0, FA, FB, RC);
savefig(torque, 'torque_diagram.fig')

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
[theta, thetaY, thetaZ] = theta(X, R0, FA, FB, RC, E, I, C1);
savefig(theta, 'angle_of_def_diagram.fig')

%Deflection plots
figure
subplot(1,2,1)
title('Deflection in y')
xlabel('x [m]')
ylabel('y [m]')
axis([0 1.05 -4*10^-5 4*10^-5])
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
axis([0 1.05 -4*10^-5 4*10^-5])
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
