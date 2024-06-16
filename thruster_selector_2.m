function firing_seq_1 = thruster_selector(pwpf_out)

%total 4 thrusters
%each thruster has T thrust
%moment arm 150 mm from y and z axisfir

firing_seq_1 = logical([1,1,1,1]');

if norm(pwpf_out) == sqrt(3)
    pwpf_out = [1*pwpf_out(1),1*pwpf_out(2),1*pwpf_out(3)]';
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
    firing_seq = [0,1,1,1]';
    firing_seq_1 = logical(firing_seq);
end


if pwpf_out(1) == -1 && pwpf_out(2) == -1
    firing_seq = [1,1,0,1]';
    firing_seq_1 = logical(firing_seq);
end



if pwpf_out(1) == -1 && pwpf_out(3) == 1
    firing_seq = [1,0,1,1]';
    firing_seq_1 = logical(firing_seq);
end


if pwpf_out(1) == -1 && pwpf_out(3) == -1
    firing_seq = [1,1,1,0]';
    firing_seq_1 = logical(firing_seq);
end



end
