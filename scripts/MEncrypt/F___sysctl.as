package MEncrypt
{
   import MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18.*;
   import avm2.intrinsics.memory.*;
   
   public function F___sysctl() : void
   {
      var _loc3_:* = 0;
      var _loc8_:* = 0;
      var _loc1_:* = 0;
      var _loc7_:* = 0;
      var _loc6_:* = 0;
      var _loc5_:int = 0;
      var _loc2_:* = ESP;
      _loc3_ = _loc2_;
      _loc1_ = li32(_loc3_);
      _loc8_ = li32(_loc1_);
      _loc7_ = li32(_loc3_ + 12);
      _loc6_ = li32(_loc3_ + 8);
      if(_loc8_ != 6)
      {
         _loc5_ = -1;
         if(_loc8_ == 1)
         {
            _loc1_ = li32(_loc1_ + 4);
            _loc5_ = -1;
            if(_loc1_ <= 9)
            {
               if(_loc1_ != 1)
               {
                  if(_loc1_ != 2)
                  {
                     if(_loc1_ == 4)
                     {
                        si32(20,_loc7_);
                        var _loc4_:*;
                        si8(_loc4_ = li8(___avm2_version),_loc6_);
                        _loc5_ = 0;
                        if(_loc4_ != 0)
                        {
                           _loc7_ = ___avm2_version + 1;
                           _loc6_ += 1;
                           while(true)
                           {
                              si8(_loc4_ = li8(_loc7_),_loc6_);
                              _loc7_ += 1;
                              _loc6_ += 1;
                              _loc5_ = 0;
                              if(_loc4_ != 0)
                              {
                                 continue;
                              }
                           }
                        }
                     }
                  }
                  else
                  {
                     si32(12,_loc7_);
                     si8(_loc4_ = li8(___avm2_osrelease),_loc6_);
                     _loc5_ = 0;
                     if(_loc4_ != 0)
                     {
                        _loc7_ = ___avm2_osrelease + 1;
                        _loc6_ += 1;
                        while(true)
                        {
                           si8(_loc4_ = li8(_loc7_),_loc6_);
                           _loc7_ += 1;
                           _loc6_ += 1;
                           _loc5_ = 0;
                           if(_loc4_ != 0)
                           {
                              continue;
                           }
                        }
                     }
                  }
               }
               else
               {
                  si32(8,_loc7_);
                  si8(_loc4_ = li8(___avm2_ostype),_loc6_);
                  _loc5_ = 0;
                  if(_loc4_ != 0)
                  {
                     _loc7_ = ___avm2_ostype + 1;
                     _loc6_ += 1;
                     while(true)
                     {
                        si8(_loc4_ = li8(_loc7_),_loc6_);
                        _loc7_ += 1;
                        _loc6_ += 1;
                        _loc5_ = 0;
                        if(_loc4_ != 0)
                        {
                           continue;
                        }
                     }
                  }
               }
            }
            else if(_loc1_ != 10)
            {
               if(_loc1_ != 24)
               {
                  if(_loc1_ == 33)
                  {
                     si32(4,_loc7_);
                     si32(_loc4_ = int(ESP_init),_loc6_);
                     _loc5_ = 0;
                  }
               }
               else
               {
                  si32(4,_loc7_);
                  si32(800028,_loc6_);
                  _loc5_ = 0;
               }
            }
            else
            {
               si32(19,_loc7_);
               si8(_loc4_ = li8(___avm2_hostname),_loc6_);
               _loc5_ = 0;
               if(_loc4_ != 0)
               {
                  _loc7_ = ___avm2_hostname + 1;
                  _loc6_ += 1;
                  while(true)
                  {
                     si8(_loc4_ = li8(_loc7_),_loc6_);
                     _loc7_ += 1;
                     _loc6_ += 1;
                     _loc5_ = 0;
                     if(_loc4_ != 0)
                     {
                        continue;
                     }
                  }
               }
            }
         }
      }
      else
      {
         _loc1_ = li32(_loc1_ + 4);
         if(_loc1_ != 7)
         {
            if(_loc1_ != 3)
            {
               _loc5_ = -1;
               if(_loc1_ == 1)
               {
                  si32(5,_loc7_);
                  si8(_loc4_ = li8(___avm2_machine),_loc6_);
                  _loc5_ = 0;
                  if(_loc4_ != 0)
                  {
                     _loc7_ = ___avm2_machine + 1;
                     _loc6_ += 1;
                     do
                     {
                        si8(_loc4_ = li8(_loc7_),_loc6_);
                        _loc7_ += 1;
                        _loc6_ += 1;
                        _loc5_ = 0;
                     }
                     while(_loc4_ != 0);
                     
                  }
               }
            }
            else
            {
               si32(4,_loc7_);
               si32(8,_loc6_);
               _loc5_ = 0;
            }
         }
         else
         {
            si32(4,_loc7_);
            si32(_loc4_ = int(pageSize),_loc6_);
            _loc5_ = 0;
         }
      }
      eax = _loc5_;
      _loc2_ = _loc3_;
      ESP = _loc2_;
   }
}
