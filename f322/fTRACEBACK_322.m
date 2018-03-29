function [Ux_, MLDpath]= fTRACEBACK_322(pathmem,acc,st_hist,Ux_,MLDpath,k,m,M,N,T,stage)
%======================================================================================================
%   function [Ux_, MLDpath]= fTRACEBACK_322(pathmem,acc,st_hist,Ux_,MLDpath,k,m,M,N,T,stage)
%
%   (3,2,2) Forward Label Traceback Function
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
[min_metric,tb_ptr]=fTBDECISION_322(acc);

% Perform Traceback process
if stage <= N+m,
   for stage_ptr = T: -1: (m-1),
      if stage_ptr==T,
         Fx=pathmem(tb_ptr+1,k*(stage_ptr-1)+k+1:k*stage_ptr+k);
         MLDstate=st_hist(tb_ptr+1,stage_ptr+1);
      else
         Fx = pathmem(MLDstate+1,k*(stage_ptr-1)+k+1:k*stage_ptr+k);
         MLDstate=st_hist(MLDstate+1,stage_ptr+1);
      end;
   end;
   if stage==T+1,
      Ux_     = [Fx];
      MLDpath = [MLDstate];
   else
      Ux_     = [Ux_ Fx];
      MLDpath = [MLDpath MLDstate];
   end;
else
   % Find remaining bits
   final_stage = (m-1);
   num_tbacks  = N-m;
   for i=1:num_tbacks,
      for stage_ptr = T: -1: final_stage,
         if stage_ptr==T,
            Fx=pathmem(tb_ptr+1,k*(stage_ptr-1)+k+1:k*stage_ptr+k);
            MLDstate=st_hist(tb_ptr+1,stage_ptr+1);
         else
            Fx = pathmem(MLDstate+1,k*(stage_ptr-1)+k+1:k*stage_ptr+k);
            MLDstate=st_hist(MLDstate+1,stage_ptr+1);
         end;
      end;
      Ux_     = [Ux_ Fx];
      MLDpath = [MLDpath MLDstate];
      final_stage = final_stage+1;
   end;
end;
   




   
