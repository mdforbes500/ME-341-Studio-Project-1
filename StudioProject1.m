% Malcolm D. Forbes
% ME 341
% Studio Project 1

clc
clear
close all

%Force on A gear
F_a = 15*10^3; %N
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
S_ut = 31*10^3*(6894.75729); %Pa
S_uc = 109*10^3*(6894.75729); %Pa

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
    [MSSfig, n_MSS] = MSS(Sigma, S_yt);
    savefig(MSSfig, 'MSS_yield_envelope_diagram.fig')
    saveas(MSSfig, 'MSS_yield_envelope_diagram.jpg')
    
    %Distortion Energy (DE)
    [DEfig, n_DE] = DE(Sigma, S_yt);
    savefig(DEfig, 'DE_yield_envelope_diagram.fig')
    saveas(DEfig, 'DE_yield_envelope_diagram.jpg')
    
    %Dutile Coloumb-Mohr (DCM)
    [DCMfig, n_DCM] = DCM(Sigma, S_yt, S_yc);
    savefig(DCMfig, 'DCM_yield_envelope_diagram.fig')
    saveas(DCMfig, 'DCM_yield_envelope_diagram.jpg')
    
%Brittle Material Assumption
    %Maximum Normal Stress (MNS)
    [MNSfig, n_MNS] = MNS(Sigma, S_ut, S_uc);
    savefig(MNSfig, 'MNS_yield_envelope_diagram.fig')
    saveas(MNSfig, 'MNS_yield_envelope_diagram.jpg')
    
    %Brittle Coloumb-Mohr (BCM)
    [BCMfig, n_BCM] = BCM(Sigma, S_ut, S_uc);
    savefig(BCMfig, 'BCM_yield_envelope_diagram.fig')
    saveas(BCMfig, 'BCM_yield_envelope_diagram.jpg')
    
    %Modified-Mohr (MM)
    [MMfig, n_MM] = MM(Sigma, S_ut, S_uc);
    savefig(MMfig, 'MM_yield_envelope_diagram.fig')
    saveas(MMfig, 'MM_yield_envelope_diagram.jpg')
    
%Dynamic Failure Criteria
S_ut = 440*10^6; %Pa
S_end_prime = 0.5*S_ut;
k_a = 4.51*(S_ut*10^-6)^-0.265;
k_b = 1.24*50^-0.107;
k_c = 1;
S_e = k_a*k_b*k_c*S_end_prime; %Pa

sigma_m = 0;
sigma_a = sigma_bending;
tau_m = tau_torsion;
tau_a = 0;

    %General Combined Loading
    sigma_a_prime = sigma_a;
    sigma_m_prime = sqrt(3)*tau_m;
    
    %Soderberg
    
    %mod-Goodman
    
    %Gerber
    
    %ASME-Elliptic
    
    %Langer-yield Criteria

    
