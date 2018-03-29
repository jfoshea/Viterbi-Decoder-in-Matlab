function [sel_out, metric_out]  =fACS_322(t,L,hd_in1,hd_in2,hd_in3,hd_in4,acc_in1,acc_in2,acc_in3,acc_in4)
%=============================================================================
% function [sel_out, metric_out]
%    =fACS_322(t,L,hd_in1,hd_in2,hd_in3,hd_in4,acc_in1,acc_in2,acc_in3,acc_in4)
%
%	Add-Compare-Select Block for (3,2,2) decoder
%
%   John O'Shea, jfoshea@gmail.com
%   Copyright (c) 1999 John O'Shea.
%   Revision: 1.0 Date: 16th August 1999
%
%==============================================================================

if nargin==0, 
   error('Not enough input arguments.'); 
end;

if t<L,
   %ACS-ADD
   acs_metric(1,1) = acc_in1 + hd_in1;
   acs_metric(1,2) = acc_in2 + hd_in2;
   %ACS-COMPARE
   [minmetric,sel] = min(acs_metric);
   %ACS-SELECT
   sel_out = sel;
   metric_out = minmetric;
else
   %ACS-ADD
   acs_metric(1,1) = acc_in1 + hd_in1;
   acs_metric(1,2) = acc_in2 + hd_in2;
   acs_metric(1,3) = acc_in3 + hd_in3;
   acs_metric(1,4) = acc_in4 + hd_in4;
   %ACS-COMPARE
   [minmetric,sel] = min(acs_metric);
   %ACS-SELECT
   sel_out = sel;
   metric_out = minmetric;
end;
   
   

