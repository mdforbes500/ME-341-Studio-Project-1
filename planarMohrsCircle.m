function [Sigma, tau_max] = planarMohrsCircle( sigma_x, sigma_y, tau_xy )
%PLANARMOHRSCIRCLE Summary of this function goes here
%   Detailed explanation goes here

%Computation of planar principal stresses
temp = zeros(1, 3);
temp(1) = (sigma_x+sigma_y)/2 + sqrt(((sigma_x-sigma_y)/2)^2 + tau_xy^2);
temp(2) = (sigma_x+sigma_y)/2 - sqrt(((sigma_x-sigma_y)/2)^2 + tau_xy^2);
temp(3) = 0;

if temp(1) >= temp(2) && temp(2) >= temp(3)
    Sigma(1) = temp(1);
    Sigma(2) = temp(2);
    Sigma(3) = temp(3);
elseif temp(1) >= temp(3) && temp(3) >= temp(2)
    Sigma(1) = temp(1);
    Sigma(2) = temp(3);
    Sigma(3) = temp(2);
elseif temp(3) >= temp(1) && temp(1) >= temp(2)
    Sigma(1) = temp(3);
    Sigma(2) = temp(1);
    Sigma(3) = temp(2);
else
    Sigma(1) = temp(1);
    Sigma(2) = temp(2);
    Sigma(3) = temp(3); 
end

%Maximum shear stress computation
tau_max = sqrt(((sigma_x-sigma_y)/2)^2 + tau_xy^2);

end

