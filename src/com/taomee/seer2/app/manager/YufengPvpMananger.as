package com.taomee.seer2.app.manager
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.actor.preview.ActorPreview;
   import com.taomee.seer2.app.actor.util.ActorEquipAssembler;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.events.FightStartEvent;
   import com.taomee.seer2.app.component.IconDisplayer;
   import com.taomee.seer2.app.info.PVPInfo;
   import com.taomee.seer2.app.inventory.item.EquipItem;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.ErrorMap;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.sound.SoundManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   
   public class YufengPvpMananger
   {
      
      private static var _pvpInfo:PVPInfo;
      
      private static var _enterFightFun:Function;
      
      private static var _endFightFun:Function;
      
      private static var _mc:MovieClip;
      
      private static var _remoteInfo:UserInfo;
      
      private static var _thisPetList:Vector.<PetInfo>;
      
      private static var _remotePetList:Vector.<PetInfo>;
      
      private static var _thisPreview:ActorPreview;
      
      private static var _remotePreview:ActorPreview;
      
      private static var _thisIconList:Vector.<IconDisplayer>;
      
      private static var _remoteIconList:Vector.<IconDisplayer>;
       
      
      public function YufengPvpMananger()
      {
         super();
      }
      
      public static function startPVPFight(param1:Vector.<uint>, param2:uint, param3:uint, param4:uint, param5:Function = null, param6:Function = null, param7:int = 6, param8:int = 6) : void
      {
         _enterFightFun = param5;
         _endFightFun = param6;
         _pvpInfo = new PVPInfo();
         _pvpInfo.minPetNum = param7;
         _pvpInfo.maxPetNum = param8;
         _pvpInfo.gate = param2;
         _pvpInfo.mode = param3;
         _pvpInfo.type = param4;
         _pvpInfo.isStartFight = false;
         _pvpInfo.isShowTag = false;
         if(PetInfoManager.getAllBagPetInfo().length < _pvpInfo.minPetNum)
         {
            AlertManager.showAlert("出战精灵数量不足");
            return;
         }
         _pvpInfo.petList = param1;
         applyMatch();
      }
      
      private static function applyMatch() : void
      {
         Connection.addCommandListener(CommandSet.DOOR_FIGHT_MATCH_CANCEL_1080,onPvpError);
         Connection.addCommandListener(CommandSet.DOOR_FIGHT_MATCH_END_1082,matchSuccess);
         Connection.addErrorHandler(CommandSet.DOOR_FIGHT_MATCH_END_1082,onPvpError);
         Connection.addErrorHandler(CommandSet.DOOR_FIGHT_MATCH_1079,onPvpError);
         Connection.send(CommandSet.DOOR_FIGHT_MATCH_1079,_pvpInfo.gate,_pvpInfo.mode);
         ModuleManager.showAppModule("PetNoPoultryWaitMatePanel",_pvpInfo);
      }
      
      private static function removeApplyCmd() : void
      {
         ModuleManager.closeForName("PetNoPoultryWaitMatePanel");
         Connection.removeCommandListener(CommandSet.DOOR_FIGHT_MATCH_CANCEL_1080,onPvpError);
         Connection.removeCommandListener(CommandSet.DOOR_FIGHT_MATCH_END_1082,matchSuccess);
         Connection.removeErrorHandler(CommandSet.DOOR_FIGHT_MATCH_END_1082,onPvpError);
         Connection.removeErrorHandler(CommandSet.DOOR_FIGHT_MATCH_1079,onPvpError);
      }
      
      private static function onPvpError(param1:MessageEvent) : void
      {
         removeApplyCmd();
         ModuleManager.closeForName("PetNoPoultryWaitMatePanel");
         if(param1.message.statusCode == 0)
         {
            return;
         }
         ErrorMap.parseStatusCode(param1.message.statusCode);
      }
      
      private static function matchSuccess(param1:MessageEvent) : void
      {
         var data:IDataInput;
         var userInfoCount:uint;
         var remotePetList:Vector.<PetInfo>;
         var thisInfo:UserInfo;
         var remoteInfo:UserInfo;
         var i:int;
         var obj:*;
         var thisPetList:Vector.<PetInfo> = null;
         var remoteId:uint = 0;
         var id:uint = 0;
         var trainerIntegral:uint = 0;
         var petInfoCount:uint = 0;
         var j:int = 0;
         var meleeCount:uint = 0;
         var k:int = 0;
         var petInfo:PetInfo = null;
         var equipItem:EquipItem = null;
         var petID:uint = 0;
         var petLevel:uint = 0;
         var petTime:uint = 0;
         var thisEquipCount:uint = 0;
         var m:int = 0;
         var remoteEquipCount:uint = 0;
         var n:int = 0;
         var message:MessageEvent = param1;
         removeApplyCmd();
         data = message.message.getRawData();
         userInfoCount = uint(data.readUnsignedInt());
         thisPetList = Vector.<PetInfo>([]);
         remotePetList = Vector.<PetInfo>([]);
         thisInfo = new UserInfo();
         remoteInfo = new UserInfo();
         i = 0;
         while(i < userInfoCount)
         {
            id = uint(data.readUnsignedInt());
            trainerIntegral = uint(data.readUnsignedInt());
            petInfoCount = uint(data.readUnsignedInt());
            if(id != ActorManager.actorInfo.id)
            {
               remoteId = id;
            }
            j = 0;
            while(j < petInfoCount)
            {
               petID = uint(data.readUnsignedInt());
               petLevel = uint(data.readUnsignedInt());
               petTime = uint(data.readUnsignedInt());
               petInfo = new PetInfo();
               petInfo.resourceId = petID;
               petInfo.catchTime = petTime;
               if(id == ActorManager.actorInfo.id)
               {
                  thisPetList.push(petInfo);
               }
               else
               {
                  remotePetList.push(petInfo);
               }
               j++;
            }
            if(id == ActorManager.actorInfo.id)
            {
               thisInfo.id = data.readUnsignedInt();
               thisInfo.sex = data.readUnsignedByte();
               thisInfo.nick = data.readUTFBytes(UserInfo.NICK_DATA_LEN);
               thisInfo.color = data.readUnsignedInt();
               thisInfo.trainerScore = data.readUnsignedInt();
               thisInfo.equipVec = new Vector.<EquipItem>();
               thisEquipCount = uint(data.readUnsignedInt());
               m = 0;
               while(m < thisEquipCount)
               {
                  equipItem = new EquipItem(data.readUnsignedInt());
                  thisInfo.equipVec.push(equipItem);
                  m++;
               }
            }
            else
            {
               remoteInfo.id = data.readUnsignedInt();
               remoteInfo.sex = data.readUnsignedByte();
               remoteInfo.nick = data.readUTFBytes(UserInfo.NICK_DATA_LEN);
               remoteInfo.color = data.readUnsignedInt();
               remoteInfo.trainerScore = data.readUnsignedInt();
               remoteInfo.equipVec = new Vector.<EquipItem>();
               remoteEquipCount = uint(data.readUnsignedInt());
               n = 0;
               while(n < remoteEquipCount)
               {
                  equipItem = new EquipItem(data.readUnsignedInt());
                  remoteInfo.equipVec.push(equipItem);
                  n++;
               }
               ActorEquipAssembler.mergeDefaultEquip(remoteInfo.color,remoteInfo.equipVec);
            }
            meleeCount = uint(data.readUnsignedInt());
            k = 0;
            while(k < meleeCount)
            {
               data.readUnsignedInt();
               k++;
            }
            i++;
         }
         _remoteInfo = remoteInfo;
         _thisPetList = thisPetList;
         _remotePetList = remotePetList;
         FightManager.addEventListener(FightStartEvent.FIGHT_LOADING_START,onFightLoadStart);
         obj = {};
         obj.remotePetList = remotePetList;
         obj.thisPetList = thisPetList;
         obj.callBack = function(param1:int):void
         {
            var _loc2_:* = thisPetList[param1];
            thisPetList[param1] = thisPetList[0];
            thisPetList[0] = _loc2_;
            _pvpInfo.petList = new Vector.<uint>();
            var _loc3_:int = 0;
            while(_loc3_ < thisPetList.length)
            {
               _pvpInfo.petList[_loc3_] = thisPetList[_loc3_].catchTime;
               _loc3_++;
            }
            startFight();
         };
         ModuleManager.showAppModule("YufengPvpPetSelectPanel",obj);
      }
      
      private static function onFightLoadStart(param1:FightStartEvent) : void
      {
         ModuleManager.closeForName("YufengPvpPetSelectPanel");
         FightManager.removeEventListener(FightStartEvent.FIGHT_LOADING_START,onFightLoadStart);
      }
      
      private static function onShowMyTeam() : void
      {
         var _loc2_:MovieClip = null;
         LayerManager.hideMap();
         _thisPreview.x = 260;
         _thisPreview.y = 440;
         LayerManager.topLayer.addChild(_thisPreview);
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            _thisIconList[_loc1_].x = _thisIconList[_loc1_].y = 0;
            _loc2_ = _mc["myIconList" + _loc1_]["iconMc"]["icon"];
            DisplayObjectUtil.removeAllChildren(_loc2_);
            if(_thisIconList[_loc1_])
            {
               _loc2_.addChild(_thisIconList[_loc1_]);
            }
            MovieClip(_mc["enIconList" + _loc1_]).gotoAndStop(2);
            _loc1_++;
         }
      }
      
      private static function onShowEnemyTeam() : void
      {
         var _loc2_:MovieClip = null;
         _remotePreview.x = 950;
         _remotePreview.y = 440;
         LayerManager.topLayer.addChild(_remotePreview);
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            MovieClip(_mc["enIconList" + _loc1_]).gotoAndStop(1);
            _remoteIconList[_loc1_].x = _remoteIconList[_loc1_].y = 0;
            _loc2_ = _mc["enIconList" + _loc1_]["iconMc"]["icon"];
            DisplayObjectUtil.removeAllChildren(_loc2_);
            if(_remoteIconList[_loc1_])
            {
               _loc2_.addChild(_remoteIconList[_loc1_]);
            }
            _loc1_++;
         }
      }
      
      private static function onFightGetRevenue(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.FIGHT_GET_REVENUE_5,onFightGetRevenue);
         Connection.removeCommandListener(CommandSet.FIGHT_TURN_START_2,onFightLoadEnd);
         clearMC();
      }
      
      private static function onFightLoadEnd(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.FIGHT_GET_REVENUE_5,onFightGetRevenue);
         Connection.removeCommandListener(CommandSet.FIGHT_TURN_START_2,onFightLoadEnd);
         clearMC();
      }
      
      private static function clearMC() : void
      {
         var _loc1_:IconDisplayer = null;
         if(_mc)
         {
            _mc["loading"].stop();
            _mc["loading"].removeEventListener(Event.ENTER_FRAME,onFullScreenEnter);
            DisplayUtil.removeForParent(_thisPreview);
            DisplayUtil.removeForParent(_remotePreview);
            for each(_loc1_ in _thisIconList)
            {
               DisplayUtil.removeForParent(_loc1_);
            }
            for each(_loc1_ in _remoteIconList)
            {
               DisplayUtil.removeForParent(_loc1_);
            }
            DisplayUtil.removeForParent(_mc);
            LayerManager.resetOperation();
            LayerManager.showMap();
            SoundManager.enabled = true;
         }
      }
      
      private static function onFullScreenEnter(param1:Event) : void
      {
         var event:Event = param1;
         if(_mc["loading"].currentFrame == 45)
         {
            onShowEnemyTeam();
         }
         if(_mc["loading"].currentFrame >= _mc["loading"].totalFrames)
         {
            _mc["loading"].stop();
            _mc["loading"].removeEventListener(Event.ENTER_FRAME,onFullScreenEnter);
            MovieClip(_mc["vs"]).gotoAndStop(1);
            _mc["loading"].visible = false;
            _mc["vs"].visible = true;
            MovieClipUtil.playMc(MovieClip(_mc["vs"]),2,MovieClip(_mc["vs"]).totalFrames,function():void
            {
               MovieClip(_mc["vs"]).gotoAndStop(MovieClip(_mc["vs"]).totalFrames);
            });
         }
      }
      
      private static function startFight() : void
      {
         var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
         _loc1_.writeUnsignedInt(_pvpInfo.gate);
         var _loc2_:Array = new Array();
         var _loc3_:uint = _pvpInfo.petList.length;
         _loc1_.writeUnsignedInt(_loc3_);
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_.push(_pvpInfo.petList[_loc4_]);
            _loc1_.writeUnsignedInt(_pvpInfo.petList[_loc4_]);
            _loc4_++;
         }
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onSwitchComplete);
         FightManager.addEventListener(FightStartEvent.FIGHT_LOADING_START,onFightLoadStart);
         FightManager.startFightPVP(_loc1_);
      }
      
      private static function onSwitchComplete(param1:SceneEvent) : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,onSwitchComplete);
            if(_endFightFun != null)
            {
               _endFightFun();
            }
         }
      }
   }
}
