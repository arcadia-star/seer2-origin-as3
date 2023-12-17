package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcessor_450 extends MapProcessor
   {
       
      
      private var _goFort:MovieClip;
      
      private var _scene:LobbyScene;
      
      public function MapProcessor_450(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.showToolBar();
         ActorManager.showRemoteActor = true;
         this._goFort = _map.content["goFort"];
         this._goFort.useHandCursor = true;
         this._goFort.buttonMode = true;
         this._goFort.addEventListener(MouseEvent.CLICK,this.onGoFort);
      }
      
      override public function dispose() : void
      {
         this._goFort.removeEventListener(MouseEvent.CLICK,this.onGoFort);
         this._goFort = null;
      }
      
      private function showToolBar() : void
      {
         this._scene = SceneManager.active as LobbyScene;
         this._scene.showToolbar();
      }
      
      private function onGoFort(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("PVPDoorCampPanel"),"正在打开召集令面板...");
      }
   }
}
