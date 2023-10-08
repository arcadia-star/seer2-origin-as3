package com.taomee.seer2.app.gameRule.door.alone
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.FightVerifyManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.gameRule.door.constant.DoorRule;
   import com.taomee.seer2.app.gameRule.door.constant.DoorType;
   import com.taomee.seer2.app.gameRule.door.core.IMultiSelectable;
   import com.taomee.seer2.app.gameRule.door.core.ServerReward;
   import com.taomee.seer2.app.gameRule.door.core.vo.DoorInitData;
   import com.taomee.seer2.app.gameRule.door.support.DoorSupportInfo;
   import com.taomee.seer2.app.gameRule.door.support.IUpDoorSupport;
   import com.taomee.seer2.app.gameRule.door.util.Door21LevelUtil;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.utils.IDataInput;
   
   public class AloneDoorSupport implements IMultiSelectable, IUpDoorSupport
   {
      
      private static var _instance:com.taomee.seer2.app.gameRule.door.alone.AloneDoorSupport;
       
      
      private var _uiController:com.taomee.seer2.app.gameRule.door.alone.AloneDoorUIController;
      
      private var _map:MapModel;
      
      private var _isGetServerGiveFlag:Boolean = false;
      
      private var _serverGivePetInfo:PetInfo;
      
      private var _doorLevel:uint = 1;
      
      private var _canLevelNow:Boolean = true;
      
      private var _supportInfo:DoorSupportInfo;
      
      private var _serverGivePetList:Vector.<ServerReward>;
      
      public function AloneDoorSupport()
      {
         super();
         this._uiController = new com.taomee.seer2.app.gameRule.door.alone.AloneDoorUIController();
         this._supportInfo = new DoorSupportInfo(DoorRule.ALONE_DOOR,DoorType.Door_NORMAL,412,"AloneDoorStartPanel");
      }
      
      public static function getInstance() : com.taomee.seer2.app.gameRule.door.alone.AloneDoorSupport
      {
         if(_instance == null)
         {
            _instance = new com.taomee.seer2.app.gameRule.door.alone.AloneDoorSupport();
         }
         return _instance;
      }
      
      private function dealWithFightResult(param1:uint) : void
      {
         if(param1 == FightSide.RIGHT)
         {
            AlertManager.showDoorResult(false,this._supportInfo.doorType,this._supportInfo.doorRule);
         }
         else if(param1 == FightSide.LEFT)
         {
            if(this._doorLevel >= 4)
            {
               if(this._isGetServerGiveFlag)
               {
                  AlertManager.showDoorResult(true,this._supportInfo.doorType,this._supportInfo.doorRule,this._serverGivePetInfo);
                  this._isGetServerGiveFlag = false;
                  this._serverGivePetInfo = null;
               }
               else
               {
                  this._isGetServerGiveFlag = true;
               }
            }
            else
            {
               this.setDoorLevel(this._doorLevel + 1);
            }
         }
      }
      
      private function upNextLevelComplete() : void
      {
         this._canLevelNow = true;
      }
      
      private function setDoorLevel(param1:uint) : void
      {
         this._canLevelNow = false;
         this._doorLevel = param1;
         this._uiController.updateLevel(this._doorLevel,this.upNextLevelComplete);
      }
      
      private function onStartFight() : void
      {
         var onComplete:Function = null;
         var information:DoorInitData = null;
         onComplete = function():void
         {
            ModuleManager.toggleModule(URLUtil.getAppModule(_supportInfo.doorStartPanel),"正在打开选择面板...",information);
         };
         if(this.canLevelNow)
         {
            if(FightVerifyManager.checkVerifyStatus() == false)
            {
               return;
            }
            information = new DoorInitData();
            information.npcName = this.getGuardName();
            information.npcPets = Door21LevelUtil.getGuardPets(this._doorLevel,this._supportInfo.doorType,this._supportInfo.doorRule);
            information.supportInstance = this;
            information.doorLevel = this._doorLevel;
            information.playerName = ActorManager.actorInfo.nick;
            this.getPlayerPets(information,onComplete);
         }
      }
      
      private function getPlayerPets(param1:DoorInitData, param2:Function) : void
      {
         var deathIdList:Array = null;
         var onListComplete:Function = null;
         var information:DoorInitData = param1;
         var onComplete:Function = param2;
         onListComplete = function(param1:MessageEvent):void
         {
            var _loc4_:uint = 0;
            Connection.removeCommandListener(CommandSet.PLAYING_DEATH_LIST_1172,onListComplete);
            var _loc2_:IDataInput = param1.message.getRawData();
            var _loc3_:uint = uint(_loc2_.readUnsignedInt());
            while(_loc4_ < _loc3_)
            {
               deathIdList.push(_loc2_.readUnsignedInt());
               _loc4_++;
            }
            getFightPets();
            onComplete();
         };
         var getFightPets:Function = function():void
         {
            var _loc3_:PetInfo = null;
            var _loc4_:int = 0;
            var _loc1_:Vector.<PetInfo> = new Vector.<PetInfo>();
            var _loc2_:Vector.<PetInfo> = PetInfoManager.getAllBagPetInfo();
            for each(_loc3_ in _loc2_)
            {
               if((_loc4_ = deathIdList.indexOf(_loc3_.catchTime)) == -1)
               {
                  _loc1_.push(_loc3_);
               }
            }
            information.playerPets = _loc1_;
         };
         deathIdList = new Array();
         Connection.addCommandListener(CommandSet.PLAYING_DEATH_LIST_1172,onListComplete);
         Connection.send(CommandSet.PLAYING_DEATH_LIST_1172);
      }
      
      private function getGuardName() : String
      {
         if(this._doorLevel < 4)
         {
            return "守护者";
         }
         return "第五队队长";
      }
      
      public function reset() : void
      {
         this._doorLevel = 1;
      }
      
      public function get canLevelNow() : Boolean
      {
         return this._canLevelNow;
      }
      
      public function set canLevelNow(param1:Boolean) : void
      {
         this._canLevelNow = param1;
      }
      
      public function init(param1:MapModel) : void
      {
         this._canLevelNow = true;
         this._uiController.init(param1,this.onStartFight);
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            this.dealWithFightResult(FightManager.fightWinnerSide);
         }
         else
         {
            this.setDoorLevel(this._supportInfo.currentDoorLevel);
         }
      }
      
      public function dispose() : void
      {
         this._uiController.dispose();
      }
      
      public function get supportInfo() : DoorSupportInfo
      {
         return this._supportInfo;
      }
      
      public function get rewardIDList() : Vector.<ServerReward>
      {
         return this._serverGivePetList;
      }
      
      public function set rewardIDList(param1:Vector.<ServerReward>) : void
      {
         this._serverGivePetList = param1;
      }
   }
}
