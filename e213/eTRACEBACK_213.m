function [D]= eTRACEBACK_213(P,A,m,D,N,T,x)
%===========================================================
%   function [D]= eTRACEBACK_213(P,A,m,D,N,T,x)
%
%   (2,1,3) Efficient Backward Label Traceback Function
%
%	 Returns D, The Decoded Message up to stage x
%
%   John O'Shea, jfoshea@gmail.com
%===========================================================

if nargin==0, 
   error('Not enough input arguments.');
end;
% Find Traceback start state
[min_metric,tb_ptr]=eTBDECISION_213(A);
% Perform Traceback process

if x<=N+m,
   for stage_ptr = T : -1: m+1,
      if stage_ptr == T,
         Bx=B2D(P((tb_ptr+1),stage_ptr-m));
         Sx=D2B(tb_ptr,m);
      else
         Sx_1=B2D(Sx_1);
         Bx=B2D(P((Sx_1+1),stage_ptr-m));
         Sx=D2B(Sx_1,m);
      end;
      Sx_1=[Bx Sx(1,1) Sx(1,2)];
   end;
   % Find Decoded Symbol, Dx
   Dx    =[Sx_1(1,1)];
   % Add Decoded Symbol to Maximum Likelihood path, D
   D     =[Dx D];

else
   % At stage x=N, there are no more partial path metrics 
   % to be added, decode the remaining ML path symbols, Dx, 
   % that reside in path memory
   %i=N+m-length(D);
   %while i>0,
      for stage_ptr = T: -1 : m+1,
         if stage_ptr == T,
            Bx=B2D(P((tb_ptr+1),stage_ptr-m));
            Sx=D2B(tb_ptr,m);
         else
            Sx_1=B2D(Sx_1);
            Bx=B2D(P((Sx_1+1),stage_ptr-m));
            Sx=D2B(Sx_1,m);
         end;
         Sx_1=[Bx Sx(1,1) Sx(1,2)];
      end;
      % Find Decoded Symbol, Dx
      Dx    =[Sx_1(1,1)];
      % Add Decoded Symbol to Maximum Likelihood path, D
      D     =[Dx D];
   end;

%   if stage-m == T+1,
%      %Take Bx and use it as Fx m stages previous
%      Ux_ =[Bx];
%      MLDpath    =[B2D(Sx)];
%   else
%      Ux_     = [Ux_ Bx];
%      MLDpath = [MLDpath B2D(Sx)];
%   end;
   
   
   
   




   
