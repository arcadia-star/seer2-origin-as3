package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.RemoteActor;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   
   public class StanceFightPetAct
   {
      
      private static var _instance:StanceFightPetAct;
       
      
      private var pointVec:Vector.<MovieClip>;
      
      private var eftVec:Vector.<MovieClip>;
      
      private var pointNum:int;
      
      private var actorList:Vector.<RemoteActor>;
      
      private var hasStandPlayers:Array;
      
      private var boosNpc:Mobile;
      
      private var fightId:uint;
      
      private var isCall:Boolean = false;
      
      public var npcId:uint = 184;
      
      public var showFull:String = "showDragon";
      
      public var leaveFull:String = "leaveDragon";
      
      private var swapCall:int = 817;
      
      public function StanceFightPetAct()
      {
         this.hasStandPlayers = [false,false,false,false,false,false,false];
         super();
      }
      
      public static function getInstance() : StanceFightPetAct
      {
         if(!_instance)
         {
            _instance = new StanceFightPetAct();
         }
         return _instance;
      }
      
      public function dispose() : void
      {
         if(this.boosNpc)
         {
            this.boosNpc.removeEventListener(MouseEvent.CLICK,this.toFight);
         }
         Connection.removeCommandListener(CommandSet.SYNC_POSITION_1101,this.checkPointPlayer);
         LayerManager.stage.removeEventListener(Event.ENTER_FRAME,this.checkPointPlayer);
      }
      
      public function setup(param1:int, param2:int = 7) : void
      {
         this.fightId = param1;
         this.pointNum = param2;
         this.initStancePointVec();
         this.hasStandPlayers = [];
         Connection.addCommandListener(CommandSet.GET_TOTAL_VOTE_INFO_1219,this.getCallState);
         var _loc3_:Date = new Date(TimeManager.getServerTime() * 1000);
         var _loc4_:String = _loc3_.fullYear.toString();
         if(_loc3_.month < 9)
         {
            _loc4_ = _loc4_ + "0" + (_loc3_.month + 1).toString();
         }
         else
         {
            _loc4_ += (_loc3_.month + 1).toString();
         }
         if(_loc3_.date < 9)
         {
            _loc4_ = _loc4_ + "0" + _loc3_.date.toString();
         }
         else
         {
            _loc4_ += _loc3_.date.toString();
         }
         Connection.send(CommandSet.GET_TOTAL_VOTE_INFO_1219,10,int(_loc4_),int(_loc4_) + 1);
      }
      
      private function getCallState(param1:MessageEvent) : void
      {
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         Connection.removeCommandListener(CommandSet.GET_TOTAL_VOTE_INFO_1219,this.getCallState);
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:uint = uint(_loc2_.readUnsignedInt());
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = uint(_loc2_.readUnsignedInt());
            if((_loc7_ = uint(_loc2_.readUnsignedInt())) != 0)
            {
               this.isCall = true;
            }
            _loc5_++;
         }
         if(!this.isCall && this.isInTime())
         {
            this.setupCheck();
         }
         else if(this.isInTime())
         {
            this.addNpc();
         }
      }
      
      private function setupCheck() : void
      {
         LayerManager.stage.addEventListener(Event.ENTER_FRAME,this.checkPointPlayer);
      }
      
      private function checkPointPlayer(param1:* = null) : void
      {
         var _loc3_:Point = null;
         var _loc7_:int = 0;
         this.actorList = ActorManager.getAllRemoteActors();
         var _loc2_:Actor = ActorManager.getActor();
         var _loc4_:int = 0;
         while(_loc4_ < this.pointNum)
         {
            this.hasStandPlayers[_loc4_] = false;
            _loc7_ = 0;
            while(_loc7_ < this.actorList.length)
            {
               _loc3_ = this.actorList[_loc7_].localToGlobal(new Point(0,0));
               if(this.pointVec[_loc4_].hitTestPoint(_loc3_.x,_loc3_.y))
               {
                  this.hasStandPlayers[_loc4_] = true;
                  this.eftVec[_loc4_].gotoAndStop(2);
                  break;
               }
               _loc7_++;
            }
            _loc3_ = _loc2_.localToGlobal(new Point(0,0));
            if(!this.hasStandPlayers[_loc4_] && this.pointVec[_loc4_].hitTestPoint(_loc3_.x,_loc3_.y))
            {
               this.hasStandPlayers[_loc4_] = true;
               this.eftVec[_loc4_].gotoAndStop(2);
            }
            if(this.hasStandPlayers[_loc4_])
            {
            }
            _loc4_++;
         }
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         while(_loc6_ < this.pointNum)
         {
            if(this.hasStandPlayers[_loc6_])
            {
               this.eftVec[_loc6_].gotoAndStop(2);
               _loc5_++;
            }
            else
            {
               this.eftVec[_loc6_].gotoAndStop(1);
            }
            _loc6_++;
         }
         if(_loc5_ == this.pointNum)
         {
            LayerManager.stage.removeEventListener(Event.ENTER_FRAME,this.checkPointPlayer);
            this.sendCall();
            this.showDragon();
         }
      }
      
      private function sendCall() : void
      {
         SwapManager.swapItem(this.swapCall,1);
      }
      
      private function showDragon() : void
      {
         this.isCall = true;
         MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen(this.showFull),this.addNpc);
      }
      
      private function addNpc() : void
      {
         this.boosNpc = new Mobile();
         this.boosNpc.resourceUrl = URLUtil.getNpcSwf(this.npcId);
         this.boosNpc.buttonMode = true;
         this.boosNpc.x = 545;
         this.boosNpc.y = 230;
         this.boosNpc.addEventListener(MouseEvent.CLICK,this.toFight);
         MobileManager.addMobile(this.boosNpc,MobileType.NPC);
      }
      
      private function toFight(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         if(this.isInTime())
         {
            FightManager.startFightWithWild(this.fightId);
         }
         else
         {
            AlertManager.showAlert("不在活动时间内!!神龙飞已经走了!");
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen(this.leaveFull),function():void
            {
               boosNpc.removeEventListener(MouseEvent.CLICK,toFight);
               MobileManager.removeMobile(boosNpc,MobileType.NPC);
            },false,false,1,false);
         }
      }
      
      private function isInTime() : Boolean
      {
         var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
         if(_loc1_.hours >= 14 && _loc1_.hours < 15)
         {
            return true;
         }
         if(_loc1_.hours >= 19 && _loc1_.hours < 20)
         {
            return true;
         }
         return false;
      }
      
      private function initStancePointVec() : void
      {
         if(!this.pointVec)
         {
            this.pointVec = new Vector.<MovieClip>(this.pointNum);
            this.eftVec = new Vector.<MovieClip>(this.pointNum);
         }
         var _loc1_:MapModel = SceneManager.active.mapModel;
         var _loc2_:int = 0;
         while(_loc2_ < this.pointNum)
         {
            this.pointVec[_loc2_] = _loc1_.ground["FightPoint" + _loc2_];
            this.eftVec[_loc2_] = _loc1_.ground["eft" + _loc2_];
            this.eftVec[_loc2_].gotoAndStop(1);
            this.eftVec[_loc2_].mouseChildren = this.eftVec[_loc2_].mouseEnabled = false;
            this.pointVec[_loc2_].mouseChildren = this.pointVec[_loc2_].mouseEnabled = false;
            this.hasStandPlayers[_loc2_] = false;
            _loc2_++;
         }
      }
   }
}
