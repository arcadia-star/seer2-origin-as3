package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dream.DreamManager;
   import com.taomee.seer2.app.entity.DreamTeleport;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.entity.AnimateElementManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class DreamMapProcessor extends MapProcessor
   {
       
      
      protected var _taskId:uint;
      
      protected var _dreamTeleport:DreamTeleport;
      
      protected var _dreamer:MovieClip;
      
      private var _mouseHint:MouseClickHintSprite;
      
      private var _remoteActorFlag:Boolean;
      
      private var _scene:LobbyScene;
      
      public function DreamMapProcessor(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         StatisticsManager.sendStatisticsByType(StatisticsManager.ENTER_DREAM);
         this.hideToolBar();
         this.hideRemoteActor();
         this.initDreamTeleport();
         this.initDreamer();
         DreamManager.currentTaskId = 0;
      }
      
      private function hideToolBar() : void
      {
         this._scene = SceneManager.active as LobbyScene;
         this._scene.hideToolbar();
      }
      
      private function hideRemoteActor() : void
      {
         this._remoteActorFlag = ActorManager.showRemoteActor;
         ActorManager.showRemoteActor = false;
      }
      
      private function resetRemoteActor() : void
      {
         ActorManager.showRemoteActor = this._remoteActorFlag;
      }
      
      private function initDreamTeleport() : void
      {
         this._dreamTeleport = AnimateElementManager.getElement(1) as DreamTeleport;
         if(this._dreamTeleport)
         {
            this._dreamTeleport.spot.gotoAndStop(1);
         }
      }
      
      private function initDreamer() : void
      {
         if(_map.content["dreamer"] != null)
         {
            this._dreamer = _map.content["dreamer"];
            initInteractor(this._dreamer);
            this._dreamer.gotoAndPlay("enterMap");
            this._dreamer.addEventListener(MouseEvent.MOUSE_OVER,this.onDreamerMouseOver);
         }
      }
      
      protected function onDreamerMouseOver(param1:MouseEvent) : void
      {
      }
      
      private function showToolBar() : void
      {
      }
      
      protected function indicateLeaveDream() : void
      {
         if(this._mouseHint == null)
         {
            this._mouseHint = new MouseClickHintSprite();
         }
         this._mouseHint.x = this._dreamTeleport.x;
         this._mouseHint.y = this._dreamTeleport.y;
         _map.front.addChild(this._mouseHint);
      }
      
      override public function dispose() : void
      {
         this.showToolBar();
         this._scene = null;
         this.resetRemoteActor();
         this._dreamTeleport = null;
         if(this._dreamer)
         {
            this._dreamer.removeEventListener(MouseEvent.MOUSE_OVER,this.onDreamerMouseOver);
            this._dreamer = null;
         }
         if(this._mouseHint)
         {
            DisplayObjectUtil.removeFromParent(this._mouseHint);
            this._mouseHint = null;
         }
         ActorManager.getActor().alpha = 1;
         ActorManager.getActor().getNono().alpha = 1;
         if(ActorManager.getActor().getFollowingPet())
         {
            ActorManager.getActor().getFollowingPet().alpha = 1;
         }
      }
   }
}
