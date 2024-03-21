clear all
close all
clc

set(0,'defaulttextinterpreter','latex')


num = 10001;
time = 10;
t = linspace(0,time,num);
%options = odeset('RelTol',1e-3,'AbsTol',1e-6, 'Stats','on');
options = odeset;

%{
b = 2;
xi = 3000;
omega = pi;
m = 1000;
%}
b = 1;
xi = 1000;
omega = 3;
m = 1;
g = 9.81;

%pocetni uslovi
r_0 = 0.1;
v_r0 = 0; 
z_0 = b * r_0^2;
v_z0 = 0;


[t, res] = ode45(@ball, t, [r_0, v_r0, z_0, v_z0], options, b, omega, xi, m);


r_val = res(:, 1);
phi_val = t * omega;
v_r_val = res(:, 2);
z_val = res(:, 3);
v_z_val = res(:, 4);

%%

% Graph dependency of coordinates with respect to time

f1 = figure();
f1.Name = 'Graph dependency of coordinates with respect to time';
plot(t, r_val)
hold on
plot(t, z_val)
xlabel('$time$ [s]')
ylabel('$distance$ [m]')
legend('r(t)', 'z(t)');
title('Graph dependency of coordinates with respect to time')
hold off

%%

f2 = figure();
f2.Name = 'constraint function';
fc = zeros(num,1);
for c = 1:num
    fc(c) = z_val(c) - b*r_val(c)^2;
end

plot(t,fc);
ylim([-1 1]);

legend('z-b*r^2','location','best');
xlabel('t');
ylabel('z-b*r^2');
title('Constraint function');


%%

f3 = figure();
f3.Name = 'z component of generalised force ';
lambda = zeros(num,1);
a_z_val = zeros(num, 1);
dt = time / (num - 1);
for c = 1:num-1
    a_z_val(c) = (v_z_val(c+1) - v_z_val(c)) / dt;
end
for c = 1:num-1
    lambda(c) = m * (a_z_val(c) + g);
end
lambda(num) = lambda(num - 1);

plot(t,lambda);
ylim([9.6 10.05]);
legend('\lambda','location','best');
xlabel('t');
ylabel('/lambda');
title('Force z component');


%%

f4 = figure();
f4.Name = 'r component of generalised force ';
F_r = zeros(num, 1);
for c = 1:num
    F_r(c) = - 2 * b * r_val(c) * lambda(c);
end

plot(t, F_r);

legend('$F_r$','location','best');
xlabel('t');
ylabel('$F_r$');
title('Force r component');


%%

f5 = figure();
f5.Name = 'Trajectory';
plot3(r_val,z_val,phi_val,'-r');
title('Trajectory');

%%




%%


f1 = figure();
f1.Name = 'Graph dependency of speed projections with respect to time';
plot(t, v_r_val)
hold on
plot(t, v_z_val)
xlabel('$time$ [s]')
ylabel('$velocities$ [m/s]')
legend('v_r(t)', 'v_z(t)');
title('Graph dependency of speed projections with respect to time')
hold off

%%

f1 = figure();
f1.Name = 'Graph dependency of coordinates with respect to time';
plot(t, r_val)
hold on
plot(t, z_val)
xlabel('$time$ [s]')
ylabel('$distance$ [m]')
legend('r(t)', 'z(t)');
title('Graph dependency of coordinates with respect to time')
hold off


%%

f1 = figure();
hold on
f1.Name = 'Value of constraint function with respect to time';
plot(t, F)
xlabel('$time$ [s]')
ylabel('$distance$ [m]')
legend('r(t)', 'z(t)');
title('Graph dependency of coordinates with respect to time')
hold off
