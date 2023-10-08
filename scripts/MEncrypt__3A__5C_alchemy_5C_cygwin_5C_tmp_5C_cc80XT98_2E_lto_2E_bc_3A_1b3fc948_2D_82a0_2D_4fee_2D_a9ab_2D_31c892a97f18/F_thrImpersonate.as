package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.*;
   import avm2.intrinsics.memory.*;
   
   public function F_thrImpersonate() : void
   {
      var _loc6_:* = 0;
      var _loc1_:* = 0;
      var _loc11_:* = 0;
      var _loc9_:* = 0;
      var _loc8_:* = 0;
      var _loc7_:* = 0;
      var _loc2_:* = ESP;
      _loc1_ = li32(_loc6_ = _loc2_);
      _loc11_ = li32(_loc6_ + 4);
      _loc9_ = li32(_loc6_ + 8);
      _loc8_ = li32(_loc6_ + 12);
      _loc7_ = li32(_loc6_ + 16);
      var _loc5_:int = int(threadId);
      var _loc10_:int = tcbp;
      var _loc4_:int = _avm2_self_unlock;
      var _loc3_:* = _loc7_;
      try
      {
         threadId = _loc1_;
         tcbp = _loc11_;
         if(_loc3_)
         {
            CModule.write32(_loc3_,1);
         }
         CModule.callI(_avm2_self_lock,new Vector.<int>(0));
         _loc1_ = CModule.callI(_loc9_,new <int>[_loc8_]);
         if(_loc3_)
         {
            CModule.write32(_loc3_,0);
         }
      }
      catch(e:*)
      {
         if(!_loc3_)
         {
            throw e;
         }
      }
      finally
      {
         try
         {
            CModule.callI(_loc4_,new Vector.<int>(0));
         }
         catch(e:*)
         {
         }
         threadId = _loc5_;
         tcbp = _loc10_;
      }
      eax = _loc1_;
      _loc2_ = _loc6_;
      ESP = _loc2_;
   }
}
