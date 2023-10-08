package com.taomee.seer2.core.animation
{
   public interface IAnimation
   {
       
      
      function get totalFrameNum() : uint;
      
      function get currentFrameIndex() : uint;
      
      function get currentFrameLabel() : String;
      
      function play() : void;
      
      function stop() : void;
      
      function gotoAndPlay(param1:uint) : void;
      
      function gotoAndStop(param1:uint) : void;
      
      function hasLabel(param1:String) : Boolean;
      
      function gotoLabel(param1:String) : void;
      
      function isStopAllAnimation(param1:Boolean) : void;
      
      function update() : void;
      
      function dispose() : void;
   }
}
