function [D]= eTRACEBACK_213(P,A,m,D,N,T,x)
%=================================================
%   function [D]= eTRACEBACK_213(P,A,m,D,N,T,x)
%
%   (2,1,3) Efficient Backward Label Traceback Function
%
%	 Returns D, The Decoded Message up to stage x
%
%   John O'Shea, jfoshea@gmail.com, 26th July 2000
%   Copyright (c) 1999 John O'Shea.
%   Revision: 1.0 Date: 26th July 1999
%=================================================

if nargin==0, 
   error('Not enough input arguments.');
end;
% Find Traceback start state
[min_metric,tb_ptr]=eTBDECISION_213(A);
% Perform Traceback process
for stage_ptr = T : -1: 1,
   if stage_ptr == T,
      Bx=B2D(P((tb_ptr+1),stage_ptr));
      Sx=D2B(tb_ptr,m);
   else
      Sx_1=B2D(Sx_1);
      Bx=B2D(P((Sx_1+1),stage_ptr));
      Sx=D2B(Sx_1,m);
   end;
   Sx_1=[Bx Sx(1,1) Sx(1,2)];
end;
% Find Decoded Symbol, Dx
Dx    =[Sx(1,m)];
% Append Decoded Symbol to Maximum Likelihood path, D
D     =[D Dx];
   




   
