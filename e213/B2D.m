function dec_num = B2D(bin_num)
%=============================================================================
%	function dec_num = B2D(bin_num)
%
%	Binary to Decimal Conversion
%
%   John O'Shea, jfoshea@gmail.com
%
%==============================================================================

[nrows,ncols] = size(bin_num);
if ncols==1,
   bin_num = bin_num';
   [nrows,ncols] = size(bin_num);
end;
dec_num = [];
for j=1:nrows,
   num = 0;
   for i=0:ncols-1,
      num = num + bin_num(j,ncols-i)*2^i;
   end;
   dec_num = [dec_num num];
end;
