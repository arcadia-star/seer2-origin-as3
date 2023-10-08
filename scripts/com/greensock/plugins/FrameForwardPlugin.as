package com.greensock.plugins
{
   import com.greensock.TweenLite;
   import flash.display.MovieClip;
   
   public class FrameForwardPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1;
       
      
      protected var _backward:Boolean;
      
      protected var _start:int;
      
      protected var _max:uint;
      
      protected var _change:int;
      
      protected var _target:MovieClip;
      
      public function FrameForwardPlugin()
      {
         super();
         this.propName = "frameForward";
         this.overwriteProps = ["frame","frameLabel","frameForward","frameBackward"];
         this.round = true;
      }
      
      override public function set changeFactor(param1:Number) : void
      {
         var _loc2_:Number = (_start + _change * param1) % _max;
         if(_loc2_ < 0.5 && _loc2_ >= -0.5)
         {
            _loc2_ = _max;
         }
         else if(_loc2_ < 0)
         {
            _loc2_ += _max;
         }
         _target.gotoAndStop(int(_loc2_ + 0.5));
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         if(!(param1 is MovieClip) || isNaN(param2))
         {
            return false;
         }
         _target = param1 as MovieClip;
         _start = _target.currentFrame;
         _max = _target.totalFrames;
         _change = typeof param2 == "number" ? int(Number(param2) - _start) : int(Number(param2));
         if(!_backward && _change < 0)
         {
            _change += _max;
         }
         else if(_backward && _change > 0)
         {
            _change -= _max;
         }
         return true;
      }
   }
}
