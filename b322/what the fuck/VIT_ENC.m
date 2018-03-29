function [Vx] = VIT_ENC(Ux,n,k,g,N)
%===========================================================
%	function [Vx] = VIT_EN(Ux,n,k,g,N)
% 
%	Implements a convolutional encoder having given 
%  the generator matrix g of the encoder.
%   
%  Reference Digital Communications (B. Sklar) for method 
%	 
%   John O'Shea, jfoshea@gmail.com 11th August 1999
%   Copyright (c) 1999 John O'Shea.
%   Revision: 1.0 Date: 11th August 1999
%============================================================

if nargin==0, 
   error('Not enough input arguments.'); 
end;

[rows,L] = size(g);

if k==1,
   for i=1:rows,
      code(i,:)=rem(conv(g(i,:),Ux),2);
   end;
else
   for i=1:k:rows,
      code(i,:)=rem(conv(g(i,:),Ux(1,:)),2);
      code(i+1,:)=rem(conv(g(i+1,:),Ux(2,:)),2);
   end;
end;

if k==1,
   for i=1:N+L-1,
      Vx((i-1)*n+1:(i-1)*n+n) = code(:,i);
   end;
else
   i=1;
   j=1;
   while i<rows+1,
      codeword(j,:) = xor(code(i,:),code(i+1,:));
      i=i+k;
      j=j+1;
   end;
   for i=1:N+L-1,
      Vx((i-1)*n+1:(i-1)*n+n) = flipud(codeword(:,i));
   end;
   %Add on flushing zeros      
   Vx(length(Vx)+1:n*(N+L)) = [0];
end;

