function [bin_num] = D2B(dec_num,m)
%=============================================================================
%	function [bin_num] = B2D(dec_num,m)
%
%	Decimal to Binary Conversion
%
%   John O'Shea, jfoshea@gmail.com 11th August 1999
%   Copyright (c) 1999 John O'Shea.
%   Revision: 1.0 Date: 16th August 1999
%
%==============================================================================

[nrows,ncols] = size(dec_num);
if nrows==1,
 dec_num = dec_num';
end;

N = length(dec_num);
M = max(dec_num);
n = nextpow2(M+1);
%bin_num = zeros(N,n);
bin_num = zeros(N,m);

for i=1:m,
 num(:,i) = rem(dec_num,2);
 dec_num  = fix(dec_num./2);
end; 

bin_num = fliplr(num);
