 function [user] = check_measurement_set(user, msr)

%--------------------------------------------------------------------------
% Checks input values for measurement sets.
%
% The function checks 'pmuRedundancy', 'pmuDevice', 'legRedundancy', and
% 'legDevice' values, given as input arguments of the function leeloo in
% the 'state_estimation.m' or 'power_estimation.m'. If variables are
% missing or are not properly defined, we add default values, which allows
% to execute a code without errors.
%--------------------------------------------------------------------------
%  Inputs:
%	- user: user inputs
%	- msr: measurement data
%
%  Outputs:
%	- user.pmuRedundancy: set according to redundancy for legacy
%	  measurements
%	- user.legDevice: set according to devices for legacy measurements
%	- user.pmuRedundancy: set according to redundancy for phasor
%	  measurements
%	- user.pmuDevice: set according to devices for phasor measurements
%--------------------------------------------------------------------------
% Check function which is used in state estimation modules.
%--------------------------------------------------------------------------


%----------------------Check Phasor Measurement Set------------------------
 if user.setpmu == 1 && ~isempty(user.pmuRedundancy) && (~isvector(user.pmuRedundancy) || ~(length(user.pmuRedundancy) == 1)  || user.pmuRedundancy < 0 || user.pmuRedundancy > msr.mred(2))
	user.pmuRedundancy = msr.mred(2);
	warning('se:pmuRedundancy', ['The value pair argument of the '...
	'variable "pmuRedundancy" has invalid type. The algorithm ' ...
	'proceeds with default value: %1.2f.\n'], msr.mred(2))
 elseif user.setpmu == 1 && isempty(user.pmuRedundancy)
	user.pmuRedundancy = msr.mred(2);
 end

if user.setpmu == 2 && ~isempty(user.pmuDevice) && (~isvector(user.pmuDevice) || ~(length(user.pmuDevice) == 1) || user.pmuDevice < 0 || user.pmuDevice > msr.dpmu)
	user.pmuDevice = msr.dpmu;
	warning('se:legDevice', ['The value pair argument of the '...
	'variable "pmuDevice" has invalid type. The algorithm ' ...
	'proceeds with default value: %1.f.\n'], msr.dpmu)
 elseif user.setpmu == 2 && isempty(user.pmuDevice)
	user.pmuDevice = msr.dpmu;
end
%--------------------------------------------------------------------------


%----------------------Check Legacy Measurement Set------------------------
 if user.setleg == 1 && ~isempty(user.legRedundancy) && (~isvector(user.legRedundancy) || ~(length(user.legRedundancy) == 1)  || user.legRedundancy < 0 || user.legRedundancy > msr.mred(1))
	user.legRedundancy = msr.mred(1);
	warning('se:legRedundancy', ['The value pair argument of the '...
	'variable "legRedundancy" has invalid type. The algorithm ' ...
	'proceeds with default value: %1.2f.\n'], msr.mred(1))
 elseif user.setleg == 1 && isempty(user.legRedundancy)
	user.legRedundancy = msr.mred(1);
 end

 if user.setleg == 2 && ~isempty(user.legDevice)
	dim = size(user.legDevice);
	if dim(1) == 1
	   user.legDevice = user.legDevice';
	end
	if ~isvector(user.legDevice) || ~(length(user.legDevice) == 4) || any(user.legDevice < 0) || any(user.legDevice > msr.dleg)
	   user.legDevice = msr.dleg;
	   warning('se:legDevice',['The value pair argument of the '...
	   'variable "legDevice" has invalid type. The algorithm ' ...
	   'proceeds with default value: [%1.f %1.f %1.f %1.f].\n'], ...
	   msr.dleg(1), msr.dleg(2), msr.dleg(3), msr.dleg(4))
	end
 elseif user.setleg == 2 && isempty(user.legDevice)
	user.legDevice = msr.dleg;
 end
%--------------------------------------------------------------------------