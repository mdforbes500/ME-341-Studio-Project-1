function [ MNSfig, n ] = MNS(Sigma, SuT, SuC)
%MNS Summary of this function goes here
%   Detailed explanation goes here

%Computation of factor of safety
n = SuT/Sigma(1);

%Visulaization of envelope
sigmaA = linspace(0, 4*10^8, 100);
sigmaB = -n*sigmaA;
MNSfig = figure(11);
title('MNS Theory Yield Envelope')
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

