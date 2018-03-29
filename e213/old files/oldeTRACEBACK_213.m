function [Ux_, MLDpath]= eTRACEBACK_213(pathmem,acc,Ux_,MLDpath,m,N,T,stage)
%================================================================================
%   function [Ux_, MLDpath]= eTRACEBACK_213(pathmem,acc,Ux_,MLDpath,m,N,T,stage)
%
%   (2,1,3) Efficient Backward Label Traceback Function
%
%   Ux_     = Decoded Message
%   MLDpath = Surviving Trellis Path
%
%   John O'Shea, jfoshea@gmail.com
%   Copyright (c) 1999 John O'Shea, University of Limerick.
%   Revision: 1.0 Date: 26th August 1999
%================================================================================

if nargin==0, 
   error('Not enough input arguments.');
end;

% Find Traceback start state
[min_metric,tb_ptr]=eTBDECISION_213(acc);

% Perform Traceback process
if stage <= N+m,
   for stage_ptr = T+1: -1: (m-1),
      if stage_ptr == T+1,
         Bx=B2D(pathmem((tb_ptr+1),stage_ptr));
         Sx=D2B(tb_ptr,m);
      else
         Sx_1=B2D(Sx_1);
         Bx=B2D(pathmem((Sx_1+1),stage_ptr));
         Sx=D2B(Sx_1,m);
      end;
      Sx_1=[Bx Sx(1,1) Sx(1,2)];
   end;
   if stage-m == T+1,
      %Take Bx and use it as Fx m stages previous
      Ux_ =[Bx];
      MLDpath    =[B2D(Sx)];
   else
      Ux_     = [Ux_ Bx];
      MLDpath = [MLDpath B2D(Sx)];
   end;
else
   % Find remaining bits
   final_stage = (m-1);
   num_tbacks  = N-m;
   for i=1:num_tbacks,
      for stage_ptr = T+1: -1: final_stage,
         if stage_ptr == T+1,
            Bx=pathmem(tb_ptr+1,stage_ptr);
            Sx=D2B(tb_ptr,m);
         else
            Sx_1=B2D(Sx_1);
            Bx = pathmem(Sx_1+1,stage_ptr);
            Sx = D2B(Sx_1,m);
         end;
         Sx_1 = [Bx Sx(1,1) Sx(1,2)];
      end;
      Ux_     = [Ux_ Bx];
      MLDpath = [MLDpath B2D(Sx)];
      final_stage = final_stage+1;
   end;
end;
   




   
