package com.greensock.plugins
{
   import com.greensock.*;
   import flash.display.Stage;
   import flash.display.StageQuality;
   
   public class StageQualityPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1;
       
      
      protected var _during:String;
      
      protected var _tween:TweenLite;
      
      protected var _after:String;
      
      protected var _stage:Stage;
      
      public function StageQualityPlugin()
      {
         super();
         this.propName = "stageQuality";
         this.overwriteProps = ["stageQuality"];
      }
      
      override public function set changeFactor(param1:Number) : void
      {
         if(_tween.cachedDuration == _tween.cachedTime || _tween.cachedTime == 0)
         {
            _stage.quality = _after;
         }
         else if(_stage.quality != _during)
         {
            _stage.quality = _during;
         }
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         if(!(param2.stage is Stage))
         {
            trace("You must define a \'stage\' property for the stageQuality object in your tween.");
            return false;
         }
         _stage = param2.stage as Stage;
         _tween = param3;
         _during = "during" in param2 ? String(param2.during) : StageQuality.MEDIUM;
         _after = "after" in param2 ? String(param2.after) : _stage.quality;
         return true;
      }
   }
}
