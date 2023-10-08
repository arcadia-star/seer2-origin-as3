package com.greensock.plugins
{
   import com.greensock.*;
   
   public class ScalePlugin extends TweenPlugin
   {
      
      public static const API:Number = 1;
       
      
      protected var _changeX:Number;
      
      protected var _changeY:Number;
      
      protected var _target:Object;
      
      protected var _startX:Number;
      
      protected var _startY:Number;
      
      public function ScalePlugin()
      {
         super();
         this.propName = "scale";
         this.overwriteProps = ["scaleX","scaleY","width","height"];
      }
      
      override public function killProps(param1:Object) : void
      {
         var _loc2_:int = int(this.overwriteProps.length);
         while(_loc2_--)
         {
            if(this.overwriteProps[_loc2_] in param1)
            {
               this.overwriteProps = [];
               return;
            }
         }
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         if(!param1.hasOwnProperty("scaleX"))
         {
            return false;
         }
         _target = param1;
         _startX = _target.scaleX;
         _startY = _target.scaleY;
         if(typeof param2 == "number")
         {
            _changeX = param2 - _startX;
            _changeY = param2 - _startY;
         }
         else
         {
            _changeX = _changeY = Number(param2);
         }
         return true;
      }
      
      override public function set changeFactor(param1:Number) : void
      {
         _target.scaleX = _startX + param1 * _changeX;
         _target.scaleY = _startY + param1 * _changeY;
      }
   }
}
