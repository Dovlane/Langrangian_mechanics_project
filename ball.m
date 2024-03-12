function drdz = ball(t, X, b, omega, xi, m)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    %X : r1 r2 z1 z2

    g = 9.81;
    drdz = zeros(4, 1);
    r = X(1);
    v_r = X(2);
    z = X(3);
    v_z = X(4);

    C = xi^2*(z-b*r^2) - 2*b*v_r^2 + 2*xi*(v_z-2*b*r*v_r);
    A =[-m, 0, -2*b*r; 0, -m, 1; 2*b*r, -1, 0];
    B = [-m*r*omega^2; m*g; C];

    dX = A^-1 * B;

    drdz(1) = X(2); %v_r 
    drdz(3) = X(4); %v_z 
    drdz(2) = dX(1);
    drdz(4) = dX(2);
end