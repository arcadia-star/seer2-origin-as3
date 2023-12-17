package com.taomee.seer2.app.processor.map
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.RemoteActor;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.event.LogicEvent;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.morphSystem.MorphManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.ModelLocator;
   import com.taomee.seer2.core.utils.DateUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import org.taomee.utils.Tick;
   
   public class MapProcessor_3845 extends MapProcessor
   {
      
      private static const FOR_LIST:Array = [250200];
      
      private static const DAY_LIST:Array = [5086,5087,5088];
      
      private static const CHANGE_ID:Vector.<int> = Vector.<int>([5000,5001]);
      
      private static const GAME_RULE:Vector.<int> = Vector.<int>([30]);
      
      private static const PUBLIC_KEY:int = 126;
      
      private static const TEAM_POS:Vector.<Point> = Vector.<Point>([new Point(210,425),new Point(992,425)]);
      
      private static var _curFightType:int;
      
      private static var _pkSysList:Vector.<String> = Vector.<String>([]);
      
      private static var _isAddBroadCast:Boolean = false;
       
      
      private var _barList:Vector.<MovieClip>;
      
      private var _leftTime:TextField;
      
      private var _pkInfo:TextField;
      
      private var _leaveBtn:SimpleButton;
      
      private var _scroeNumList:Vector.<TextField>;
      
      private var _par:Parser_1142;
      
      private var _info:DayLimitListInfo;
      
      private var _leaveTime:int;
      
      private var _isFlow:Boolean = false;
      
      public function MapProcessor_3845(param1:MapModel)
      {
         super(param1);
      }
      
      public static function get curFightType() : int
      {
         return _curFightType;
      }
      
      private static function addBoradCast() : void
      {
         if(!_isAddBroadCast)
         {
            _isAddBroadCast = true;
            Connection.addCommandListener(CommandSet.FROZEN_ACTIVITY_TYPE_1151,onBroadCast);
         }
      }
      
      private static function onBroadCast(param1:MessageEvent) : void
      {
         var _loc7_:int = 0;
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:uint = uint(_loc2_.readUnsignedInt());
         var _loc6_:int;
         var _loc5_:Array;
         if((_loc6_ = ((_loc5_ = [[3000,3002],[3001,3003]])[_curFightType] as Array).indexOf(_loc3_)) == -1)
         {
            return;
         }
         var _loc8_:Vector.<int> = Vector.<int>([]);
         _loc7_ = 0;
         while(_loc7_ < _loc4_)
         {
            _loc8_.push(_loc2_.readUnsignedInt());
            _loc7_++;
         }
         if(_pkSysList.length >= 5)
         {
            _pkSysList.shift();
         }
         if(_loc6_ == 0)
         {
            _pkSysList.push(_loc8_[0] + "连胜了" + _loc8_[1] + "场!");
         }
         else
         {
            _pkSysList.push(_loc8_[1] + "终结了" + _loc8_[0] + "玩家的" + _loc8_[2] + "连胜!");
         }
         ModelLocator.getInstance().dispatchEvent(new LogicEvent(LogicEvent.GOD_FIRE_PK_BROAD_CAST));
      }
      
      override public function init() : void
      {
         this.godFirePkAct();
      }
      
      private function godFirePkAct() : void
      {
         if(!this.isInAct())
         {
            ServerMessager.addMessage("当前活动时间已结束!");
            TweenNano.delayedCall(2,function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,70);
            });
         }
         _curFightType = !!DateUtil.isInHourScope(19,19,0,30) ? 1 : 0;
         this.initSet();
         this.initEvent();
         this.addListener();
         this.update(function():void
         {
            setInitPosByTeam(ActorManager.getActor(),_par.infoVec[0]);
            if(_info.getCount(DAY_LIST[0]) >= GAME_RULE[0])
            {
               ServerMessager.addMessage("挑战次数已用完!");
               TweenNano.delayedCall(2,function():void
               {
                  SceneManager.changeScene(SceneType.LOBBY,70);
               });
            }
            if(SceneManager.prevSceneType == SceneType.ARENA)
            {
               ServerMessager.addMessage("目前连胜" + _info.getCount(DAY_LIST[_curFightType + 1]) + "次!");
            }
            updateInfoShow();
            _isFlow = false;
            showOrHide(ActorManager.getActor(),false);
            changeHandle(ActorManager.getActor(),_par.infoVec[0]);
            pkValHandle();
            ActorManager.actorInfo.clientCacheData[1] = _curFightType;
         });
      }
      
      private function initSet() : void
      {
         var i:int;
         this._barList = new Vector.<MovieClip>();
         this._pkInfo = _map.front["pkInfo"];
         this._scroeNumList = new Vector.<TextField>();
         i = 0;
         while(i < 2)
         {
            this._barList.push(_map.front["bar" + i]);
            this._scroeNumList.push(_map.front["scroeNum" + i]);
            i++;
         }
         this._leftTime = _map.front["leftTime"];
         this._leaveBtn = _map.front["leaveBtn"];
         this.getCurLeftTime();
         if(this._leaveTime <= 0)
         {
            ServerMessager.addMessage("当前活动时间已结束!");
            TweenNano.delayedCall(2,function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,70);
            });
         }
         else
         {
            this._leftTime.text = DateUtil.getMS(this._leaveTime);
            Tick.instance.addRender(this.onTimeUpdate,1000);
         }
         addBoradCast();
         this.hideLobbyMenu();
      }
      
      private function hideLobbyMenu() : void
      {
         (SceneManager.active as LobbyScene).hideToolbar();
         PetAvatarPanel.show();
      }
      
      private function setInitPosByTeam(param1:Actor, param2:int) : void
      {
         if(param2 == 0)
         {
            return;
         }
         param1.x = TEAM_POS[param2 - 1].x;
         param1.y = TEAM_POS[param2 - 1].y;
      }
      
      private function pkValHandle() : void
      {
         var dateStr:String = null;
         var curDate:Date = new Date(TimeManager.getServerTime() * 1000);
         dateStr = curDate.fullYear.toString() + (curDate.month + 1 >= 10 ? (curDate.month + 1).toString() : "0" + (curDate.month + 1).toString()).toString() + (curDate.date >= 10 ? curDate.date.toString() : "0" + curDate.date.toString()).toString();
         Connection.send(CommandSet.GET_TOTAL_VOTE_INFO_1219,PUBLIC_KEY,int(dateStr) * 10 + 1,int(dateStr) * 10 + 4);
         Connection.addCommandListener(CommandSet.GET_TOTAL_VOTE_INFO_1219,function getCallState(param1:MessageEvent):void
         {
            var _loc9_:uint = 0;
            var _loc10_:uint = 0;
            Connection.removeCommandListener(CommandSet.GET_TOTAL_VOTE_INFO_1219,getCallState);
            var _loc2_:IDataInput = param1.message.getRawData();
            var _loc3_:uint = uint(_loc2_.readUnsignedInt());
            var _loc4_:uint = uint(_loc2_.readUnsignedInt());
            var _loc5_:Vector.<uint> = Vector.<uint>([int(dateStr) * 10 + 1,int(dateStr) * 10 + 2,int(dateStr) * 10 + 3,int(dateStr) * 10 + 4]);
            var _loc6_:Array = [0,0,0,0];
            var _loc7_:int = 0;
            while(_loc7_ < _loc4_)
            {
               _loc9_ = uint(_loc2_.readUnsignedInt());
               _loc10_ = uint(_loc2_.readUnsignedInt());
               if(_loc5_.indexOf(_loc9_) != -1)
               {
                  _loc6_[_loc5_.indexOf(_loc9_)] = _loc10_;
               }
               _loc7_++;
            }
            var _loc8_:Array = [];
            if(_curFightType == 0)
            {
               _loc8_.push(_loc6_[0]);
               _loc8_.push(_loc6_[1]);
            }
            else
            {
               _loc8_.push(_loc6_[2]);
               _loc8_.push(_loc6_[3]);
            }
            if(_loc8_[0] == _loc8_[1])
            {
               _barList[0].scaleX = 0.5;
            }
            else
            {
               _barList[0].scaleX = _loc8_[0] / (_loc8_[0] + _loc8_[1]);
            }
            _scroeNumList[0].text = _loc8_[0].toString();
            _scroeNumList[1].text = _loc8_[1].toString();
         });
      }
      
      private function onTimeUpdate(param1:int) : void
      {
         var val:int = param1;
         --this._leaveTime;
         this._leftTime.text = DateUtil.getMS(this._leaveTime);
         if(this._leaveTime <= 0)
         {
            Tick.instance.removeRender(this.onTimeUpdate);
            ServerMessager.addMessage("当前活动时间已结束!");
            TweenNano.delayedCall(2,function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,70);
            });
         }
      }
      
      private function getCurLeftTime() : void
      {
         var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
         var _loc2_:Array = [[13,30],[19,30]];
         var _loc3_:Date = new Date(_loc1_.fullYear,_loc1_.month,_loc1_.date,_loc2_[_curFightType][0],_loc2_[_curFightType][1]);
         this._leaveTime = int((_loc3_.getTime() - _loc1_.getTime()) / 1000);
      }
      
      private function initEvent() : void
      {
         this._leaveBtn.addEventListener(MouseEvent.CLICK,this.onLeave);
         Tick.instance.addRender(this.onFightNum,300000);
      }
      
      private function onFightNum(param1:int) : void
      {
         var user:RemoteActor = null;
         var val:int = param1;
         var team0Num:int = 0;
         var team1Num:int = 0;
         var userList:Vector.<RemoteActor> = ActorManager.getAllRemoteActors();
         for each(user in userList)
         {
            if(user.getInfo().activityData[17] == 1)
            {
               team0Num += 1;
            }
            if(user.getInfo().activityData[17] == 2)
            {
               team1Num += 1;
            }
         }
         if(ActorManager.getActor().getInfo().activityData[17] == 1)
         {
            team0Num += 1;
         }
         if(ActorManager.getActor().getInfo().activityData[17] == 2)
         {
            team1Num += 1;
         }
         if(team0Num < 5 || team1Num < 5)
         {
            Tick.instance.removeRender(this.onFightNum);
            AlertManager.showAlert("当前服务器挑战人数较少，去别的服务器参加活动吧!",function():void
            {
               Tick.instance.addRender(onFightNum,300000);
            });
         }
      }
      
      private function onSysUpdate(param1:int) : void
      {
         if(_pkSysList.length > 0)
         {
            if(!this._isFlow)
            {
               this._isFlow = true;
               this._pkInfo.text = _pkSysList.shift();
            }
         }
      }
      
      private function tweenShowTarget(param1:DisplayObject, param2:Function = null) : void
      {
         if(param1)
         {
            TweenNano.to(param1,0.5,{
               "alpha":1,
               "onComplete":param2
            });
         }
      }
      
      private function tweenHideTarget(param1:DisplayObject, param2:Function = null) : void
      {
         if(param1)
         {
            TweenNano.to(param1,0.5,{
               "alpha":0,
               "onComplete":param2
            });
         }
      }
      
      private function clearRes() : void
      {
         this._barList = null;
         this._leftTime = null;
         this._pkInfo = null;
         this._scroeNumList = null;
         if(this._leaveBtn)
         {
            this._leaveBtn.removeEventListener(MouseEvent.CLICK,this.onLeave);
            this._leaveBtn = null;
         }
      }
      
      private function onLeave(param1:MouseEvent) : void
      {
         this.showLobbyMenu();
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function showLobbyMenu() : void
      {
         (SceneManager.active as LobbyScene).showToolbar();
      }
      
      private function update(param1:Function = null) : void
      {
         var callBack:Function = param1;
         ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
            {
               _par = par;
               _info = param1;
               if(callBack != null)
               {
                  callBack();
               }
            });
         });
      }
      
      private function addListener() : void
      {
         Connection.addCommandListener(CommandSet.LIST_USER_1004,this.listUsers);
         Connection.addCommandListener(CommandSet.USER_ENTER_MAP_1002,this.addUser);
         ModelLocator.getInstance().addEventListener(LogicEvent.GOD_FIRE_PK_BROAD_CAST,this.onPkModify);
      }
      
      private function onPkModify(param1:LogicEvent) : void
      {
         this.updateInfoShow();
      }
      
      private function updateInfoShow() : void
      {
         this._pkInfo.text = "";
         var _loc1_:int = 0;
         while(_loc1_ < _pkSysList.length)
         {
            this._pkInfo.text = this._pkInfo.text + _pkSysList[_loc1_] + "\n";
            _loc1_++;
         }
      }
      
      private function removeListener() : void
      {
         Connection.addCommandListener(CommandSet.LIST_USER_1004,this.listUsers);
         Connection.addCommandListener(CommandSet.USER_ENTER_MAP_1002,this.addUser);
      }
      
      private function isInAct() : Boolean
      {
         var _loc2_:Date = null;
         var _loc1_:Boolean = false;
         if(DateUtil.isInTime(new Date(2015,4,1),new Date(2015,4,10,23,59,59)))
         {
            _loc2_ = new Date(TimeManager.getPrecisionServerTime() * 1000);
            if([6,0].indexOf(_loc2_.day) != -1)
            {
               if(Boolean(DateUtil.isInHourScope(13,13,0,30)) || Boolean(DateUtil.isInHourScope(19,19,0,30)))
               {
                  _loc1_ = true;
               }
            }
            if(_loc2_.day == 5)
            {
               if(DateUtil.isInHourScope(19,19,0,30))
               {
                  _loc1_ = true;
               }
            }
         }
         return _loc1_;
      }
      
      private function showOrHide(param1:Actor, param2:Boolean) : void
      {
         if(param1.getNono())
         {
            param1.getNono().nonoInfo.isFollowing = param2;
         }
         if(param1.getFollowingPet())
         {
            if(Boolean(param1.getInfo()) && Boolean(param1.getInfo().followingPetInfo))
            {
               param1.getInfo().followingPetInfo.isFollowing = param2;
            }
            param1.blockFollowingPet = !param2;
         }
      }
      
      private function listUsers(param1:MessageEvent) : void
      {
         var _loc3_:RemoteActor = null;
         if(SceneManager.active.mapID != 3845)
         {
            return;
         }
         var _loc2_:Vector.<RemoteActor> = ActorManager.getAllRemoteActors();
         for each(_loc3_ in _loc2_)
         {
            this.changeHandle(_loc3_,_loc3_.getInfo().activityData[17]);
            this.showOrHide(_loc3_,false);
            this.setInitPosByTeam(_loc3_,_loc3_.getInfo().activityData[17]);
         }
      }
      
      public function changeHandle(param1:Actor, param2:int) : void
      {
         if(!param1 || !param2)
         {
            return;
         }
         param1.startTransform(CHANGE_ID[param2 - 1]);
      }
      
      private function addUser(param1:MessageEvent) : void
      {
         var _loc4_:RemoteActor = null;
         if(SceneManager.active.mapID != 3845)
         {
            return;
         }
         var _loc2_:ByteArray = param1.message.getRawDataCopy();
         var _loc3_:int = int(_loc2_.readUnsignedInt());
         if(_loc3_ != ActorManager.actorInfo.id)
         {
            if(_loc4_ = ActorManager.getRemoteActor(_loc3_))
            {
               this.changeHandle(_loc4_,_loc4_.getInfo().activityData[17]);
               this.showOrHide(_loc4_,false);
               this.setInitPosByTeam(_loc4_,_loc4_.getInfo().activityData[17]);
            }
         }
      }
      
      private function godFirePkDispose() : void
      {
         this.clearRes();
         this.showOrHide(ActorManager.getActor(),true);
         this.removeListener();
         MorphManager.removeMorph(ActorManager.getActor());
         Tick.instance.removeRender(this.onTimeUpdate);
         Tick.instance.removeRender(this.onFightNum);
      }
      
      override public function dispose() : void
      {
         this.godFirePkDispose();
         super.dispose();
      }
   }
}
