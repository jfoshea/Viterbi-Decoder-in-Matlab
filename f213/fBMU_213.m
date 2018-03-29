function [HD]=fBMU_213(Rx)
%======================================================
%	function [HD]=fBMU_213(Rx)
%
%	Branch Metric Unit for (2,1,3) decoder
%   - Look Up Branch Metrics (Hamming distance)
%     for entire trellis stage
%
%   John O'Shea, jfoshea@gmail.com 11th August 1999
%   Copyright (c) 1999 John O'Shea.
%   Revision: 1.0 Date: 16th August 1999
%
%======================================================

if nargin==0, 
   error('Not enough input arguments.'); 
end;

Rxd=b2d(Rx);

if Rxd==0,
   HD=[0,2,1,1,2,0,1,1,2,0,1,1,0,2,1,1];

elseif Rxd==1,
   HD=[1,1,0,2,1,1,2,0,1,1,2,0,1,1,0,2];
   
elseif Rxd==2,
   HD=[1,1,2,0,1,1,0,2,1,1,0,2,1,1,2,0];
   
else,
   HD=[2,0,1,1,0,2,1,1,0,2,1,1,2,0,1,1];
   
end;   

