function [sel_out, metric_out]  =eACS_213(x,m,HD_in1,HD_in2,A_in1,A_in2)
%============================================================================================
%	function [sel_out,metric_out]=eACS_213(x,m,HD_in1,HD_in2,A_in1,A_in2)
%
%	Add-Compare-Select function for (2,1,3) decoder
%
%   John O'Shea, jfoshea@gmail.com
%
%============================================================================================

if nargin==0, 
   error('Not enough input arguments.'); 
end;

if x <= m,
   metric_out = A_in1 + HD_in1;
   sel_out = 1;
else
   %ADD
   PPM(1,1) = A_in1 + HD_in1;
   PPM(1,2) = A_in2 + HD_in2;
   %COMPARE
   [minmetric,sel] = min(PPM);
   %Select
   sel_out=sel;
   metric_out = minmetric;
end;
   
