function [DEfig, n] = DE(Sigma, Sy)
%DE Summary of this function goes here
%   Detailed explanation goes here

%Computation of von-Mises stress
sigma_VM = sqrt(Sigma(1)^2 - Sigma(1)*Sigma(3) + Sigma(3));

n = Sy/sigma_VM;

%Visulaization of DE Envelope
sigmaAA = linspace(0, 4*10^8, 100);
sigmaA = linspace(-3.434*10^8, 3.434*10^8, 100);
sigmaB = -n*sigmaAA;
upper_envelope = 0.5*(sigmaA + sqrt(4*Sy^2-3*sigmaA.^2));
lower_envelope = 0.5*(sigmaA - sqrt(4*Sy^2-3*sigmaA.^2));
DEfig = figure(9);
title('DE Theory Yield Envelope')
xlabel('\sigma_A [Pa]')
ylabel('\sigma_B [Pa]')
axis([-4*10^8 4*10^8 -4*10^8 4*10^8])
grid on
hold on
plot(sigmaAA, sigmaB, 'k-')
plot(sigmaA, upper_envelope, 'k-')
plot(sigmaA, lower_envelope, 'k-')
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
hold off

end

