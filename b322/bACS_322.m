function [sel_out, metric_out]  =bACS_322(HD_in1,HD_in2,HD_in3,HD_in4,A_in1,A_in2,A_in3,A_in4)
%====================================================================
% function [sel_out, metric_out]
%    =bACS_322(HD_in1,HD_in2,HD_in3,HD_in4,A_in1,A_in2,A_in3,A_in4)
%	Add-Compare-Select Block for (3,2,2) decoder
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

if A_in3 >= 15,
   PPM(1,3)=15;
else
   PPM(1,3) = A_in3 + HD_in3;
end;

if A_in4 >= 15,
   PPM(1,4)=15;
else
   PPM(1,4) = A_in4 + HD_in4;
end;

%ACS-COMPARE
[minmetric,sel] = min(PPM);

%ACS-SELECT
sel_out = sel;
metric_out = minmetric;
   
   

