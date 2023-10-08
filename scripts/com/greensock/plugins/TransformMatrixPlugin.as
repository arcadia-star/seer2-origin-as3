package com.greensock.plugins
{
   import com.greensock.*;
   import flash.geom.Matrix;
   import flash.geom.Transform;
   
   public class TransformMatrixPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1;
      
      private static const _DEG2RAD:Number = Math.PI / 180;
       
      
      protected var _dChange:Number;
      
      protected var _txStart:Number;
      
      protected var _cStart:Number;
      
      protected var _matrix:Matrix;
      
      protected var _tyStart:Number;
      
      protected var _aStart:Number;
      
      protected var _angleChange:Number = 0;
      
      protected var _transform:Transform;
      
      protected var _aChange:Number;
      
      protected var _bChange:Number;
      
      protected var _tyChange:Number;
      
      protected var _txChange:Number;
      
      protected var _cChange:Number;
      
      protected var _dStart:Number;
      
      protected var _bStart:Number;
      
      public function TransformMatrixPlugin()
      {
         super();
         this.propName = "transformMatrix";
         this.overwriteProps = ["x","y","scaleX","scaleY","rotation","transformMatrix","transformAroundPoint","transformAroundCenter","shortRotation"];
      }
      
      override public function set changeFactor(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         _matrix.a = _aStart + param1 * _aChange;
         _matrix.b = _bStart + param1 * _bChange;
         _matrix.c = _cStart + param1 * _cChange;
         _matrix.d = _dStart + param1 * _dChange;
         if(_angleChange)
         {
            _loc2_ = Math.cos(_angleChange * param1);
            _loc3_ = Math.sin(_angleChange * param1);
            _loc4_ = _matrix.a;
            _loc5_ = _matrix.c;
            _matrix.a = _loc4_ * _loc2_ - _matrix.b * _loc3_;
            _matrix.b = _loc4_ * _loc3_ + _matrix.b * _loc2_;
            _matrix.c = _loc5_ * _loc2_ - _matrix.d * _loc3_;
            _matrix.d = _loc5_ * _loc3_ + _matrix.d * _loc2_;
         }
         _matrix.tx = _txStart + param1 * _txChange;
         _matrix.ty = _tyStart + param1 * _tyChange;
         _transform.matrix = _matrix;
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         _transform = param1.transform as Transform;
         _matrix = _transform.matrix;
         var _loc4_:Matrix = _matrix.clone();
         _txStart = _loc4_.tx;
         _tyStart = _loc4_.ty;
         _aStart = _loc4_.a;
         _bStart = _loc4_.b;
         _cStart = _loc4_.c;
         _dStart = _loc4_.d;
         if("x" in param2)
         {
            _txChange = typeof param2.x == "number" ? param2.x - _txStart : Number(param2.x);
         }
         else if("tx" in param2)
         {
            _txChange = param2.tx - _txStart;
         }
         else
         {
            _txChange = 0;
         }
         if("y" in param2)
         {
            _tyChange = typeof param2.y == "number" ? param2.y - _tyStart : Number(param2.y);
         }
         else if("ty" in param2)
         {
            _tyChange = param2.ty - _tyStart;
         }
         else
         {
            _tyChange = 0;
         }
         _aChange = "a" in param2 ? param2.a - _aStart : 0;
         _bChange = "b" in param2 ? param2.b - _bStart : 0;
         _cChange = "c" in param2 ? param2.c - _cStart : 0;
         _dChange = "d" in param2 ? param2.d - _dStart : 0;
         if("rotation" in param2 || "shortRotation" in param2 || "scale" in param2 && !(param2 is Matrix) || "scaleX" in param2 || "scaleY" in param2 || "skewX" in param2 || "skewY" in param2 || "skewX2" in param2 || "skewY2" in param2)
         {
            _loc7_ = Math.sqrt(_loc4_.a * _loc4_.a + _loc4_.b * _loc4_.b);
            if(_loc4_.a < 0 && _loc4_.d > 0)
            {
               _loc7_ = -_loc7_;
            }
            _loc8_ = Math.sqrt(_loc4_.c * _loc4_.c + _loc4_.d * _loc4_.d);
            if(_loc4_.d < 0 && _loc4_.a > 0)
            {
               _loc8_ = -_loc8_;
            }
            _loc9_ = Math.atan2(_loc4_.b,_loc4_.a);
            if(_loc4_.a < 0 && _loc4_.d >= 0)
            {
               _loc9_ += _loc9_ <= 0 ? Math.PI : -Math.PI;
            }
            _loc10_ = Math.atan2(-_matrix.c,_matrix.d) - _loc9_;
            _loc11_ = _loc9_;
            if("shortRotation" in param2)
            {
               if((_loc13_ = (param2.shortRotation * _DEG2RAD - _loc9_) % (Math.PI * 2)) > Math.PI)
               {
                  _loc13_ -= Math.PI * 2;
               }
               else if(_loc13_ < -Math.PI)
               {
                  _loc13_ += Math.PI * 2;
               }
               _loc11_ += _loc13_;
            }
            else if("rotation" in param2)
            {
               _loc11_ = typeof param2.rotation == "number" ? param2.rotation * _DEG2RAD : Number(param2.rotation) * _DEG2RAD + _loc9_;
            }
            _loc12_ = "skewX" in param2 ? (typeof param2.skewX == "number" ? Number(param2.skewX) * _DEG2RAD : Number(param2.skewX) * _DEG2RAD + _loc10_) : 0;
            if("skewY" in param2)
            {
               _loc14_ = typeof param2.skewY == "number" ? param2.skewY * _DEG2RAD : Number(param2.skewY) * _DEG2RAD - _loc10_;
               _loc11_ += _loc14_ + _loc10_;
               _loc12_ -= _loc14_;
            }
            if(_loc11_ != _loc9_)
            {
               if("rotation" in param2 || "shortRotation" in param2)
               {
                  _angleChange = _loc11_ - _loc9_;
                  _loc11_ = _loc9_;
               }
               else
               {
                  _loc4_.rotate(_loc11_ - _loc9_);
               }
            }
            if("scale" in param2)
            {
               _loc5_ = Number(param2.scale) / _loc7_;
               _loc6_ = Number(param2.scale) / _loc8_;
               if(typeof param2.scale != "number")
               {
                  _loc5_ += 1;
                  _loc6_ += 1;
               }
            }
            else
            {
               if("scaleX" in param2)
               {
                  _loc5_ = Number(param2.scaleX) / _loc7_;
                  if(typeof param2.scaleX != "number")
                  {
                     _loc5_ += 1;
                  }
               }
               if("scaleY" in param2)
               {
                  _loc6_ = Number(param2.scaleY) / _loc8_;
                  if(typeof param2.scaleY != "number")
                  {
                     _loc6_ += 1;
                  }
               }
            }
            if(_loc12_ != _loc10_)
            {
               _loc4_.c = -_loc8_ * Math.sin(_loc12_ + _loc11_);
               _loc4_.d = _loc8_ * Math.cos(_loc12_ + _loc11_);
            }
            if("skewX2" in param2)
            {
               if(typeof param2.skewX2 == "number")
               {
                  _loc4_.c = Math.tan(0 - param2.skewX2 * _DEG2RAD);
               }
               else
               {
                  _loc4_.c += Math.tan(0 - Number(param2.skewX2) * _DEG2RAD);
               }
            }
            if("skewY2" in param2)
            {
               if(typeof param2.skewY2 == "number")
               {
                  _loc4_.b = Math.tan(param2.skewY2 * _DEG2RAD);
               }
               else
               {
                  _loc4_.b += Math.tan(Number(param2.skewY2) * _DEG2RAD);
               }
            }
            if(Boolean(_loc5_) || _loc5_ == 0)
            {
               _loc4_.a *= _loc5_;
               _loc4_.b *= _loc5_;
            }
            if(Boolean(_loc6_) || _loc6_ == 0)
            {
               _loc4_.c *= _loc6_;
               _loc4_.d *= _loc6_;
            }
            _aChange = _loc4_.a - _aStart;
            _bChange = _loc4_.b - _bStart;
            _cChange = _loc4_.c - _cStart;
            _dChange = _loc4_.d - _dStart;
         }
         return true;
      }
   }
}
