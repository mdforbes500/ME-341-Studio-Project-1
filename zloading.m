function [M, V, tau] = zloading(X, R0, FA, FB, RC)
%ZLOADING Describes loading configuration in the x-z and x-y planes for system A.
%   Uses FOR loop to describe the loading in the x-z plane at each point in
%   the system A along the length.

[Vy,Vz, My, Mz, tau] = zshear(X, R0, FA, FB, RC);

M = sqrt(My^2 + Mz^2);
V = sqrt(Vz^2 + Vy^2);

end

