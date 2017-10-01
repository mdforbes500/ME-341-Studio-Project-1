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
S_y = 295*10^6; %Pa
S_yt = 300*10^6; %Pa
S_yc = 350*10^6; %Pa
S_ut = 31*10^3/(6894.75729); %Pa
S_uc = 109*10^3/(6894.75729); %Pa

%Moment of Inertia
    %Asuuming a rod
    I = pi*0.05^2/64;
    J = pi*0.05^4/32;

%Constants of integration
C1(1) = (FA(2)*0.65^3/6 + FB(2)*0.3^3/6 - R0(2)*1.05^3/6)/1.05; %FIXME
C2(1) = 0;

C1(2) = (FA(3)*0.65^3/6 - FB(3)*0.3^3/6 - R0(3)*1.05^3/6)/1.05; %FIXME
C2(2) = 0;

N = 10000;
X = linspace(0,1.05, N);

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

%Angle of Deflection Plots
[theta, thetaY, thetaZ] = theta(X, R0, FA, FB, RC, E, I, C1);
savefig(theta, 'angle_of_def_diagram.fig')

%Deflection plots
[deflection, Y, Z] = deflection(X, R0, FA, FB, RC, E, I, C1, C2);
savefig(deflection, 'deflection_diagram.fig')

%Combined Shear and Moment Plots
[VMplot, V, M] = combineVM(X, Vy, Vz, My, Mz);
savefig(VMplot, 'combined_shear_and_moment_diagram.fig')

%Maximum Stresses Computation
sigma_bending = 32*max(M)/(pi*0.050^3);
tau_torsion = 16*max(-1*Tx)/(pi*0.050^3);
disp(sigma_bending)
disp(tau_torsion)

    %Mohr's Circle Calculuation
    [Sigma, tau_max] = planarMohrsCircle(sigma_bending, 0, tau_torsion);

%Factor of Safety Calculuations

%Ductile Material Assumption
    %Maximum Shear Stress (MSS)
    
    %Distrotion Energy (DE)
    
    %Dutile Coloumb-Mohr (DCM)
    
%Brittle Material Assumption
    %Maximum Normal Stress (MNS)
    
    %Brittle Coloumb-Mohr (BCM)
    
    %Modified-Mohr (MM)
    
