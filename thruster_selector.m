function firing_seq_1 = thruster_selector(pwpf_out)

%total 4 thrusters
%each thruster has T thrust
%moment arm 150 mm from y and z axis

if norm(pwpf_out) == sqrt(3)
    pwpf_out = [0,pwpf_out(2),pwpf_out(3)]';
end

x = [pwpf_out(1);0;0];
y = [0;pwpf_out(2);0];
z = [0;0;pwpf_out(3)];

firing_seq_x = [1,1,1,1]';
firing_seq_y = [1,1,1,1]';
firing_seq_z = [1,1,1,1]';


%%
if pwpf_out(1) == 1
    firing_seq_x = [1,0,1,0]';
end

if pwpf_out(1) == -1
    firing_seq_x = [0,1,0,1]';
end


%%
if pwpf_out(2) == 1
    firing_seq_y = [0,1,1,1]';
end

if pwpf_out(2) == -1
    firing_seq_y = [1,1,0,1]';
end


%%
if pwpf_out(3) == 1
    firing_seq_z = [1,0,1,1]';
end

if pwpf_out(3) == -1
    firing_seq_z = [1,1,1,0]';
end

%%
if pwpf_out(1) == 0 && pwpf_out(2) == 0 && pwpf_out(3) == 0
    firing_seq_x = [0,0,0,0]';
    firing_seq_y = [0,0,0,0]';
    firing_seq_z = [0,0,0,0]';
end

firing_seq_1 = firing_seq_x & firing_seq_y & firing_seq_z;


%%
%
if pwpf_out(1) == -1 && pwpf_out(2) == 1
    firing_seq_1 = [0,1,1,1];
end


if pwpf_out(1) == -1 && pwpf_out(2) == -1
    firing_seq_1 = [1,1,0,1];
end



if pwpf_out(1) == -1 && pwpf_out(3) == 1
    firing_seq_1 = [1,0,1,1];
end


if pwpf_out(1) == -1 && pwpf_out(3) == -1
    firing_seq_1 = [1,1,1,0];
end
%}
%%




%T = 4e-3;
r = 150e-3;
theta = pi/4;

%tau_M = torque_matrix(r,theta);

%{
tau_M = [ 0.1061   -0.1061    0.1061   -0.1061
         -0.1061         0    0.1061         0
               0   -0.1061         0    0.1061];

%}

tau_M = [ 0.0671   -0.0671    0.0671   -0.0671
         -0.1342         0    0.1342         0
               0   -0.1342         0    0.1342];

pseudoInv_M = pinv(tau_M); 

selector = pseudoInv_M*pwpf_out;

for j = 1:4
    if (abs(selector(j))<1e-3)
        
        selector(j) = 0;
        
    end
end

for i = 1:4
    
    if (sign(selector(i)) == 1 || selector(i) == 0)
        firing_seq(i) = 1;
    end

end


 if norm(pwpf_out) == 0
     firing_seq = [0,0,0,0]';
 end


end
