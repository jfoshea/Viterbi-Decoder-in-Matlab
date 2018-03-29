function [sel_out, metric_out]  =fACS_213(t,L,hd_in1,hd_in2,acc_in1,acc_in2)
%============================================================================================
%	function [sel_out,metric_out]=fACS_213(t,L,hd_in1,hd_in2,acc_in1,acc_in2)
%
%	Add-Compare-Select function for (2,1,3) decoder
%
%   John O'Shea, jfoshea@gmail.com
%   Copyright (c) 1999 John O'Shea.
%   Revision: 1.0 Date: 16th August 1999
%
%============================================================================================

if nargin==0, 
   error('Not enough input arguments.'); 
end;

if t<L,
   metric_out=acc_in1+hd_in1;
   sel_out=1;
else
   %ADD
   acs_metric(1,1) = acc_in1 + hd_in1;
   acs_metric(1,2) = acc_in2 + hd_in2;
   %COMPARE
   [minmetric,sel] = min(acs_metric);
   %Select
   sel_out=sel;
   metric_out = minmetric;
end;
   
