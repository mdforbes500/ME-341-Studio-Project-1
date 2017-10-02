function [BCMfig, n] = BCM(Sigma, SuT, SuC)
%BCM Summary of this function goes here
%   Detailed explanation goes here

%Computations for factor of safety
n = 1/(Sigma(1)/SuT - Sigma(3)/SuC);

%Visualization of the envelope
sigmaA = linspace(0, 4*10^8, 100);
sigmaB = -n*sigmaA;
BCMfig = figure(12);
title('BCM Theory Yield Envelope')
xlabel('\sigma_A [Pa]')
ylabel('\sigma_B [Pa]')
%axis([-4*10^8 4*10^8 -4*10^8 4*10^8])
grid on
hold on
plot(sigmaA, sigmaB, 'k-')
plot([SuT 0 -SuC 0 0 -SuC;0 SuT 0 -SuC SuT 0],[SuT SuT -SuC -SuC -SuC 0;SuT SuT -SuC -SuC 0 SuT], 'k-')
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
hold off

end

