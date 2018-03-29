function [D]= eTRACEBACK_322(P,A,m,M,k,D,N,T,x)
%======================================================
%   function [D]= eTRACEBACK_322(P,A,m, M,k,D,N,T,x)
%
%   Efficient(3,2,2) Backward Label Traceback Function
%
%	  Returns D, The Decoded Message up to stage x
%
%   John O'Shea, jfoshea@gmail.com
%======================================================

if nargin==0, 
   error('Not enough input arguments.');
end;

% Find Traceback start state
[min_metric,tb_ptr]=eTBDECISION_322(A);

% Perform Traceback process
if x <= N+M,
   for stage_ptr = T: -1: (M-1),
      if stage_ptr == T,
         Bx   =P(tb_ptr+1,k*((stage_ptr-1)-1)+1:k*(stage_ptr-1));
         Sx   =D2B(tb_ptr,M);
      else
         Sx_1 = B2D(Sx_1);
         Bx   = P(Sx_1+1, k*((stage_ptr-1)-1)+1:k*(stage_ptr-1));
         Sx   = D2B(Sx_1,M);
      end;
      % (3,2,2) Traceback Mapping
      Sx_1=[Bx(1,1) Sx(1,1) Bx(1,k)];
   end;
   Dx =[Sx_1(1,M-1) Sx_1(1,M)];
   Dx = fliplr(Dx);
   D =[Dx D];
else
   % At stage x=N, there are no more partial path metrics 
   % to be added, decode the remaining ML path symbols, Dx, 
   % that reside in path memory
   %i=N+m-length(D);
   %while i>0,
      for stage_ptr = T: -1 : (M-1),
         if stage_ptr == T,
            Bx  =P(tb_ptr+1,k*((stage_ptr-1)-1)+1:k*(stage_ptr-1));
            Sx  =D2B(tb_ptr,M);
         else
            Sx_1 =B2D(Sx_1);
            Bx   =P(Sx_1+1, k*((stage_ptr-1)-1)+1:k*(stage_ptr-1));
            Sx   =D2B(Sx_1,M);
         end;
         % (3,2,2) Traceback Mapping
         Sx_1=[Bx(1,1) Sx(1,1) Bx(1,k)];
      end;
      Dx =[Sx_1(1,M-1) Sx_1(1,M)];
      Dx = fliplr(Dx);
      D =[Dx D];
end;
   




   
