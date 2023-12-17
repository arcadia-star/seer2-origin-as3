package com.taomee.seer2.core.scene
{
   public interface ISceneHandler
   {
       
      
      function init(param1:BaseScene) : void;
      
      function onMapStart() : void;
      
      function onTick(param1:int) : void;
      
      function onMapEnd() : void;
      
      function disopse() : void;
   }
}
