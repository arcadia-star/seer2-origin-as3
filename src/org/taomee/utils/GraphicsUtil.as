package org.taomee.utils
{
   import flash.display.Graphics;
   
   public class GraphicsUtil
   {
       
      
      public function GraphicsUtil()
      {
         super();
      }
      
      public static function drawWedge(param1:Graphics, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number = NaN) : void
      {
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:int = 0;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         param1.moveTo(param2,param3);
         if(isNaN(param7))
         {
            param7 = param6;
         }
         if(Math.abs(param5) > 360)
         {
            param5 = 360;
         }
         var _loc8_:int = Math.ceil(Math.abs(param5) / 45);
         var _loc9_:Number;
         var _loc10_:Number = -((_loc9_ = param5 / _loc8_) / 180) * Math.PI;
         var _loc11_:Number = -(param4 / 180) * Math.PI;
         if(_loc8_ > 0)
         {
            _loc12_ = param2 + Math.cos(param4 / 180 * Math.PI) * param6;
            _loc13_ = param3 + Math.sin(-param4 / 180 * Math.PI) * param7;
            param1.lineTo(_loc12_,_loc13_);
            _loc14_ = 0;
            while(_loc14_ < _loc8_)
            {
               _loc15_ = (_loc11_ += _loc10_) - _loc10_ / 2;
               _loc16_ = param2 + Math.cos(_loc11_) * param6;
               _loc17_ = param3 + Math.sin(_loc11_) * param7;
               _loc18_ = param2 + Math.cos(_loc15_) * (param6 / Math.cos(_loc10_ / 2));
               _loc19_ = param3 + Math.sin(_loc15_) * (param7 / Math.cos(_loc10_ / 2));
               param1.curveTo(_loc18_,_loc19_,_loc16_,_loc17_);
               _loc14_++;
            }
            param1.lineTo(param2,param3);
         }
      }
      
      public static function drawDashedLine(param1:Graphics, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number = 10, param7:Number = 10) : void
      {
         var _loc8_:Number = param6 + param7;
         var _loc9_:Number = param4 - param2;
         var _loc10_:Number = param5 - param3;
         var _loc11_:Number = Math.sqrt(Math.pow(_loc9_,2) + Math.pow(_loc10_,2));
         var _loc12_:int = Math.floor(Math.abs(_loc11_ / _loc8_));
         var _loc13_:Number = Math.atan2(_loc10_,_loc9_);
         var _loc14_:Number = param2;
         var _loc15_:Number = param3;
         _loc9_ = Math.cos(_loc13_) * _loc8_;
         _loc10_ = Math.sin(_loc13_) * _loc8_;
         var _loc16_:int = 0;
         while(_loc16_ < _loc12_)
         {
            param1.moveTo(_loc14_,_loc15_);
            param1.lineTo(_loc14_ + Math.cos(_loc13_) * param6,_loc15_ + Math.sin(_loc13_) * param6);
            _loc14_ += _loc9_;
            _loc15_ += _loc10_;
            _loc16_++;
         }
         param1.moveTo(_loc14_,_loc15_);
         if((_loc11_ = Math.sqrt((param4 - _loc14_) * (param4 - _loc14_) + (param5 - _loc15_) * (param5 - _loc15_))) > param6)
         {
            param1.lineTo(_loc14_ + Math.cos(_loc13_) * param6,_loc15_ + Math.sin(_loc13_) * param6);
         }
         else if(_loc11_ > 0)
         {
            param1.lineTo(_loc14_ + Math.cos(_loc13_) * _loc11_,_loc15_ + Math.sin(_loc13_) * _loc11_);
         }
         param1.moveTo(param4,param5);
      }
   }
}
