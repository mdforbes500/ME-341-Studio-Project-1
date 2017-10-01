function [ DCMfig, n ] = DCM( Sigma, SyT, SyC )
%DCM Summary of this function goes here
%   Detailed explanation goes here

%Computation of n
n = 1/(Sigma(1)/SyT - Sigma(3)/SyC);

%Visulaization of envelope
sigmaA = linspace(0, 4*10^8, 100);
sigmaB = -n*sigmaA;
DCMfig = figure(10);
title('DCM Theory Yield Envelope')
xlabel('\sigma_A [Pa]')
ylabel('\sigma_B [Pa]')
axis([-4*10^8 4*10^8 -4*10^8 4*10^8])
grid on
hold on
plot(sigmaA, sigmaB, 'k-')
plot([SyT 0 -SyC 0 0 -SyC;0 SyT 0 -SyC SyT 0],[SyT SyT -SyC -SyC -SyC 0;SyT SyT -SyC -SyC 0 SyT], 'k-')
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
hold off

end

