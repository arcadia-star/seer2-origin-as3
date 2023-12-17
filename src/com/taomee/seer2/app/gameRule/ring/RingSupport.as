package com.taomee.seer2.app.gameRule.ring
{
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.RemoteActor;
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.arena.util.FightMode;
   import com.taomee.seer2.app.chat.events.PublicChatEvent;
   import com.taomee.seer2.app.gameRule.core.ISupportable;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.helper.UserInfoParseHelper;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.DateUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.Timer;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import org.taomee.manager.EventManager;
   
   public class RingSupport implements ISupportable
   {
      
      private static const RING_LOCATION:Point = new Point(480,160);
      
      private static var _instance:RingSupport;
       
      
      private var _countdownTimer:Timer;
      
      private var _countdownbool:Boolean;
      
      private var _countdownNum:uint;
      
      private var _map:MapModel;
      
      private var _ringTable:MovieClip;
      
      private var _ringer_talk:MovieClip;
      
      private var _ringActor:RemoteActor;
      
      private var _ringerId:uint = 0;
      
      private var _ringAtkId:uint = 0;
      
      private var _talkTimeOutID:uint = 0;
      
      private var _oldRingerId:uint = 0;
      
      private var _win_counter:uint = 0;
      
      private var _ringerReadyFight:Boolean = true;
      
      private var _sayarr:Array;
      
      private var ringerTalkTxt:TextField;
      
      public function RingSupport()
      {
         super();
      }
      
      public static function getInstance() : RingSupport
      {
         if(_instance == null)
         {
            _instance = new RingSupport();
         }
         return _instance;
      }
      
      public function init(param1:MapModel) : void
      {
         this._map = param1;
         this._sayarr = ["哈哈！真是不堪一击！","哎呀！赢了？运气真好！","谁能招架住我一招半式！","独孤求败中…","星际第一勇士正是在下！"];
         this._ringTable = this._map.content["ringTable"];
         this._ringer_talk = this._map.front["UI_ringer_talk"];
         this._ringer_talk.visible = false;
         this._ringTable.buttonMode = true;
         this._ringTable.addEventListener(MouseEvent.CLICK,this.onClickRingTable);
         TooltipManager.addCommonTip(this._ringTable,"点击进入无禽战");
         this._map.ground.addEventListener(MouseEvent.CLICK,this.onGroundClick);
         Connection.addCommandListener(CommandSet.FIGHT_RING_INFO_1104,this.onUpdateRingInfo);
         Connection.addCommandListener(CommandSet.LIST_USER_1004,this.onListUsers);
         Connection.addCommandListener(CommandSet.CLIENT_BROADCAST_DATA_1105,this.onUpdateReadyFight);
         EventManager.addEventListener(PublicChatEvent.MESSAGE,this.onMessage);
      }
      
      public function onMessage(param1:PublicChatEvent) : void
      {
         if(param1.message.senderId == this._ringerId)
         {
            this.ringerTalk(param1.message.message);
         }
      }
      
      public function ringerAutoTalk(param1:uint) : void
      {
         var _loc2_:uint = uint(Math.random() * 5);
         if(param1 != 0 && param1 % 10 == 0)
         {
            this.ringerTalk(this._sayarr[_loc2_]);
         }
      }
      
      public function ringerTalk(param1:String) : void
      {
         if(!this.ringerTalkTxt)
         {
            this.ringerTalkTxt = new TextField();
            this.ringerTalkTxt.width = 120;
            this.ringerTalkTxt.height = 100;
            this.ringerTalkTxt.multiline = true;
            this.ringerTalkTxt.wordWrap = true;
            this.ringerTalkTxt.textColor = 16777215;
         }
         this.ringerTalkTxt.text = param1;
         this._ringer_talk.addChild(this.ringerTalkTxt);
         this._ringer_talk.bg.height = this.ringerTalkTxt.numLines * 14 + 55;
         this._ringer_talk.visible = true;
         clearTimeout(this._talkTimeOutID);
         this._talkTimeOutID = setTimeout(this.hideTalk,5000);
      }
      
      public function hideTalk() : void
      {
         this._ringer_talk.visible = false;
      }
      
      public function dispose() : void
      {
         EventManager.removeEventListener(PublicChatEvent.MESSAGE,this.onMessage);
         clearTimeout(this._talkTimeOutID);
         this.countdownOver();
         this._map.ground.removeEventListener(MouseEvent.CLICK,this.onGroundClick);
         this._ringTable.removeEventListener(MouseEvent.CLICK,this.onClickRingTable);
         this.removeOldRingerActor();
         Connection.removeCommandListener(CommandSet.FIGHT_RING_INFO_1104,this.onUpdateRingInfo);
         Connection.removeCommandListener(CommandSet.CLIENT_BROADCAST_DATA_1105,this.onUpdateReadyFight);
         Connection.removeCommandListener(CommandSet.USER_GET_SIMPLE_INFO_1028,this.onGetUserSimpleInfo);
         this._win_counter = 0;
         this._map = null;
         this._ringTable = null;
         this._ringerReadyFight = true;
      }
      
      public function onEnterMapUpdate() : void
      {
         if(this._ringerId != 0)
         {
            this.showOldRinger();
            this.hideRinger();
            if(this.isRinger())
            {
               Connection.send(CommandSet.CLIENT_BROADCAST_DATA_1105,1);
            }
         }
      }
      
      private function onUpdateReadyFight(param1:MessageEvent) : void
      {
         var _loc2_:IDataInput = param1.message.getRawData();
         if(_loc2_.readUnsignedInt() == this._ringerId && _loc2_.readUnsignedInt() == 1)
         {
            this._ringerReadyFight = true;
         }
         this.updateRingStatus();
      }
      
      public function isRinger() : Boolean
      {
         return ActorManager.actorInfo.id == this._ringerId;
      }
      
      public function checkChangeable() : Boolean
      {
         if(ActorManager.actorInfo.id == this._ringerId)
         {
            AlertManager.showAlert("必须先离开擂台!");
            return false;
         }
         return true;
      }
      
      private function updateRingStatus() : void
      {
         if(this._countdownbool)
         {
            return;
         }
         if(this._ringerId != 0 && this._ringAtkId == 0 && this._ringerReadyFight || this._ringerId == 0)
         {
         }
      }
      
      private function requestRinger(param1:uint, param2:Boolean = false) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:LittleEndianByteArray = null;
         if(this.checkTime() && this.checkBattery())
         {
            _loc3_ = param2 ? 2 : 1;
            (_loc4_ = new LittleEndianByteArray()).writeInt(param1);
            _loc4_.writeInt(FightMode.FIGHT_RING);
            _loc4_.writeByte(_loc3_);
            _loc4_.position = 0;
            Connection.send(CommandSet.FIGHE_PLAYER_INVITE_1503,_loc4_);
         }
      }
      
      private function updateRingerDisplay() : void
      {
         this.showOldRinger();
         this.hideRinger();
         if(this._ringerId != 0)
         {
            Connection.addCommandListener(CommandSet.USER_GET_SIMPLE_INFO_1028,this.onGetUserSimpleInfo);
            Connection.send(CommandSet.USER_GET_SIMPLE_INFO_1028,this._ringerId);
         }
         else
         {
            this.removeOldRingerActor();
         }
      }
      
      private function onGetUserSimpleInfo(param1:MessageEvent) : void
      {
         var _loc4_:UserInfo = null;
         var _loc2_:ByteArray = param1.message.getRawData();
         _loc2_.position = 0;
         var _loc3_:uint = _loc2_.readUnsignedInt();
         if(_loc3_ == this._ringerId)
         {
            Connection.removeCommandListener(CommandSet.USER_GET_SIMPLE_INFO_1028,this.onGetUserSimpleInfo);
            (_loc4_ = new UserInfo()).id = _loc3_;
            UserInfoParseHelper.readSimpleInfo(_loc4_,_loc2_);
            this.removeOldRingerActor();
            this._ringActor = ActorManager.addOtherActor(_loc4_);
            this._ringActor.x = RING_LOCATION.x;
            this._ringActor.y = RING_LOCATION.y;
            TooltipManager.addCommonTip(this._ringActor,"擂主:" + _loc4_.nick);
            this._map.content.addChild(this._ringActor);
         }
      }
      
      private function onClickRingTable(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("NoPoultryBattleFieldMainPanel");
      }
      
      private function onApplyFight(param1:MouseEvent) : void
      {
         if(this._ringerId != 0 && this._ringAtkId == 0)
         {
            if(this._ringerReadyFight)
            {
               if(this.checkTime() && this.checkBattery())
               {
                  Connection.send(CommandSet.FIGHE_PLAYER_ACCEPT_1504,this._ringerId,1);
               }
            }
            else
            {
               AlertManager.showAlert("等待擂主准备!");
            }
         }
         else
         {
            AlertManager.showAlert("当前擂主正在战斗中!");
         }
      }
      
      private function onGroundClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         if(ActorManager.actorInfo.id == this._ringerId)
         {
            if(this._ringerId != 0 && this._ringAtkId == 0)
            {
               AlertManager.showConfirm("你确定要离开擂台吗？",function():void
               {
                  if(_ringerId != 0 && _ringAtkId == 0)
                  {
                     Connection.send(CommandSet.FIGHE_PLAYER_CANCEL_1505);
                  }
                  else
                  {
                     AlertManager.showAutoCloseAlert("战斗已经开始!",3);
                  }
               });
            }
            evt.stopImmediatePropagation();
         }
      }
      
      private function onListUsers(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.LIST_USER_1004,this.onListUsers);
         Connection.send(CommandSet.FIGHT_RING_INFO_1104);
         this.showOldRinger();
         this.hideRinger();
      }
      
      private function getActor(param1:uint) : Actor
      {
         var _loc2_:Actor = null;
         if(param1 != ActorManager.actorInfo.id)
         {
            _loc2_ = ActorManager.getRemoteActor(param1);
         }
         else
         {
            _loc2_ = ActorManager.getActor();
         }
         return _loc2_;
      }
      
      private function removeOldRingerActor() : void
      {
         if(this._ringActor != null)
         {
            if(this._map.content.contains(this._ringActor))
            {
               this._map.content.removeChild(this._ringActor);
            }
            TooltipManager.remove(this._ringActor);
            ActorManager.removeOtherActor(this._ringActor.getInfo().id);
            this._ringActor = null;
         }
      }
      
      private function showOldRinger() : void
      {
         var _loc1_:Actor = null;
         if(this._oldRingerId != 0)
         {
            _loc1_ = this.getActor(this._oldRingerId);
            if(_loc1_ != null)
            {
               _loc1_.show();
            }
            this._oldRingerId = 0;
         }
      }
      
      private function hideRinger() : void
      {
         var _loc1_:Actor = this.getActor(this._ringerId);
         if(_loc1_ != null && _loc1_.isShow)
         {
            _loc1_.hide();
         }
      }
      
      private function onUpdateRingInfo(param1:MessageEvent) : void
      {
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         if(_loc3_ != this._ringerId)
         {
            this._oldRingerId = this._ringerId;
            this._ringerId = _loc3_;
            if(this._ringerId == 0)
            {
               this._ringerReadyFight = true;
            }
         }
         this._ringAtkId = _loc2_.readUnsignedInt();
         this._win_counter = _loc2_.readUnsignedInt();
         var _loc4_:uint = uint(_loc2_.readUnsignedInt());
         if(this._ringerId != 0 && this._ringAtkId != 0)
         {
            this._ringerReadyFight = false;
         }
         var _loc5_:uint = (_loc5_ = this._win_counter) < 0 ? 0 : _loc5_;
         this.ringerAutoTalk(_loc5_);
         if(this._ringerId == 0)
         {
         }
         this.updateRingStatus();
         this.updateRingerDisplay();
         if(_loc4_ > 15 || _loc4_ == 0)
         {
            this.countdownOver();
         }
         else
         {
            this.countdown(_loc4_);
         }
      }
      
      private function countdown(param1:uint) : void
      {
         this.countdownOver();
         this._countdownNum = param1;
         this._countdownbool = true;
         this._countdownTimer = new Timer(1000,this._countdownNum);
         this._countdownTimer.addEventListener(TimerEvent.TIMER,this.countdownEvery);
         this._countdownTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.countdownOver);
         this._countdownTimer.start();
      }
      
      private function countdownEvery(param1:TimerEvent) : void
      {
         this._countdownTimer.currentCount;
      }
      
      private function countdownOver(param1:TimerEvent = null) : void
      {
         if(this._countdownTimer)
         {
            this._countdownbool = false;
            this._countdownTimer.stop();
            this._countdownTimer.removeEventListener(TimerEvent.TIMER,this.countdownEvery);
            this._countdownTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.countdownOver);
            this._countdownTimer = null;
         }
      }
      
      private function checkTime() : Boolean
      {
         if(DateUtil.isDay(2011,9,23))
         {
            return true;
         }
         var _loc1_:Boolean = Boolean(DateUtil.isInHourScope(6,23,0,59));
         if(!_loc1_)
         {
            AlertManager.showAlert("激战擂台开放时间 6:00-24:00");
         }
         return _loc1_;
      }
      
      private function checkBattery() : Boolean
      {
         var _loc1_:* = TimeManager.getAvailableTime() > 0;
         if(!_loc1_)
         {
            AlertManager.showAlert("电池耗完");
         }
         return _loc1_;
      }
   }
}
