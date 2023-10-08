package com.taomee.seer2.app.component.teleport
{
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class HomeDeferTeleport extends DeferTeleport
   {
      
      public static const ACTOR_ARRIVED:String = "actorArrived";
       
      
      public function HomeDeferTeleport(param1:MovieClip)
      {
         super(param1);
      }
      
      override protected function onDoorOpen(param1:Event) : void
      {
         SceneManager.changeScene(_type,_actorTargetMapId);
         LayerManager.resetOperation();
         param1.stopPropagation();
      }
   }
}
