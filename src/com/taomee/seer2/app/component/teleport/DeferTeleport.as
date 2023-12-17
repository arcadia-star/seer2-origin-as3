package com.taomee.seer2.app.component.teleport
{
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.core.entity.events.MoveEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   
   public class DeferTeleport extends EventDispatcher
   {
      
      public static const DOOR_OPEN:String = "doorOpen";
      
      public static const ACTOR_ARRIVED:String = "actorArrived";
       
      
      private var _mc:MovieClip;
      
      private var _actorPosition:Point;
      
      protected var _type:int = 1;
      
      protected var _actorTargetMapId:uint;
      
      public function DeferTeleport(param1:MovieClip)
      {
         super(this);
         this._mc = param1;
         this.addDoorOpenEventListener();
      }
      
      private function addDoorOpenEventListener() : void
      {
         this._mc.addEventListener(DOOR_OPEN,this.onDoorOpen);
      }
      
      protected function onDoorOpen(param1:Event) : void
      {
         SceneManager.changeScene(this._type,this._actorTargetMapId);
         LayerManager.resetOperation();
         param1.stopPropagation();
      }
      
      public function setActorPostion(param1:Point) : void
      {
         this._actorPosition = param1;
      }
      
      public function setActorTargetMapId(param1:uint, param2:int = 1) : void
      {
         this._actorTargetMapId = param1;
         this._type = param2;
      }
      
      public function actorMoveClose() : void
      {
         var _loc1_:Actor = ActorManager.getActor();
         _loc1_.addEventListener(MoveEvent.FINISHED,this.onActorMoveFinished);
         _loc1_.runToLocation(this._actorPosition.x,this._actorPosition.y);
      }
      
      private function onActorMoveFinished(param1:MoveEvent) : void
      {
         this.removeActorMoveEventListener();
         var _loc2_:Actor = ActorManager.getActor();
         if(_loc2_.isArrivedPosition(this._actorPosition) == true)
         {
            LayerManager.focusOnTopLayer();
            dispatchEvent(new Event(ACTOR_ARRIVED));
         }
      }
      
      private function removeActorMoveEventListener() : void
      {
         ActorManager.getActor().removeEventListener(MoveEvent.FINISHED,this.onActorMoveFinished);
      }
      
      public function dispose() : void
      {
         this._mc.removeEventListener(DOOR_OPEN,this.onDoorOpen);
         this._mc = null;
         this.removeActorMoveEventListener();
      }
   }
}
