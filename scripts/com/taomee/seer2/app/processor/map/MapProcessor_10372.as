package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.processor.map.diceThing.DiceMap10372Manager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.utils.ActsHelperUtil;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class MapProcessor_10372 extends MapProcessor
   {
      
      private static var _preScene:int = -1;
       
      
      private var _telPointMc:MovieClip;
      
      private var _helpBtn:SimpleButton;
      
      private var _swapBtn:SimpleButton;
      
      public function MapProcessor_10372(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         StatisticsManager.newSendNovice("2014活动","脉灵兽超进化","选择海啸口");
         if(SceneManager.prevSceneType == SceneType.LOBBY)
         {
            _preScene = SceneManager.prevMapID;
         }
         ActsHelperUtil.firstPlayFullScreen(ServerBufferType.XIANA_FIRST,"xiaNaGame/XiaNaFullScenePlay",true,1,function():void
         {
         },function():void
         {
         });
         if(SceneManager.prevSceneType == SceneType.LOBBY)
         {
            _preScene = SceneManager.prevMapID;
         }
         this._telPointMc = _map.content["telpoint0"];
         this._helpBtn = _map.content["helpBtn"];
         this._telPointMc.addEventListener(MouseEvent.CLICK,this.onClick);
         this._helpBtn.addEventListener(MouseEvent.CLICK,this.onClick);
         this._telPointMc.buttonMode = true;
         if(_preScene == -1)
         {
            TooltipManager.addCommonTip(this._telPointMc,"传送室");
         }
         else
         {
            TooltipManager.addCommonTip(this._telPointMc,"返回");
         }
         DiceMap10372Manager.ins.setup();
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var _loc2_:LobbyScene = null;
         switch(param1.currentTarget)
         {
            case this._helpBtn:
               ModuleManager.showAppModule("XiaNaHelpPanel");
               break;
            case this._telPointMc:
               _loc2_ = SceneManager.active as LobbyScene;
               _loc2_.showToolbar();
               PetAvatarPanel.show();
               if(_preScene == -1)
               {
                  SceneManager.changeScene(SceneType.LOBBY,70);
               }
               else
               {
                  SceneManager.changeScene(SceneType.LOBBY,_preScene);
               }
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
