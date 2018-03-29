function [sel_out, metric_out]  =bACS_213(HD_in1,HD_in2,A_in1,A_in2)
%====================================================================
%	function [sel_out,metric_out]=bACS_213(HD_in1,HD_in2,A_in1,A_in2)
%
%	Add-Compare-Select function for (2,1,3) decoder
%
%   John O'Shea, jfoshea@gmail.com
%====================================================================

if nargin==0, 
   error('Not enough input arguments.'); 
end;

%ACS-ADD, Note: Includes Upper Bound = 15 (4'b1111 for 4-bit digital accumulator)
if A_in1 >= 15,
   PPM(1,1)=15;
else
   PPM(1,1) = A_in1 + HD_in1;
end;

if A_in2 >= 15,
   PPM(1,2)=15;
else
   PPM(1,2) = A_in2 + HD_in2;
end;

%COMPARE
[minmetric,sel] = min(PPM);

%Select
sel_out=sel;
metric_out = minmetric;
   
