package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.*;
   import avm2.intrinsics.memory.*;
   import flash.display.Sprite;
   
   public function F_uiThreadESPInit() : void
   {
      var _loc3_:* = 0;
      var _loc4_:* = 0;
      var _loc1_:int = 0;
      var _loc5_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = 0;
      try
      {
         if(Sprite)
         {
            _loc1_ = int(workerClass.current.getSharedProperty("flascc.uiThread.esp_init"));
            _loc5_ = int(workerClass.current.getSharedProperty("flascc.uiThread.stackSize"));
         }
      }
      catch(e:*)
      {
      }
      if((_loc4_ = li32(_loc3_)) != 0)
      {
         si32(_loc5_,_loc4_);
      }
      eax = _loc1_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
