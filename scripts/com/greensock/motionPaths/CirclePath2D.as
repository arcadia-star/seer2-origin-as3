package com.greensock.motionPaths
{
   import flash.display.Graphics;
   import flash.events.Event;
   import flash.geom.Matrix;
   
   public class CirclePath2D extends MotionPath
   {
       
      
      protected var _radius:Number;
      
      public function CirclePath2D(param1:Number, param2:Number, param3:Number)
      {
         super();
         _radius = param3;
         super.x = param1;
         super.y = param2;
      }
      
      public function get radius() : Number
      {
         return _radius;
      }
      
      override public function renderObjectAt(param1:Object, param2:Number, param3:Boolean = false, param4:Number = 0) : void
      {
         var _loc5_:Number = param2 * Math.PI * 2;
         var _loc6_:Matrix = this.transform.matrix;
         var _loc7_:Number = Math.cos(_loc5_) * _radius;
         var _loc8_:Number = Math.sin(_loc5_) * _radius;
         param1.x = _loc7_ * _loc6_.a + _loc8_ * _loc6_.c + _loc6_.tx;
         param1.y = _loc7_ * _loc6_.b + _loc8_ * _loc6_.d + _loc6_.ty;
         if(param3)
         {
            _loc5_ += Math.PI / 2;
            _loc7_ = Math.cos(_loc5_) * _radius;
            _loc8_ = Math.sin(_loc5_) * _radius;
            param1.rotation = Math.atan2(_loc7_ * _loc6_.b + _loc8_ * _loc6_.d,_loc7_ * _loc6_.a + _loc8_ * _loc6_.c) * _RAD2DEG + param4;
         }
      }
      
      override public function update(param1:Event = null) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc13_:Graphics = null;
         var _loc5_:Matrix;
         var _loc6_:Number = (_loc5_ = this.transform.matrix).a;
         var _loc7_:Number = _loc5_.b;
         var _loc8_:Number = _loc5_.c;
         var _loc9_:Number = _loc5_.d;
         var _loc10_:Number = _loc5_.tx;
         var _loc11_:Number = _loc5_.ty;
         var _loc12_:PathFollower = _rootFollower;
         while(_loc12_)
         {
            _loc2_ = _loc12_.cachedProgress * Math.PI * 2;
            _loc3_ = Math.cos(_loc2_) * _radius;
            _loc4_ = Math.sin(_loc2_) * _radius;
            _loc12_.target.x = _loc3_ * _loc6_ + _loc4_ * _loc8_ + _loc10_;
            _loc12_.target.y = _loc3_ * _loc7_ + _loc4_ * _loc9_ + _loc11_;
            if(_loc12_.autoRotate)
            {
               _loc2_ += Math.PI / 2;
               _loc3_ = Math.cos(_loc2_) * _radius;
               _loc4_ = Math.sin(_loc2_) * _radius;
               _loc12_.target.rotation = Math.atan2(_loc3_ * _loc5_.b + _loc4_ * _loc5_.d,_loc3_ * _loc5_.a + _loc4_ * _loc5_.c) * _RAD2DEG + _loc12_.rotationOffset;
            }
            _loc12_ = _loc12_.cachedNext;
         }
         if(_redrawLine)
         {
            (_loc13_ = this.graphics).clear();
            _loc13_.lineStyle(_thickness,_color,_lineAlpha,_pixelHinting,_scaleMode,_caps,_joints,_miterLimit);
            _loc13_.drawCircle(0,0,_radius);
            _redrawLine = false;
         }
      }
      
      public function progressToAngle(param1:Number, param2:Boolean = false) : Number
      {
         var _loc3_:Number = param2 ? Math.PI * 2 : 360;
         return param1 * _loc3_;
      }
      
      public function angleToProgress(param1:Number, param2:Boolean = false) : Number
      {
         var _loc3_:Number = param2 ? Math.PI * 2 : 360;
         if(param1 < 0)
         {
            param1 += (int(-param1 / _loc3_) + 1) * _loc3_;
         }
         else if(param1 > _loc3_)
         {
            param1 -= int(param1 / _loc3_) * _loc3_;
         }
         return param1 / _loc3_;
      }
      
      public function set radius(param1:Number) : void
      {
         _radius = param1;
         _redrawLine = true;
         update();
      }
      
      public function followerTween(param1:*, param2:Number, param3:String = "clockwise", param4:uint = 0, param5:Boolean = false) : String
      {
         var _loc6_:Number = param5 ? Math.PI * 2 : 360;
         return String(anglesToProgressChange(getFollower(param1).progress * _loc6_,param2,param3,param4,param5));
      }
      
      public function anglesToProgressChange(param1:Number, param2:Number, param3:String = "clockwise", param4:uint = 0, param5:Boolean = false) : Number
      {
         var _loc6_:Number = param5 ? Math.PI * 2 : 360;
         var _loc7_:Number;
         if((_loc7_ = param2 - param1) < 0 && param3 == "clockwise")
         {
            _loc7_ += (int(-_loc7_ / _loc6_) + 1) * _loc6_;
         }
         else if(_loc7_ > 0 && param3 == "counterClockwise")
         {
            _loc7_ -= (int(_loc7_ / _loc6_) + 1) * _loc6_;
         }
         else if(param3 == "shortest")
         {
            _loc7_ %= _loc6_;
            if(_loc7_ != _loc7_ % (_loc6_ * 0.5))
            {
               _loc7_ = _loc7_ < 0 ? _loc7_ + _loc6_ : _loc7_ - _loc6_;
            }
         }
         if(_loc7_ < 0)
         {
            _loc7_ -= param4 * _loc6_;
         }
         else
         {
            _loc7_ += param4 * _loc6_;
         }
         return _loc7_ / _loc6_;
      }
   }
}
