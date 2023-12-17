package com.taomee.seer2.app.popup.alert
{
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.actor.preview.ActorPreview;
   import com.taomee.seer2.app.arena.util.FightMode;
   import com.taomee.seer2.app.common.ResourceLibraryLoader;
   import com.taomee.seer2.app.gameRule.behavior.MultiPetSelectSupport;
   import com.taomee.seer2.app.gameRule.behavior.SOMultiBehavior;
   import com.taomee.seer2.app.gameRule.data.FighterSelectPanelVO;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.helper.UserInfoParseHelper;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertInfo;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   public class InvitedFightAlert extends Sprite implements IAlert
   {
      
      private static const COUNT_DOWN_TIME:uint = 15;
       
      
      private var _timerIndex:int;
      
      private var _intervalIndex:uint = 0;
      
      private var _ui:MovieClip;
      
      private var _cacelButton:SimpleButton;
      
      private var _petLevel:TextField;
      
      private var _trainerLevel:TextField;
      
      private var _oppositeMC:MovieClip;
      
      private var _trainerExpMc:MovieClip;
      
      private var _trainerExpTxt:TextField;
      
      private var _trainerExpBar:MovieClip;
      
      private var _timeTxt:TextField;
      
      private var _inviteType:TextField;
      
      private var _actorPreCantainer:MovieClip;
      
      private var _actorPreview:ActorPreview;
      
      private var _userId:uint;
      
      private var _fightMode:uint;
      
      private var _userInfo:UserInfo;
      
      private var _supportBehavior:MultiPetSelectSupport;
      
      private var _resLoader:ResourceLibraryLoader;
      
      private var _info:AlertInfo;
      
      public function InvitedFightAlert()
      {
         super();
         this._resLoader = new ResourceLibraryLoader(URLUtil.getRes("publicRes/inviteFight" + URLUtil.POSTFIX_SWF));
         this._resLoader.getLib(this.onGetLib);
      }
      
      private function onGetLib(param1:ResourceLibrary) : void
      {
         this._ui = param1.getMovieClip("UI_InvitedSkin");
         addChild(this._ui);
         this._cacelButton = this._ui["noBtn"];
         this._cacelButton.addEventListener(MouseEvent.CLICK,this.cancelHandler);
         this._petLevel = this._ui["petLevel"];
         this._trainerLevel = this._ui["trainerLevel"];
         this._trainerExpMc = this._ui["trainerExpMC"];
         this._trainerExpBar = this._trainerExpMc["trainerExpBar"];
         this._trainerExpTxt = this._trainerExpMc["trainerExpTxt"];
         this._oppositeMC = this._ui["oppositeMC"];
         this._timeTxt = this._ui["timeTxt"];
         this._inviteType = this._ui["fightTxt"];
         this._actorPreCantainer = this._oppositeMC["actorPreCantainer"];
         this._supportBehavior = new MultiPetSelectSupport();
         this._supportBehavior.setUpMainUI(this._ui);
      }
      
      private function updateInfo() : void
      {
         this._petLevel.text = "" + this._userInfo.highestPetLevel;
         this._trainerLevel.text = "" + this._userInfo.trainerLevel;
         this._trainerExpTxt.text = String(this._userInfo.currentLevelExp) + "/" + String(this._userInfo.nextLevelNeedExp);
         this._trainerExpBar.scaleX = this._userInfo.currentLevelExp / this._userInfo.nextLevelNeedExp;
         TextField(this._oppositeMC["userName"]).text = this._userInfo.nick;
         this.addPreview();
      }
      
      private function cancelHandler(param1:MouseEvent) : void
      {
         var _loc2_:LittleEndianByteArray = new LittleEndianByteArray();
         _loc2_.writeUnsignedInt(this._userId);
         _loc2_.writeUnsignedInt(0);
         _loc2_.writeUnsignedInt(0);
         Connection.send(CommandSet.FIGHT_ACCEPT_PVP_1513,_loc2_);
         this.stopInterval();
         this.dispose();
         param1.stopImmediatePropagation();
      }
      
      public function show(param1:AlertInfo) : void
      {
         this._info = param1;
         this._resLoader = new ResourceLibraryLoader(URLUtil.getRes("publicRes/inviteFight" + URLUtil.POSTFIX_SWF));
         this._resLoader.getLib(this.onGetLib_1);
      }
      
      private function onGetLib_1(param1:ResourceLibrary) : void
      {
         this.onGetLib(param1);
         this.showPanel();
      }
      
      private function showPanel() : void
      {
         var initData:FighterSelectPanelVO;
         var confirmHandler:Function = null;
         confirmHandler = function(param1:Vector.<uint>):void
         {
            var _loc5_:uint = 0;
            var _loc6_:String = null;
            var _loc2_:LittleEndianByteArray = new LittleEndianByteArray();
            _loc2_.writeUnsignedInt(_userId);
            _loc2_.writeUnsignedInt(1);
            _loc2_.writeUnsignedInt(param1.length);
            var _loc3_:uint = 0;
            while(_loc3_ < param1.length)
            {
               _loc2_.writeUnsignedInt(param1[_loc3_]);
               _loc3_++;
            }
            Connection.send(CommandSet.FIGHT_ACCEPT_PVP_1513,_loc2_);
            var _loc4_:Array = new Array();
            for each(_loc5_ in param1)
            {
               _loc4_.push(_loc5_);
            }
            _loc6_ = SOMultiBehavior.getKey(_fightMode);
            SOMultiBehavior.writeDefaultPets(_loc6_,_loc4_);
            stopInterval();
            dispose();
         };
         this._userId = this._info.initInfo.userId;
         this._fightMode = this._info.initInfo.mode;
         AlertManager.addPopUp(this._info,this);
         this.requestUserInfo();
         this._intervalIndex = 0;
         this._timerIndex = setInterval(this.intervalHandler,1000);
         initData = new FighterSelectPanelVO();
         initData.defaultPets = this.getDefaultPets(this._fightMode,PetInfoManager.getAllBagPetInfo());
         initData.pets = PetInfoManager.getAllBagPetInfo();
         if(this._fightMode == FightMode.FIGHT_PVP_INVITE_1V1)
         {
            this._inviteType.text = "邀请你单只精灵对战";
            initData.minSelectedPetCount = 1;
            initData.maxSelectedPetCount = 1;
         }
         else if(this._fightMode == FightMode.FIGHT_PVP_INVITE_NVN)
         {
            this._inviteType.text = "邀请你多只精灵对战";
            initData.minSelectedPetCount = 1;
            initData.maxSelectedPetCount = 6;
            initData.selectable = false;
         }
         else if(this._fightMode == FightMode.FIGHT_PVP_INVITE_2V2)
         {
            this._inviteType.text = "邀请你双精灵对战";
            initData.minSelectedPetCount = 2;
            initData.maxSelectedPetCount = 2;
            if(initData.pets.length < 2)
            {
               AlertManager.showAlert("您背包中的精灵少于2只！");
               return;
            }
         }
         initData.onComplete = confirmHandler;
         this._supportBehavior.init(initData);
         this._timeTxt.visible = true;
      }
      
      private function getDefaultPets(param1:uint, param2:Vector.<PetInfo>) : Vector.<PetInfo>
      {
         var _loc6_:uint = 0;
         var _loc7_:Array = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:Vector.<PetInfo> = new Vector.<PetInfo>();
         var _loc4_:String = SOMultiBehavior.getKey(param1);
         var _loc5_:Array = SOMultiBehavior.readDefaultPets(_loc4_);
         if(param1 == FightMode.FIGHT_PVP_INVITE_NVN)
         {
            _loc3_ = PetInfoManager.getAllBagPetInfo();
         }
         else
         {
            if(_loc5_ != null)
            {
               _loc9_ = param2.length;
               while(_loc10_ < _loc9_)
               {
                  if(_loc5_.indexOf(param2[_loc10_].catchTime) != -1)
                  {
                     _loc3_.push(param2[_loc10_]);
                  }
                  _loc10_++;
               }
            }
            if(_loc3_.length == 0)
            {
               if(param1 == FightMode.FIGHT_PVP_INVITE_1V1)
               {
                  _loc3_ = Vector.<PetInfo>([PetInfoManager.getFirstPetInfo()]);
               }
               else if(param1 == FightMode.FIGHT_PVP_INVITE_2V2)
               {
                  _loc3_ = PetInfoManager.getRandomFightPetInfo(2);
               }
            }
            _loc6_ = _loc3_.length;
            _loc7_ = new Array();
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
               _loc7_.push(_loc3_[_loc8_].catchTime);
               _loc8_++;
            }
            SOMultiBehavior.writeDefaultPets(_loc4_,_loc7_);
         }
         return _loc3_;
      }
      
      private function stopInterval() : void
      {
         if(this._timerIndex != 0)
         {
            clearInterval(this._timerIndex);
            this._timerIndex = 0;
         }
      }
      
      private function intervalHandler() : void
      {
         var _loc1_:LittleEndianByteArray = null;
         ++this._intervalIndex;
         this._timeTxt.text = String(COUNT_DOWN_TIME - this._intervalIndex);
         if(this._intervalIndex >= COUNT_DOWN_TIME)
         {
            this.stopInterval();
            this._timerIndex = 0;
            _loc1_ = new LittleEndianByteArray();
            _loc1_.writeUnsignedInt(this._userId);
            _loc1_.writeUnsignedInt(0);
            _loc1_.writeUnsignedInt(0);
            Connection.send(CommandSet.FIGHT_ACCEPT_PVP_1513,_loc1_);
            this.dispose();
         }
      }
      
      private function addPreview() : void
      {
         this._actorPreview = new ActorPreview();
         this._actorPreview.setData(this._userInfo);
         this._actorPreview.scaleX = this._actorPreview.scaleY = 0.5;
         this._actorPreview.x = 30;
         this._actorPreview.y = 70;
         this._actorPreCantainer.addChild(this._actorPreview);
      }
      
      public function dispose() : void
      {
         this._resLoader.dispose();
         if(this._supportBehavior != null)
         {
            this._supportBehavior.dispose();
            this._supportBehavior = null;
         }
         if(this._actorPreview != null)
         {
            this._actorPreview.dispose();
         }
         this._ui = null;
         this._actorPreCantainer = null;
         AlertManager.removePopUp(this);
         LayerManager.resetOperation();
         this.dispatchEvent(new Event(Event.CLOSE));
      }
      
      private function requestUserInfo() : void
      {
         Connection.addCommandListener(CommandSet.USER_GET_DETAIL_INFO_1010,this.onGetDetailInfo);
         Connection.send(CommandSet.USER_GET_DETAIL_INFO_1010,this._userId);
      }
      
      private function onGetDetailInfo(param1:MessageEvent) : void
      {
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         if(_loc3_ == this._userId)
         {
            Connection.removeCommandListener(CommandSet.USER_GET_DETAIL_INFO_1010,this.onGetDetailInfo);
            ByteArray(_loc2_).position = 0;
            this._userInfo = new UserInfo();
            UserInfoParseHelper.parseUserDetailInfo(this._userInfo,_loc2_);
            this.updateInfo();
         }
      }
   }
}
