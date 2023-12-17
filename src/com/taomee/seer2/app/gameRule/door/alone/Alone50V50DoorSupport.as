package com.taomee.seer2.app.gameRule.door.alone
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.FightVerifyManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.gameRule.door.constant.DoorRule;
   import com.taomee.seer2.app.gameRule.door.constant.DoorType;
   import com.taomee.seer2.app.gameRule.door.core.IDoorServerEquipable;
   import com.taomee.seer2.app.gameRule.door.core.vo.DoorInitData;
   import com.taomee.seer2.app.gameRule.door.support.DoorSupportInfo;
   import com.taomee.seer2.app.gameRule.door.support.IUpDoorSupport;
   import com.taomee.seer2.app.gameRule.door.util.Door21LevelUtil;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   
   public class Alone50V50DoorSupport implements IDoorServerEquipable, IUpDoorSupport
   {
      
      private static var _instance:Alone50V50DoorSupport;
       
      
      private var _uiController:AloneDoorUIController;
      
      private var _doorLevel:uint = 1;
      
      private var _canLevelNow:Boolean = true;
      
      private var _supportInfo:DoorSupportInfo;
      
      private var _ITEMS:Array;
      
      private var _equipId:uint = 0;
      
      private var _isGetServerGiveFlag:Boolean = false;
      
      public function Alone50V50DoorSupport()
      {
         super();
         this._uiController = new AloneDoorUIController();
         this._supportInfo = new DoorSupportInfo(DoorRule.ALONE_DOOR,DoorType.Door_50V50,413,"AloneDoorStartPanel");
         this._ITEMS = [100177,100178,100179,100180,100181];
      }
      
      public static function getInstance() : Alone50V50DoorSupport
      {
         if(_instance == null)
         {
            _instance = new Alone50V50DoorSupport();
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
            if(this._doorLevel < 4)
            {
               this._canLevelNow = false;
            }
         }
      }
      
      private function upNextLevelComplete() : void
      {
         this._canLevelNow = true;
         this.setDoorLevel(this._doorLevel + 1);
      }
      
      private function setDoorLevel(param1:uint) : void
      {
         this._doorLevel = param1;
         this._uiController.updateLevel(this._doorLevel);
      }
      
      private function onGuardClick(param1:MouseEvent) : void
      {
         var _loc2_:DoorInitData = null;
         if(this.canLevelNow)
         {
            if(FightVerifyManager.checkVerifyStatus() == false)
            {
               return;
            }
            _loc2_ = new DoorInitData();
            _loc2_.npcName = Door21LevelUtil.getGuardName(this._doorLevel);
            _loc2_.npcPets = Door21LevelUtil.getGuardPets(this._doorLevel,this._supportInfo.doorType,this._supportInfo.doorRule);
            _loc2_.playerName = ActorManager.actorInfo.nick;
            _loc2_.playerPets = PetInfoManager.getAllBagPetInfo();
            _loc2_.supportInstance = this;
            _loc2_.doorLevel = this._doorLevel;
            ModuleManager.toggleModule(URLUtil.getAppModule(this._supportInfo.doorStartPanel),"正在打开选择面板...",_loc2_);
         }
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
      
      private function onStartFight() : void
      {
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
         this._uiController = null;
      }
      
      public function get supportInfo() : DoorSupportInfo
      {
         return this._supportInfo;
      }
      
      public function getEquipSimpleInfo(param1:uint) : void
      {
         if(this._ITEMS.indexOf(param1) != -1 || param1 == 1)
         {
            this._equipId = param1;
            this.showEquip();
         }
      }
      
      private function showEquip() : void
      {
         if(this._isGetServerGiveFlag)
         {
            AlertManager.showDoorResult(true,this._supportInfo.doorType,this._supportInfo.doorRule,null,this._equipId,this.clearServerGive);
         }
         else
         {
            this._isGetServerGiveFlag = true;
         }
      }
      
      private function clearServerGive() : void
      {
         this._isGetServerGiveFlag = false;
         this._equipId = 0;
      }
   }
}
