function [D]= fTRACEBACK_213(P,A,H,m,D,N,T,x)
%===================================================
%   function [D]= fTRACEBACK_213(P,A,H,m,D,N,T,x)
%
%   (2,1,3) Forward Label Traceback Function
%
%	 D     = Decoded Message up to stage x
%   MLDpath = Surviving Trellis Path
%
%   John O'Shea, jfoshea@gmail.com, 26th July 2000
%   Copyright (c) 1999 John O'Shea.
%   Revision: 1.0 Date: 26th July 1999
%===================================================
if nargin==0, 
   error('Not enough input arguments.');
end;

% Find Traceback start state
[min_metric,tb_ptr]=fTBDECISION_213(A);
M=[];
% Perform Traceback process
if x <= N+m,
   for stage_ptr = T: -1: m-1,
      if stage_ptr==T,
         M=H(tb_ptr+1,stage_ptr);
         Fx = P(tb_ptr+1,stage_ptr);
      else
         Fx = P(M+1,stage_ptr);
         M  = H(M+1,stage_ptr);
      end;
   end;
   Dx = [Fx];
   D  = [Dx D];
else
   % Find remaining bits
   for stage_ptr = T: -1: m-1,
      if stage_ptr==T,
        M  = H(tb_ptr+1,stage_ptr);
        Fx = P(tb_ptr+1,stage_ptr);
      else
        Fx = P(M+1,stage_ptr);
        M  = H(M+1,stage_ptr);
      end;
      Dx = [Fx];
      D = [Dx D];
   end;
end;
   




   
