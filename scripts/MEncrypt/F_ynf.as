package MEncrypt
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   
   public function F_ynf() : void
   {
      var _loc6_:int = 0;
      var _loc1_:* = NaN;
      var _loc5_:* = 0;
      var _loc16_:* = 0;
      var _loc13_:int = 0;
      var _loc8_:int = 0;
      var _loc11_:int = 0;
      var _loc10_:* = NaN;
      var _loc15_:* = NaN;
      var _loc3_:* = NaN;
      var _loc4_:* = (_loc6_ = ESP) - 16;
      _loc1_ = lf32(_loc6_ + 4);
      sf32(_loc1_,_loc6_ - 4);
      if((uint(_loc16_ = (_loc5_ = li32(_loc6_ - 4)) & 2147483647)) >= 2139095041)
      {
         var _loc9_:* = _loc1_;
         _loc3_ = _loc9_ += _loc9_;
      }
      else
      {
         _loc3_ = -inf;
         if(_loc16_ != 0)
         {
            _loc3_ = nan;
            if(_loc5_ >= 0)
            {
               _loc5_ = li32(_loc6_);
               _loc13_ = 1;
               if(_loc5_ <= -1)
               {
                  var _loc12_:*;
                  _loc13_ = 1 - ((_loc12_ = (_loc5_ = 0 - _loc5_) << 1) & 2);
               }
               if(_loc5_ != 1)
               {
                  if(_loc5_ == 0)
                  {
                     _loc4_ -= 16;
                     sf32(_loc1_,_loc4_);
                     ESP = _loc4_;
                     F_y0f();
                     _loc4_ += 16;
                     _loc3_ = st0;
                  }
                  else
                  {
                     _loc3_ = 0;
                     if(_loc16_ != 2139095040)
                     {
                        _loc4_ -= 16;
                        sf32(_loc1_,_loc4_);
                        ESP = _loc4_;
                        F_y0f();
                        _loc4_ += 16;
                        _loc15_ = st0;
                        _loc4_ -= 16;
                        sf32(_loc1_,_loc4_);
                        ESP = _loc4_;
                        F_y1f();
                        _loc11_ = 1;
                        _loc8_ = 2;
                        _loc4_ += 16;
                        _loc10_ = st0;
                        while(true)
                        {
                           _loc3_ = _loc10_;
                           if(_loc11_ >= _loc5_)
                           {
                              break;
                           }
                           sf32(_loc3_,_loc6_ - 8);
                           if((_loc12_ = li32(_loc6_ - 8)) == -8388608)
                           {
                              break;
                           }
                           var _loc7_:*;
                           var _loc14_:Number;
                           _loc10_ = _loc9_ = (_loc9_ = (_loc9_ = (_loc7_ = _loc14_ = _loc8_) / _loc1_) * _loc3_) - _loc15_;
                           _loc8_ += 2;
                           _loc11_ += 1;
                           _loc15_ = _loc3_;
                        }
                        if(_loc13_ <= 0)
                        {
                           _loc3_ = _loc9_ = -(_loc9_ = _loc3_);
                        }
                     }
                  }
               }
               else
               {
                  _loc4_ -= 16;
                  sf32(_loc1_,_loc4_);
                  ESP = _loc4_;
                  F_y1f();
                  _loc4_ += 16;
                  _loc3_ = _loc9_ = _loc13_ * (_loc14_ = st0);
               }
            }
         }
      }
      st0 = _loc3_;
      ESP = _loc4_ = _loc6_;
   }
}
