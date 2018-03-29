function [sel_a, metric_a, sel_b, metric_b]=eACSBFLY_213(hd_a1,hd_a2,hd_b1,hd_b2,pstate1,pstate2,acc_a,acc_b)
%=============================================================================
%   function [sel_a, metric_a, sel_b, metric_b]
%          =eACSBFLY_213(hd_a1,hd_a2,hd_b1,hd_b2,pstate1,pstate2,acc_a,acc_b)
%
%   Radix-2 Add-Compare-Select Butterfly function for (2,1,3) decoder
%
%   John O'Shea, jfoshea@gmail.com
%   Copyright (c) 1999 John O'Shea, University of Limerick.
%   Revision: 1.0 Date: 13th July 2000
%
%==============================================================================

if nargin==0, 
   error('Not enough input arguments.'); 
end;

%ACS1-ADD
acs_metric(1,1) = acc_a + hd_a1;
acs_metric(1,2) = acc_b + hd_a2;
%ACS1-COMPARE
[minmetric,sel] = min(acs_metric);
%ACS1-SELECT
if sel==1,
   sel_a = 0;
else
   sel_a = 1;
end;
metric_a = minmetric;
   
%ACS2-ADD
acs_metric(1,1) = acc_a + hd_b1;
acs_metric(1,2) = acc_b + hd_b2;
%ACS2-COMPARE
[minmetric,sel]=min(acs_metric);
%ACS2-SELECT
if sel==1,
   sel_b = 0;
else
   sel_b = 1;
end;
metric_b = minmetric;

