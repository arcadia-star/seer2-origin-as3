package com.taomee.seer2.app.activity.processor.flameBattle
{
   import com.taomee.seer2.app.activity.data.ActivityPet;
   import com.taomee.seer2.app.activity.processor.ActivityProcessor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.RemoteActor;
   import com.taomee.seer2.app.actor.constant.EquipSlot;
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightMode;
   import com.taomee.seer2.app.inventory.item.EquipItem;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.entity.definition.NpcDefinition;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   
   public class ActivityMapHandler_263 extends FlameBattleMapHandler
   {
       
      
      private const BAKAER_GUARD:int = 7;
      
      private const LUOKE_GUARD:int = 8;
      
      private const AOLA:int = 9;
      
      private const MALI:int = 10;
      
      private const BALAKA:int = 11;
      
      private const LUOKE:int = 12;
      
      private var _thisActivityMonsterVec:Vector.<ActivityPet>;
      
      private var _oppositeActivityMonsterVec:Vector.<ActivityPet>;
      
      private var _currentBossId:int;
      
      private var _maliMobile:Mobile;
      
      private var _aolaMobile:Mobile;
      
      private var _balakaMobile:Mobile;
      
      private var _luokeMobile:Mobile;
      
      private var _wingEquip:EquipItem;
      
      private var _proportion:MovieClip;
      
      private var _blue:MovieClip;
      
      private var _red:MovieClip;
      
      private var _remoteList:Vector.<RemoteActor>;
      
      private var _mouseRemote:RemoteActor;
      
      public function ActivityMapHandler_263(param1:ActivityProcessor)
      {
         super(param1);
      }
      
      override public function process() : void
      {
         super.process();
         if(_isTimeOut)
         {
            return;
         }
         var _loc1_:int = this.getCurrentBossId();
         if(_loc1_ == 0)
         {
            SceneManager.changeScene(SceneType.LOBBY,261,700,340);
            return;
         }
         if(_loc1_ != 0 && this._currentBossId != _loc1_)
         {
            this._currentBossId = _loc1_;
            this.processsLayout();
            this.getTroopFraction();
            this.getRemoteList();
            this.changeUserEquip();
            this.processMobile();
            this.getAllUserStatus();
         }
         this.noticePvpCope();
         this.refreshActivity();
      }
      
      private function processsLayout() : void
      {
         this._proportion = SceneManager.active.mapModel.content["proportion"];
         this._blue = this._proportion["blue"];
         this._red = this._proportion["red"];
         this._blue.scaleX = 0.5;
         this._red.scaleX = 0.5;
      }
      
      private function getTroopFraction() : void
      {
         Connection.addCommandListener(CommandSet.GET_ACTIVITY_TROOP_FRACTION_1108,this.onGetTroopFraction);
         Connection.send(CommandSet.GET_ACTIVITY_TROOP_FRACTION_1108);
      }
      
      private function onGetTroopFraction(param1:MessageEvent) : void
      {
         var _loc2_:IDataInput = param1.message.getRawData();
         blueFraction = _loc2_.readUnsignedInt();
         redFraction = _loc2_.readUnsignedInt();
         this.setProportion();
      }
      
      private function setProportion() : void
      {
         var _loc1_:uint = blueFraction + redFraction;
         this._blue.scaleX = blueFraction / _loc1_;
         this._red.scaleX = redFraction / _loc1_;
         if(_loc1_ == 0)
         {
            this._blue.scaleX = 0.5;
            this._red.scaleX = 0.5;
         }
         TooltipManager.addCommonTip(this._proportion,"洛克 " + redFraction + "：" + blueFraction + " 巴尔卡");
      }
      
      private function getRemoteList() : void
      {
         this._remoteList = ActorManager.getAllRemoteActors();
         this.setRemote();
         Connection.addCommandListener(CommandSet.LIST_USER_1004,this.listUsers);
         Connection.addCommandListener(CommandSet.USER_ENTER_MAP_1002,this.getChangmapUserList);
      }
      
      private function listUsers(param1:MessageEvent) : void
      {
         this._remoteList = ActorManager.getAllRemoteActors();
         this.setRemote();
      }
      
      private function getChangmapUserList(param1:MessageEvent) : void
      {
         this._remoteList = ActorManager.getAllRemoteActors();
         this.setRemote();
      }
      
      private function setRemote() : void
      {
         var _loc1_:RemoteActor = null;
         for each(_loc1_ in this._remoteList)
         {
            if(_loc1_.getInfo().troop == 1)
            {
               this.changeEquip(_loc1_,1);
            }
            else if(_loc1_.getInfo().troop == 2)
            {
               this.changeEquip(_loc1_,2);
            }
            _loc1_.removeMouseEvent();
            _loc1_.buttonMode = false;
            if(_loc1_.getInfo().troop != troop && _loc1_.getInfo().activityStatus == 0 && _loc1_.isFighting == false)
            {
               _loc1_.buttonMode = true;
               _loc1_.addEventListener(MouseEvent.CLICK,this.onRemoteClick);
            }
         }
      }
      
      private function changeEquip(param1:RemoteActor, param2:int) : void
      {
         var _loc4_:EquipItem = null;
         var _loc3_:Vector.<EquipItem> = param1.getInfo().equipVec;
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_.slotIndex == EquipSlot.WING)
            {
               param1.removeEquipByReferenceId(_loc4_.referenceId);
            }
         }
         if(param1.getInfo().troop == 1)
         {
            param1.addEquipByReferenceId(100106);
         }
         else if(param1.getInfo().troop == 2)
         {
            param1.addEquipByReferenceId(100107);
         }
      }
      
      private function onRemoteClick(param1:MouseEvent) : void
      {
         this._mouseRemote = param1.currentTarget as RemoteActor;
         if(this._mouseRemote.getInfo().activityStatus == 1 || this._mouseRemote.isFighting)
         {
            return;
         }
         if(PetInfoManager.getFirstPetInfo().hp <= 1)
         {
            AlertManager.showAlert("您的首发精灵体力不够");
            return;
         }
         if(TimeManager.getAvailableTime() <= 0)
         {
            AlertManager.showAlert("电池耗尽");
            return;
         }
         var _loc2_:LittleEndianByteArray = new LittleEndianByteArray();
         _loc2_.writeInt(this._mouseRemote.getInfo().id);
         _loc2_.writeInt(FightMode.FIGHT_PVP_ACTIVIITY);
         _loc2_.writeByte(1);
         _loc2_.position = 0;
         Connection.addErrorHandler(CommandSet.FIGHE_PLAYER_INVITE_1503,this.onFightPlayerInviteError);
         Connection.addCommandListener(CommandSet.FIGHE_PLAYER_INVITE_1503,this.onFightPlayerInvite);
         Connection.send(CommandSet.FIGHE_PLAYER_INVITE_1503,_loc2_);
      }
      
      private function onFightPlayerInviteError(param1:MessageEvent) : void
      {
         if(param1.message.statusCode == 121)
         {
            AlertManager.showAlert("对方的首发精灵没有体力");
         }
      }
      
      private function onFightPlayerInvite(param1:MessageEvent) : void
      {
         var _loc2_:UserInfo = ActorManager.actorInfo;
         var _loc3_:UserInfo = this._mouseRemote.getInfo();
         var _loc4_:Object;
         (_loc4_ = new Object()).requestOrNotRequest = true;
         _loc4_.thisInfo = _loc2_;
         _loc4_.oppositeInfo = _loc3_;
         ModuleManager.showModule(URLUtil.getAppModule("RequestFightPanel"),"正在打开对战面板...",_loc4_);
      }
      
      private function getAllUserStatus() : void
      {
         Connection.addCommandListener(CommandSet.ACTIVITY_ALL_USER_STATUS_1110,this.onAllUserStatus);
         Connection.send(CommandSet.ACTIVITY_ALL_USER_STATUS_1110);
      }
      
      private function noticePvpCope() : void
      {
         if(Connection.hasCommadnListener(CommandSet.NOTICE_PVP_COPE_1107) == false)
         {
            Connection.addCommandListener(CommandSet.NOTICE_PVP_COPE_1107,this.onNoticePvpCope);
         }
      }
      
      private function onNoticePvpCope(param1:MessageEvent) : void
      {
         var _loc6_:UserInfo = null;
         var _loc7_:UserInfo = null;
         var _loc8_:Object = null;
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:uint = uint(_loc2_.readUnsignedInt());
         var _loc5_:uint = uint(_loc2_.readUnsignedInt());
         if(_loc4_ == 0)
         {
            _loc6_ = ActorManager.getRemoteActor(_loc3_).getInfo();
            _loc7_ = new UserInfo();
            (_loc8_ = new Object()).requestOrNotRequest = false;
            _loc8_.thisInfo = _loc7_;
            _loc8_.oppositeInfo = _loc6_;
            ModuleManager.showModule(URLUtil.getAppModule("RequestFightPanel"),"正在打开对战面板...",_loc8_);
         }
      }
      
      private function onAllUserStatus(param1:MessageEvent) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc8_:RemoteActor = null;
         var _loc2_:IDataInput = param1.message.getRawDataCopy();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc6_:Vector.<RemoteActor> = ActorManager.getAllRemoteActors();
         var _loc7_:int = 0;
         while(_loc7_ < _loc3_)
         {
            _loc4_ = uint(_loc2_.readUnsignedInt());
            _loc5_ = int(_loc2_.readUnsignedByte());
            for each(_loc8_ in _loc6_)
            {
               if(_loc8_.id == _loc4_)
               {
                  _loc8_.getInfo().activityStatus = _loc5_;
               }
            }
            _loc7_++;
         }
      }
      
      private function changeUserEquip() : void
      {
         var _loc2_:EquipItem = null;
         var _loc3_:EquipItem = null;
         var _loc1_:Vector.<EquipItem> = ActorManager.actorInfo.equipVec;
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_.slotIndex == EquipSlot.WING)
            {
               this._wingEquip = _loc2_;
            }
         }
         if(this._wingEquip)
         {
            ActorManager.getActor().removeEquipByReferenceId(this._wingEquip.referenceId);
         }
         if(troop == 1)
         {
            ActorManager.getActor().addEquipByReferenceId(100106);
         }
         else if(troop == 2)
         {
            ActorManager.getActor().addEquipByReferenceId(100107);
         }
      }
      
      private function processMobile() : void
      {
         if(this._currentBossId == this.MALI)
         {
            this.processMaliAolaNpc();
         }
         else if(this._currentBossId == this.BALAKA)
         {
            this.processMaliAolaNpc();
            this.processBakaerLuokeNpc();
         }
         this.processActivityMonster();
      }
      
      private function getCurrentBossId() : int
      {
         var _loc1_:uint = uint(TimeManager.getServerTime());
         var _loc2_:Date = new Date(_loc1_ * 1000);
         var _loc3_:uint = uint(_loc2_.hours * 60 + _loc2_.minutes);
         if(_loc3_ < _currentTimeVec[1] && _loc3_ >= _currentTimeVec[0])
         {
            return this.BAKAER_GUARD;
         }
         if(_loc3_ < _currentTimeVec[3] && _loc3_ >= _currentTimeVec[2])
         {
            return this.BAKAER_GUARD;
         }
         if(_loc3_ < _currentTimeVec[5] && _loc3_ >= _currentTimeVec[4])
         {
            return this.MALI;
         }
         if(_loc3_ < _currentTimeVec[7] && _loc3_ >= _currentTimeVec[6])
         {
            return this.BALAKA;
         }
         return 0;
      }
      
      private function processMaliAolaNpc() : void
      {
         var _loc1_:XML = <npc id="307" resId="307" name="奥拉" dir="1" width="70" height="110" pos="485,388" actorPos="480,380" path="">
								</npc>;
         var _loc2_:NpcDefinition = new NpcDefinition(_loc1_);
         this._aolaMobile = MobileManager.createNpc(_loc2_);
         this._aolaMobile.buttonMode = true;
         this._aolaMobile.name = "奥拉";
         var _loc3_:XML = <npc id="308" resId="308" name="玛里" dir="1" width="70" height="100" pos="420,333" actorPos="410,333" path="">
								</npc>;
         var _loc4_:NpcDefinition = new NpcDefinition(_loc3_);
         this._maliMobile = MobileManager.createNpc(_loc4_);
         this._maliMobile.buttonMode = true;
         this._maliMobile.name = "玛里";
         if(troop == 1)
         {
            this._aolaMobile.addEventListener(MouseEvent.CLICK,this.onFightClick);
            this._maliMobile.buttonMode = false;
         }
         else if(troop == 2)
         {
            this._maliMobile.addEventListener(MouseEvent.CLICK,this.onFightClick);
            this._aolaMobile.buttonMode = false;
         }
      }
      
      private function onFightClick(param1:MouseEvent) : void
      {
         if(param1.currentTarget.name == "奥拉" || param1.currentTarget.name == "玛里")
         {
            this._aolaMobile.removeEventListener(MouseEvent.CLICK,this.onFightClick);
            this._maliMobile.removeEventListener(MouseEvent.CLICK,this.onFightClick);
         }
         else if(param1.currentTarget.name == "巴拉卡" || param1.currentTarget.name == "洛克")
         {
            this._aolaMobile.removeEventListener(MouseEvent.CLICK,this.onFightClick);
            this._maliMobile.removeEventListener(MouseEvent.CLICK,this.onFightClick);
            this._balakaMobile.removeEventListener(MouseEvent.CLICK,this.onFightClick);
            this._luokeMobile.removeEventListener(MouseEvent.CLICK,this.onFightClick);
         }
         switch(param1.currentTarget.name)
         {
            case "奥拉":
               FightManager.startFightWithActivityBoss(this.AOLA);
               break;
            case "玛里":
               FightManager.startFightWithActivityBoss(this.MALI);
               break;
            case "巴尔卡":
               FightManager.startFightWithActivityBoss(this.BALAKA);
               break;
            case "洛克":
               FightManager.startFightWithActivityBoss(this.LUOKE);
         }
      }
      
      private function processBakaerLuokeNpc() : void
      {
         var _loc1_:XML = <npc id="305" resId="305" name="巴尔卡" dir="1" width="70" height="115" pos="108,276" actorPos="265,328" path="">
								</npc>;
         var _loc2_:NpcDefinition = new NpcDefinition(_loc1_);
         this._balakaMobile = MobileManager.createNpc(_loc2_);
         this._balakaMobile.buttonMode = true;
         this._balakaMobile.name = "巴尔卡";
         var _loc3_:XML = <npc id="306" resId="306" name="洛克" dir="0" width="70" height="110" pos="790,137" actorPos="675,386" path="">
								</npc>;
         var _loc4_:NpcDefinition = new NpcDefinition(_loc3_);
         this._luokeMobile = MobileManager.createNpc(_loc4_);
         this._luokeMobile.buttonMode = true;
         this._luokeMobile.name = "洛克";
         if(troop == 2)
         {
            this._balakaMobile.addEventListener(MouseEvent.CLICK,this.onFightClick);
            this._luokeMobile.buttonMode = false;
         }
         else if(troop == 1)
         {
            this._luokeMobile.addEventListener(MouseEvent.CLICK,this.onFightClick);
            this._balakaMobile.buttonMode = false;
         }
      }
      
      private function processActivityMonster() : void
      {
         var _loc2_:ActivityPet = null;
         var _loc3_:ActivityPet = null;
         this.removeMapActivityMonster();
         this._thisActivityMonsterVec = new Vector.<ActivityPet>([]);
         this._oppositeActivityMonsterVec = new Vector.<ActivityPet>([]);
         var _loc1_:uint = 0;
         while(_loc1_ < ACTIVITY_MONSTER_NUM)
         {
            _loc2_ = new ActivityPet(this.BAKAER_GUARD);
            this._thisActivityMonsterVec.push(_loc2_);
            MobileManager.addMobile(_loc2_,MobileType.ACTIVITY_MONSTER);
            _loc3_ = new ActivityPet(this.LUOKE_GUARD);
            this._oppositeActivityMonsterVec.push(_loc3_);
            MobileManager.addMobile(_loc3_,MobileType.ACTIVITY_MONSTER);
            _loc1_++;
         }
         this.whichTroop();
      }
      
      private function whichTroop() : void
      {
         if(troop == 1)
         {
            this.setPetMouseEvent(this._thisActivityMonsterVec);
         }
         else if(troop == 2)
         {
            this.setPetMouseEvent(this._oppositeActivityMonsterVec);
         }
      }
      
      private function setPetMouseEvent(param1:Vector.<ActivityPet>) : void
      {
         var _loc2_:ActivityPet = null;
         for each(_loc2_ in param1)
         {
            _loc2_.mouseChildren = false;
            _loc2_.mouseEnabled = false;
         }
      }
      
      private function refreshActivity() : void
      {
         this.showMapActivityAnimation();
      }
      
      private function showMapActivityAnimation() : void
      {
         var _loc1_:* = _activityProcessor.getActivityID() + "/1";
         playActivityAnimation(_loc1_);
      }
      
      private function removeNpc() : void
      {
         if(this._maliMobile)
         {
            MobileManager.removeMobileById(this._maliMobile.id,MobileType.NPC);
         }
         if(this._aolaMobile)
         {
            MobileManager.removeMobileById(this._aolaMobile.id,MobileType.NPC);
         }
         if(this._balakaMobile)
         {
            MobileManager.removeMobileById(this._balakaMobile.id,MobileType.NPC);
         }
         if(this._luokeMobile)
         {
            MobileManager.removeMobileById(this._luokeMobile.id,MobileType.NPC);
         }
      }
      
      private function removeChangeUserEquip() : void
      {
         if(troop == 1)
         {
            ActorManager.getActor().removeEquipByReferenceId(100106);
         }
         else if(troop == 2)
         {
            ActorManager.getActor().removeEquipByReferenceId(100107);
         }
         if(this._wingEquip)
         {
            ActorManager.getActor().addEquipByReferenceId(this._wingEquip.referenceId);
         }
      }
      
      private function removeMapActivityMonster() : void
      {
         var _loc1_:ActivityPet = null;
         var _loc2_:ActivityPet = null;
         if(this._thisActivityMonsterVec == null)
         {
            return;
         }
         for each(_loc1_ in this._thisActivityMonsterVec)
         {
            MobileManager.removeMobileById(_loc1_.id,MobileType.ACTIVITY_MONSTER);
            _loc1_ = null;
         }
         this._thisActivityMonsterVec = null;
         for each(_loc2_ in this._oppositeActivityMonsterVec)
         {
            MobileManager.removeMobileById(_loc2_.id,MobileType.ACTIVITY_MONSTER);
            _loc2_ = null;
         }
         this._oppositeActivityMonsterVec = null;
      }
      
      override public function dispose() : void
      {
         TooltipManager.remove(this._proportion);
         this._remoteList = null;
         Connection.removeErrorHandler(CommandSet.FIGHE_PLAYER_INVITE_1503,this.onFightPlayerInviteError);
         Connection.removeCommandListener(CommandSet.FIGHE_PLAYER_INVITE_1503,this.onFightPlayerInvite);
         Connection.removeCommandListener(CommandSet.ACTIVITY_ALL_USER_STATUS_1110,this.onAllUserStatus);
         Connection.removeCommandListener(CommandSet.USER_ENTER_MAP_1002,this.getChangmapUserList);
         Connection.removeCommandListener(CommandSet.LIST_USER_1004,this.listUsers);
         Connection.removeCommandListener(CommandSet.NOTICE_PVP_COPE_1107,this.onNoticePvpCope);
         Connection.removeCommandListener(CommandSet.GET_ACTIVITY_TROOP_FRACTION_1108,this.onGetTroopFraction);
         this.removeChangeUserEquip();
         this._currentBossId = 0;
         this.removeNpc();
         this.removeMapActivityMonster();
         super.dispose();
      }
   }
}
