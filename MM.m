function [MMfig, n] = MM(Sigma, SuT, SuC)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

%Computation of the factor of safety
n = SuT/Sigma(1);

%Visualization
sigmaA = linspace(0, 4*10^8, 100);
sigmaB = -n*sigmaA;
MMfig = figure(13);
title('MM Theory Yield Envelope')
xlabel('\sigma_A [Pa]')
ylabel('\sigma_B [Pa]')
%axis([-4*10^8 4*10^8 -4*10^8 4*10^8])
grid on
hold on
plot(sigmaA, sigmaB, 'k-')
plot([SuT; SuT],[SuT; -SuT], 'k-')
plot ([SuT; -SuT], [0; -SuC], 'k-')
plot ([0; -SuC], [-SuC; -SuC], 'k-')
plot ([-SuC; -SuC], [-SuC; 0], 'k-')
plot ([-SuC; 0], [-SuT; SuT], 'k-')
plot ([-SuT; SuT], [SuT; SuT], 'k-')
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
hold off
end

