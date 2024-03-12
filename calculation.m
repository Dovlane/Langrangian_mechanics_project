clear all
close all
clc

set(0,'defaulttextinterpreter','latex')


num = 10001;
t = linspace(0,10,num);
%options = odeset('RelTol',1e-3,'AbsTol',1e-6, 'Stats','on');
options = odeset;

b = 2;
xi = 3000;
omega = pi;
m = 1000;

%pocetni uslovi
r_0 = 2;
v_r0 = 0; 
z_0 = b * r_0^2;
v_z0 = 0;


[t, res] = ode45(@ball, t, [r_0, v_r0, z_0, v_z0], options, b, omega, xi, m);


r_val = res(:, 1);
v_r_val = res(:, 2);
z_val = res(:, 3);
v_z_val = res(:, 4);

%%


%grafici koordinata u zavisnosti od vremena
f = figure();
f.Name = 'v_r(t)';
plot(t, v_r_val)
xlabel('$t$ [s]')
ylabel('$v_r$ [m/s]')
title('Vremenska zavisnost brzine koordinate $v_r$ [m/s]')


