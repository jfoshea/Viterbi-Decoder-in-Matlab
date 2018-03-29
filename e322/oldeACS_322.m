function [sel_out, metric_out]  =eACS_322(x,m,HD_in1,HD_in2,HD_in3,HD_in4,A_in1,A_in2,A_in3,A_in4)
%=============================================================================
% function [sel_out, metric_out]
%    =eACS_322(x,m,HD_in1,HD_in2,HD_in3,HD_in4,A_in1,A_in2,A_in3,A_in4)
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

if x<m,
   %ACS-ADD
   PPM(1,1) = A_in1 + HD_in1;
   PPM(1,2) = A_in2 + HD_in2;
   %ACS-COMPARE
   [minmetric,sel] = min(PPM);
   %ACS-SELECT
   sel_out = sel;
   metric_out = minmetric;
else
   %ACS-ADD
   PPM(1,1) = A_in1 + HD_in1;
   PPM(1,2) = A_in2 + HD_in2;
   PPM(1,3) = A_in3 + HD_in3;
   PPM(1,4) = A_in4 + HD_in4;
   %ACS-COMPARE
   [minmetric,sel] = min(PPM);
   %ACS-SELECT
   sel_out = sel;
   metric_out = minmetric;
end;
   
   

