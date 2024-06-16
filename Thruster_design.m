clear
clc

%total 4 thrusters
%each thruster has T thrust
%moment arm 150 mm from y and z axis

%T = 4e-3;
%r = 150e-3;

syms r T real

i = [1,0,0]'; j = [0,1,0]'; k = [0,0,1];


% position of 4 thrusters on the cube
r1 = r*[0, 0,-1]';
r2 = r*[0, 1, 0]';
r3 = r*[0, 0, 1]';
r4 = r*[0, -1,0]';

%% initial thrust direction of all thrusters

t_hat = i;  %initially all thruster thrust forcer in x dirction

%%cant angle 
syms theta real

offset = deg2rad(1.1);


%thrust directon

t1 = rot_z(theta)*i;
t2 = rot_y(theta)*i;
t3 = rot_z(-theta)*i;
t4 = rot_y(-theta)*i;

%thrust with direction
T1 = T*t1;
T2 = T*t2;
T3 = T*t3;
T4 = T*t4;



%% 

torque1 = cross(r1,T1);
torque2 = cross(r2,T2);
torque3 = cross(r3,T3);
torque4 = cross(r4,T4);


%% real system with misalignment and offset

t1R = rot_z(theta + 0.0175)*i;
t2R = rot_y(theta + 0.0192)*i;
t3R = rot_z(-theta + 0.0209)*i;
t4R = rot_y(-theta + 0.0227)*i;

r1R = r*[0, 0,-1]' + [0.015,0,0]';
r2R = r*[0, 1, 0]' + [0.015,0,0]';
r3R = r*[0, 0, 1]' + [0.015,0,0]';
r4R = r*[0, -1,0]' + [0.015,0,0]';

torque1R = cross(r1R,t1R);
torque2R = cross(r2R,t2R);
torque3R = cross(r3R,t3R);
torque4R = cross(r4R,t4R);


tau_M =      [torque1 torque2 torque3 torque4]/T;
taU_M_real = [torque1R torque2R torque3R torque4R];

ideal = eval(subs(tau_M,[r,theta],[0.15,atan(0.5)]));
real  = eval(subs(taU_M_real,[r,theta],[0.15,atan(0.5)]));




%matlabFunction(tau_M,'File','torque_matrix.m','Optimize',true,'Comments','%pixxel all thrusters around x axis')

%% thrust calculation

omega = 0.6*deg2rad(5); % 80% linear range of IMU 
I_min = 3.72;
phi_max = deg2rad(180);

t = phi_max/omega;

syms t0 t1 alpha real

t0 = 15;
eqn1 = alpha*t0 == omega;
%eqn2 = (alpha*t0*t0/2) + omega*(t-2*t0) == phi_max;

alpha = solve(eqn1, alpha);
tau = alpha*I_min;

thrust = eval(tau/0.15);
thrust = thrust/cos(atan(0.5));







function R = rot_z(theta)

    R = [cos(theta),-sin(theta),0;
         sin(theta), cos(theta),0;
                  0,          0,1];
end

function R = rot_y(theta)

    R = [cos(theta), 0,  sin(theta);
                  0, 1,          0;
        -sin(theta), 0, cos(theta);];

end