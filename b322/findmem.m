function [M,L]=findmem(n,k,m,g)
%==============================================
%	function [M,L]=findmem(n,k,m,g)
%
%	Calculates amount of encoder state memory,
%  called enc_mem, for k/n encoders
%
%   John O'Shea, jfoshea@gmail.com
%==============================================

if nargin==0, 
   error('Not enough input arguments.'); 
end;

M=0;
[rows,L]=size(g);
if (rows/n)==1,
   M=m;
else
   for i=1:rows/n,
      for j=1:L,
         if g(i,j)==1,
            M=M+1;
         end;
      end;
   end;
end;
