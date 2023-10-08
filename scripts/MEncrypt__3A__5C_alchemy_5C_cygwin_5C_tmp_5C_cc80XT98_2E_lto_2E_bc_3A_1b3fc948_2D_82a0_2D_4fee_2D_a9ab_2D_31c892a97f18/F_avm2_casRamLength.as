package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.*;
   import avm2.intrinsics.memory.*;
   
   public function F_avm2_casRamLength() : void
   {
      var _loc3_:* = 0;
      var _loc4_:* = 0;
      var _loc5_:* = 0;
      var _loc1_:* = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_avm2_haveWorkers_2E_4273);
      if(_loc1_ == -1)
      {
         _loc1_ = int(Boolean(workerClass));
         si32(_loc1_,_avm2_haveWorkers_2E_4273);
      }
      _loc5_ = li32(_loc3_ + 4);
      _loc4_ = li32(_loc3_);
      if(_loc1_ != 0)
      {
         try
         {
            _loc4_ = int(ram.atomicCompareAndSwapLength(_loc4_,_loc5_));
         }
         catch(e:*)
         {
            if(throwWhenOutOfMemory)
            {
               throw e;
            }
            _loc4_ = -1;
         }
      }
      else
      {
         _loc4_ = ram.length;
         if(_loc4_ == _loc4_)
         {
            try
            {
               ram.length = _loc5_;
            }
            catch(e:*)
            {
               if(throwWhenOutOfMemory)
               {
                  throw e;
               }
               _loc4_ = -1;
            }
         }
      }
      eax = _loc4_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
