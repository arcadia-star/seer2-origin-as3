package com.taomee.seer2.app.processor.map
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.ui.ButtonPanelData;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class FeiyuyiteMap extends TitleMapProcessor
   {
       
      
      private var npc:Mobile;
      
      protected var npcId:int;
      
      protected var moduleName:String = "FeiyiteSuperPanel";
      
      private var activeType:int = 202139;
      
      protected var currentCount:int;
      
      protected var fightId:int = 123;
      
      protected var maxCount:int = 0;
      
      private var _reBloodBtn:SimpleButton;
      
      public function FeiyuyiteMap(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initNpc();
      }
      
      private function initNpc() : void
      {
         if(SceneManager.active.mapModel.content["exitBtn"] != null)
         {
            this._reBloodBtn = SceneManager.active.mapModel.content["exitBtn"];
         }
         if(this.npcId != 0)
         {
            this.npc = MobileManager.getMobile(this.npcId,MobileType.NPC);
            this.npc.mouseChildren = false;
            this.npc.buttonMode = true;
         }
         if(this.npc != null)
         {
            this.npc.addEventListener(MouseEvent.CLICK,this.toFight);
         }
         this._reBloodBtn.addEventListener(MouseEvent.CLICK,this.exitHandler);
      }
      
      protected function toFight(param1:MouseEvent) : void
      {
         var _loc2_:ButtonPanelData = null;
         if(this.currentCount == this.maxCount)
         {
            _loc2_ = new ButtonPanelData();
            _loc2_.catchEnabled = false;
            FightManager.startFightWithWild(this.fightId,null,null,_loc2_);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(this.npc)
         {
            this.npc.removeEventListener(MouseEvent.CLICK,this.toFight);
         }
      }
      
      private function exitHandler(param1:* = null) : void
      {
         var e:* = param1;
         AlertManager.showConfirm("离开地图将结束挑战，你确定要离开吗？",function():void
         {
            leaveMap();
         });
      }
      
      public function leaveMap() : void
      {
         (SceneManager.active as LobbyScene).showToolbar();
         if(SceneManager.active.mapModel.content["exitBtn"])
         {
            SceneManager.active.mapModel.content["exitBtn"].removeEventListener(MouseEvent.CLICK,this.exitHandler);
         }
         TweenNano.delayedCall(1,function():void
         {
            ModuleManager.showAppModule(moduleName);
         });
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
   }
}
