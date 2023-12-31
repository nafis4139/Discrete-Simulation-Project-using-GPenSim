function [] = reserveInst(n, rai)
% function [] = reserveInst(n, rai)
%  reserve any available (free) instances of a recource
%
%  Input: 
%        n:   number of instances of a resource
%        rai: resource availability info (rai) that is generated by 
%               the function "availInst"
%
%  Output: (none)
%

%  Reggie.Davidrajuh@uis.no (c) Version 10.0 (c) 30 October 2014
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;
t_index = PN.attempting_trans;

%%% disp('Inside "reserveInst" ....');

r_index = rai.r_index;  % reosurce index
instance_indices = rai.instance_indices; %indices of abvailable instances
instance_indices = instance_indices(1:n); % chop to required number 

max_inst = PN.system_resources(r_index).max_instances;
x = zeros(1, max_inst); 
x(instance_indices) = t_index;

% add the newly reserved instances to the reserved_instances list
PN.system_resources(r_index).instance_usage(4, :) = ...
        PN.system_resources(r_index).instance_usage(4, :) + x;

% update "resources_reserved" list of the transiton
PN.global_transitions(t_index).resources_reserved(r_index) = ...
    PN.global_transitions(t_index).resources_reserved(r_index) + n;

% "instance_usage" of each resource in PN.system_resources:
%       "row-1: on_use", "row-2: start_of_use", "row-3: total_time used" 
%   and "row-4: reservation list"
