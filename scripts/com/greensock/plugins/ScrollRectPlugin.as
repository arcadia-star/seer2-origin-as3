package com.greensock.plugins
{
   import com.greensock.*;
   import flash.display.*;
   import flash.geom.Rectangle;
   
   public class ScrollRectPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1;
       
      
      protected var _target:DisplayObject;
      
      protected var _rect:Rectangle;
      
      public function ScrollRectPlugin()
      {
         super();
         this.propName = "scrollRect";
         this.overwriteProps = ["scrollRect"];
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         var _loc4_:String = null;
         var _loc5_:Rectangle = null;
         if(!(param1 is DisplayObject))
         {
            return false;
         }
         _target = param1 as DisplayObject;
         if(_target.scrollRect != null)
         {
            _rect = _target.scrollRect;
         }
         else
         {
            _loc5_ = _target.getBounds(_target);
            _rect = new Rectangle(0,0,_loc5_.width + _loc5_.x,_loc5_.height + _loc5_.y);
         }
         for(_loc4_ in param2)
         {
            addTween(_rect,_loc4_,_rect[_loc4_],param2[_loc4_],_loc4_);
         }
         return true;
      }
      
      override public function set changeFactor(param1:Number) : void
      {
         updateTweens(param1);
         _target.scrollRect = _rect;
      }
   }
}
