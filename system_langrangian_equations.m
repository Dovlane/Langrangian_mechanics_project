function [Nr,Nz,Nlambda] = system_langrangian_equations()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    syms z(t) r(t) m omega t lambda g b epsilon a_r a_z v_r(t) v_z(t)
    dot_r = diff(r, t);
    dot_z = diff(z, t);
    
    T = 0.5*m*(dot_z^2 + dot_r^2) + 0.5*m*(omega*r)^2;
    U = m * g * z(t);
    
    f = z - b*r^2;
    fr = diff(f, r);
    fz = diff(f, z);
    frr = diff(fr, r);
    frz = diff(fr, z);
    fzr = frz;
    fzz = diff(fz, z);
    
    F = [frr, frz; fzr, fzz];
    Vr = diff(r, t);
    Vz = diff(z, t);
    V = [Vr Vz];
    
    C = V*F*transpose(V) + 2*epsilon*(fr*Vr + fz*Vz) + epsilon^2*f;
    L = T - U;
    
    Nr = diff(L, r) + lambda * diff(f, r) - diff(diff(L, diff(r, t)), t);
    Nr = subs(Nr, diff(r, t, 2), a_r);
    Nz = diff(L, z) + lambda * diff(f, z) - diff(diff(L, diff(z, t)), t);
    Nz = subs(Nz, diff(z, t, 2), a_z);
    Nlambda = -(fr * a_r + fz * a_z) - C;
    Nlambda = subs(Nlambda, diff(r, t), v_r);
    Nlambda = subs(Nlambda, diff(z, t), v_z);
end