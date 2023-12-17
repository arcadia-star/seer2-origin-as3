package com.taomee.seer2.app.arena
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.events.ActorEvent;
   import com.taomee.seer2.app.arena.cmd.ArenaResourceLoadCMD;
   import com.taomee.seer2.app.arena.controller.ArenaUIController;
   import com.taomee.seer2.app.arena.controller.FightController;
   import com.taomee.seer2.app.arena.controller.FightWeatherController;
   import com.taomee.seer2.app.arena.controller.IArenaUIController;
   import com.taomee.seer2.app.arena.controller.IFightController;
   import com.taomee.seer2.app.arena.data.ArenaDataInfo;
   import com.taomee.seer2.app.arena.data.FightResultInfo;
   import com.taomee.seer2.app.arena.data.FighterTeam;
   import com.taomee.seer2.app.arena.events.FightStartEvent;
   import com.taomee.seer2.app.arena.resource.ArenaResourceLoader;
   import com.taomee.seer2.app.arena.util.FightMode;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.gameRule.door.support.PVPDoorSupport;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.BaseScene;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import flash.display.Sprite;
   import flash.utils.setTimeout;
   
   public class ArenaScene extends BaseScene
   {
       
      
      private var _arenaData:ArenaDataInfo;
      
      private var _fightController:IFightController;
      
      private var _arenaUIController:IArenaUIController;
      
      private var _weatherController:FightWeatherController;
      
      public function ArenaScene(param1:int)
      {
         this._arenaData = new ArenaDataInfo();
         super(param1);
      }
      
      override protected function updateScene() : void
      {
         super.updateScene();
         var _loc1_:int = int(mapModel.ground.width);
         mapModel.ground.x = LayerManager.root.width - _loc1_ >> 1;
      }
      
      override protected function onTick(param1:int) : void
      {
         super.onTick(param1);
         if(mapModel && mapModel.front && mapModel.front.parent && (LayerManager.stage.stageWidth < 1200 || LayerManager.stage.stageHeight < 660))
         {
            mapModel.front.parent.x = 0;
            mapModel.front.parent.y = 0;
         }
      }
      
      override protected function syncToServer() : void
      {
         ActorManager.addEventListener(ActorEvent.ACTOR_SYNC_SVR,this.onActorSyncSvr);
         ActorManager.syncToServer();
      }
      
      override public function dispose() : void
      {
         if(this._fightController != null)
         {
            this._fightController.dispose();
            this._fightController = null;
         }
         if(this._arenaUIController != null)
         {
            this._arenaUIController.dispose();
            this._arenaUIController = null;
         }
         if(this._weatherController != null)
         {
            this._weatherController.dispose();
            this._weatherController = null;
         }
         this._arenaData.dispose();
         super.dispose();
      }
      
      public function exitFight() : void
      {
         var _loc1_:uint = uint(SceneManager.prevMapID);
         if(this.fightMode == FightMode.FIGHT_PVP_DOOR_NORMAL || this.fightMode == FightMode.FIGHT_PVP_DOOR_50V50)
         {
            _loc1_ = PVPDoorSupport.getInstance().supportInfo.targetMapId;
         }
         SceneManager.changeScene(SceneManager.prevSceneType,_loc1_);
      }
      
      public function updateWeather(param1:uint) : void
      {
         if(this._weatherController == null)
         {
            this._weatherController = new FightWeatherController(this.fightMode,this);
            if(Boolean(this._arenaUIController) && Boolean(this._arenaUIController.getContent()))
            {
               this._weatherController.addPar(this._arenaUIController.getContent());
            }
         }
         this._weatherController.updateWeather(param1);
      }
      
      private function onActorSyncSvr(param1:ActorEvent) : void
      {
         var arenaResourceLoader:ArenaResourceLoader = null;
         var scene:ArenaScene = null;
         var interruptFlag:Boolean = false;
         var onGetInfoComplete:Function = null;
         var startLoadingFightResource:Function = null;
         var onFightEnd:Function = null;
         var onArenaLoadingBarClose:Function = null;
         var evt:ActorEvent = param1;
         onGetInfoComplete = function():void
         {
            arenaResourceLoader = ArenaResourceLoader.instance;
            ArenaResourceLoader.addLoadingBar();
            FightManager.dispatchEvent(new FightStartEvent(FightStartEvent.FIGHT_LOADING_START));
            arenaResourceLoader.updateLoadingBarShowData(onArenaLoadingBarClose,leftTeam.mainFighterInfo,rightTeam.mainFighterInfo,leftTeam.subFighterInfo,rightTeam.subFighterInfo,_arenaData);
            setTimeout(startLoadingFightResource,2500);
         };
         startLoadingFightResource = function():void
         {
            arenaResourceLoader.loadFightResource(leftTeam,rightTeam,_arenaData);
         };
         onFightEnd = function(param1:MessageEvent):void
         {
            var _loc2_:FightResultInfo = new FightResultInfo(param1.message.getRawData());
            _loc2_.updateWinnerSider(fightMode,leftTeam,rightTeam);
            if(FightManager.currentFightRecord != null)
            {
               FightManager.currentFightRecord.endReason = _loc2_.endReason;
               FightManager.currentFightRecord.fightResult = _loc2_.showWinnerSider;
            }
            interruptFlag = true;
         };
         onArenaLoadingBarClose = function():void
         {
            Connection.removeCommandListener(CommandSet.FIGHT_END_1507,onFightEnd);
            if(interruptFlag)
            {
               AlertManager.showAutoCloseAlert("对手已逃跑",3,exitFight);
            }
            else
            {
               _arenaUIController = new ArenaUIController(scene);
               _fightController = new FightController(scene);
               updateWeather(_arenaData.fightWeather);
               _arenaUIController.startActiveFighter();
               _fightController.startFighter();
            }
            FightManager.dispatchEvent(new FightStartEvent(FightStartEvent.FIGHT_LOADING_END));
         };
         ActorManager.removeEventListener(ActorEvent.ACTOR_SYNC_SVR,this.onActorSyncSvr);
         completeMap();
         scene = this;
         interruptFlag = false;
         DialogPanel.hide();
         Connection.addCommandListener(CommandSet.FIGHT_END_1507,onFightEnd);
         new ArenaResourceLoadCMD(this._arenaData,onGetInfoComplete).send();
      }
      
      public function sortAllFighters() : void
      {
         var ctt:Sprite;
         var len:uint;
         var i:uint;
         var sortByY:Function = null;
         var addToSortArray:Function = function(param1:Fighter, param2:Vector.<Fighter>):void
         {
            if(param1 != null)
            {
               param2.push(param1);
            }
         };
         sortByY = function(param1:Fighter, param2:Fighter):int
         {
            var _loc5_:uint = 0;
            var _loc6_:uint = 0;
            var _loc3_:uint = param1.fighterInfo.position;
            var _loc4_:uint = param2.fighterInfo.position;
            if(_loc3_ < _loc4_)
            {
               return 1;
            }
            if(_loc3_ == _loc4_)
            {
               _loc5_ = uint(param1.fighterSide);
               _loc6_ = uint(param2.fighterSide);
               if(_loc5_ < _loc6_)
               {
                  return 1;
               }
               return -1;
            }
            return -1;
         };
         var fighters:Vector.<Fighter> = new Vector.<Fighter>();
         if(this.leftTeam.subFighter != null)
         {
            addToSortArray(this.leftTeam.mainFighter,fighters);
            addToSortArray(this.leftTeam.subFighter,fighters);
         }
         if(this.rightTeam.subFighter != null)
         {
            addToSortArray(this.rightTeam.mainFighter,fighters);
            addToSortArray(this.rightTeam.subFighter,fighters);
         }
         fighters = fighters.sort(sortByY);
         ctt = mapModel.content;
         len = fighters.length;
         i = 0;
         while(i < len)
         {
            ctt.addChild(fighters[i]);
            i++;
         }
         fighters = null;
      }
      
      public function get fightController() : IFightController
      {
         return this._fightController;
      }
      
      public function get arenaUIController() : IArenaUIController
      {
         return this._arenaUIController;
      }
      
      public function get leftTeam() : FighterTeam
      {
         return this._arenaData.leftTeam;
      }
      
      public function get rightTeam() : FighterTeam
      {
         return this._arenaData.rightTeam;
      }
      
      public function get fightMode() : uint
      {
         return this._arenaData.fightMode;
      }
      
      public function get arenaData() : ArenaDataInfo
      {
         return this._arenaData;
      }
   }
}
