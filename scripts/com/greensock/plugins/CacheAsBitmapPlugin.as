package com.greensock.plugins
{
   import com.greensock.TweenLite;
   import flash.display.DisplayObject;
   
   public class CacheAsBitmapPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1;
       
      
      protected var _target:DisplayObject;
      
      protected var _initVal:Boolean;
      
      protected var _cacheAsBitmap:Boolean;
      
      protected var _tween:TweenLite;
      
      public function CacheAsBitmapPlugin()
      {
         super();
         this.propName = "cacheAsBitmap";
         this.overwriteProps = ["cacheAsBitmap"];
      }
      
      override public function set changeFactor(param1:Number) : void
      {
         if(_tween.cachedDuration == _tween.cachedTime || _tween.cachedTime == 0)
         {
            _target.cacheAsBitmap = _initVal;
         }
         else if(_target.cacheAsBitmap != _cacheAsBitmap)
         {
            _target.cacheAsBitmap = _cacheAsBitmap;
         }
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         _target = param1 as DisplayObject;
         _tween = param3;
         _initVal = _target.cacheAsBitmap;
         _cacheAsBitmap = Boolean(param2);
         return true;
      }
   }
}
