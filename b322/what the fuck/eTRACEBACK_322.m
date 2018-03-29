function [Ux_, MLDpath]= eTRACEBACK_322(pathmem,acc,Ux_,MLDpath,k,m,M,N,T,stage)
%======================================================================================================
%   function [Ux_, MLDpath]= eTRACEBACK_322(pathmem,acc,Ux_,MLDpath,k,m,M,N,T,stage)
%
%   (3,2,2) Backward Label Traceback Function
%
%	 Ux_     = Decoded Message
%   MLDpath = Surviving Trellis Path
%
%   John O'Shea, jfoshea@gmail.com
%   Copyright (c) 1999 John O'Shea.
%   Revision: 1.0 Date: 26th July 1999
%======================================================================================================

if nargin==0, 
   error('Not enough input arguments.');
end;

% Find Traceback start state
[min_metric,tb_ptr]=eTBDECISION_322(acc);

% Perform Traceback process
if stage <= N+m,
   for stage_ptr = T-m: -1: (m-1),
      if stage_ptr == T-m,
         Bx=pathmem(tb_ptr+1,k*(stage_ptr-1)+k+1:k*stage_ptr+k);
         Sx=D2B(tb_ptr,M);
      else
         Sx_1 = B2D(Sx_1);
         Bx   = pathmem(Sx_1+1, k*(stage_ptr-1)+k+1:k*stage_ptr+k);
         Sx   = D2B(Sx_1,M);
      end;
      % (3,2,2) Traceback Mapping
      Sx_1=[Bx(1,1) Sx(1,1) Bx(1,k)];
   end;
   if stage==(T+1),
      %Ux_  = [Bx(1,1) 9 9 Bx(1,k)];
      % Determine bit Bx_1 for stage-1 S1,1
      Bx_1 = pathmem(B2D(Sx_1)+1, k*(stage_ptr-1)+k:k*stage_ptr+k-1);
      %Pad out with 9 until next stage is decoded
      Ux_  = [Bx(1,1) Bx_1(1,k) 9 Bx(1,k)];
      MLDpath    =[B2D(Sx)];
   else
      Ux_(1,length(Ux_)-1)=Bx(1,1);
      Ux_=[Ux_ 9 Bx(1,k)];
      MLDpath = [MLDpath B2D(Sx)];
   end;
else
   % If all the Pseudo-Block is processed, traceback remaining bits
   final_stage = (m-1);
   for i=1:T-m,
      for stage_ptr = T-m: -1: final_stage,
         if stage_ptr == T-m,
            Bx = pathmem(tb_ptr+1,k*(stage_ptr-1)+k+1:k*stage_ptr+k);
            Sx = D2B(tb_ptr,M);
         else
            Sx_1 = B2D(Sx_1);
            Bx   = pathmem(Sx_1+1, k*(stage_ptr-1)+k+1:k*stage_ptr+k);
            Sx   = D2B(Sx_1,M);
         end;
         Sx_1 = [Bx(1,1) Sx(1,1) Bx(1,k)];
      end;
      Ux_(1,length(Ux_)-1)=Bx(1,1);
      Ux_=[Ux_ 9 Bx(1,k)];
      %Ux_     = [Ux_ Sx(1,M-1) Sx(1,M)];
      MLDpath = [MLDpath B2D(Sx)];
      final_stage = final_stage+1;
   end;
end;

   




   
