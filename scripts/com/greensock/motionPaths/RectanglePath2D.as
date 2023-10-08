package com.greensock.motionPaths
{
   import flash.display.Graphics;
   import flash.events.Event;
   import flash.geom.Matrix;
   
   public class RectanglePath2D extends MotionPath
   {
       
      
      protected var _centerOrigin:Boolean;
      
      protected var _rawHeight:Number;
      
      protected var _rawWidth:Number;
      
      public function RectanglePath2D(param1:Number, param2:Number, param3:Number, param4:Number, param5:Boolean = false)
      {
         super();
         _rawWidth = param3;
         _rawHeight = param4;
         _centerOrigin = param5;
         super.x = param1;
         super.y = param2;
      }
      
      public function set rawHeight(param1:Number) : void
      {
         _rawHeight = param1;
         _redrawLine = true;
         update();
      }
      
      override public function renderObjectAt(param1:Object, param2:Number, param3:Boolean = false, param4:Number = 0) : void
      {
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         if(param2 > 1)
         {
            param2 -= int(param2);
         }
         else if(param2 < 0)
         {
            param2 -= int(param2) - 1;
         }
         var _loc5_:Number = _centerOrigin ? _rawWidth / -2 : 0;
         var _loc6_:Number = _centerOrigin ? _rawHeight / -2 : 0;
         if(param2 < 0.5)
         {
            if((_loc7_ = param2 * (_rawWidth + _rawHeight) * 2) > _rawWidth)
            {
               _loc5_ += _rawWidth;
               _loc6_ += _loc7_ - _rawWidth;
               _loc8_ = 0;
               _loc9_ = _rawHeight;
            }
            else
            {
               _loc5_ += _loc7_;
               _loc8_ = _rawWidth;
               _loc9_ = 0;
            }
         }
         else if((_loc7_ = (param2 - 0.5) / 0.5 * (_rawWidth + _rawHeight)) <= _rawWidth)
         {
            _loc5_ += _rawWidth - _loc7_;
            _loc6_ += _rawHeight;
            _loc8_ = -_rawWidth;
            _loc9_ = 0;
         }
         else
         {
            _loc6_ += _rawHeight - (_loc7_ - _rawWidth);
            _loc8_ = 0;
            _loc9_ = -_rawHeight;
         }
         var _loc10_:Matrix = this.transform.matrix;
         param1.x = _loc5_ * _loc10_.a + _loc6_ * _loc10_.c + _loc10_.tx;
         param1.y = _loc5_ * _loc10_.b + _loc6_ * _loc10_.d + _loc10_.ty;
         if(param3)
         {
            param1.rotation = Math.atan2(_loc8_ * _loc10_.b + _loc9_ * _loc10_.d,_loc8_ * _loc10_.a + _loc9_ * _loc10_.c) * _RAD2DEG + param4;
         }
      }
      
      override public function update(param1:Event = null) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc17_:Graphics = null;
         var _loc2_:Number = _centerOrigin ? _rawWidth / -2 : 0;
         var _loc3_:Number = _centerOrigin ? _rawHeight / -2 : 0;
         var _loc9_:Matrix;
         var _loc10_:Number = (_loc9_ = this.transform.matrix).a;
         var _loc11_:Number = _loc9_.b;
         var _loc12_:Number = _loc9_.c;
         var _loc13_:Number = _loc9_.d;
         var _loc14_:Number = _loc9_.tx;
         var _loc15_:Number = _loc9_.ty;
         var _loc16_:PathFollower = _rootFollower;
         while(_loc16_)
         {
            _loc5_ = _loc2_;
            _loc6_ = _loc3_;
            if(_loc16_.cachedProgress < 0.5)
            {
               if((_loc4_ = _loc16_.cachedProgress * (_rawWidth + _rawHeight) * 2) > _rawWidth)
               {
                  _loc5_ += _rawWidth;
                  _loc6_ += _loc4_ - _rawWidth;
                  _loc7_ = 0;
                  _loc8_ = _rawHeight;
               }
               else
               {
                  _loc5_ += _loc4_;
                  _loc7_ = _rawWidth;
                  _loc8_ = 0;
               }
            }
            else if((_loc4_ = (_loc16_.cachedProgress - 0.5) / 0.5 * (_rawWidth + _rawHeight)) <= _rawWidth)
            {
               _loc5_ += _rawWidth - _loc4_;
               _loc6_ += _rawHeight;
               _loc7_ = -_rawWidth;
               _loc8_ = 0;
            }
            else
            {
               _loc6_ += _rawHeight - (_loc4_ - _rawWidth);
               _loc7_ = 0;
               _loc8_ = -_rawHeight;
            }
            _loc16_.target.x = _loc5_ * _loc10_ + _loc6_ * _loc12_ + _loc14_;
            _loc16_.target.y = _loc5_ * _loc11_ + _loc6_ * _loc13_ + _loc15_;
            if(_loc16_.autoRotate)
            {
               _loc16_.target.rotation = Math.atan2(_loc7_ * _loc11_ + _loc8_ * _loc13_,_loc7_ * _loc10_ + _loc8_ * _loc12_) * _RAD2DEG + _loc16_.rotationOffset;
            }
            _loc16_ = _loc16_.cachedNext;
         }
         if(_redrawLine)
         {
            (_loc17_ = this.graphics).clear();
            _loc17_.lineStyle(_thickness,_color,_lineAlpha,_pixelHinting,_scaleMode,_caps,_joints,_miterLimit);
            _loc17_.drawRect(_loc2_,_loc3_,_rawWidth,_rawHeight);
            _redrawLine = false;
         }
      }
      
      public function get rawHeight() : Number
      {
         return _rawHeight;
      }
      
      public function set centerOrigin(param1:Boolean) : void
      {
         _centerOrigin;
         _redrawLine = true;
         update();
      }
      
      public function get centerOrigin() : Boolean
      {
         return _centerOrigin;
      }
      
      public function set rawWidth(param1:Number) : void
      {
         _rawWidth = param1;
         _redrawLine = true;
         update();
      }
      
      public function get rawWidth() : Number
      {
         return _rawWidth;
      }
   }
}
