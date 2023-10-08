package com.taomee.seer2.app.processor.activity.frozen
{
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.shoot.ShootController;
   import com.taomee.seer2.app.shoot.ShootEvent;
   import com.taomee.seer2.app.shoot.ShootInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.events.MoveEvent;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.ArrayUtil;
   import com.taomee.seer2.core.utils.DateUtil;
   import flash.events.Event;
   import flash.utils.IDataInput;
   
   public class FrozenManager
   {
       
      
      private var _map:MapModel;
      
      private var _index:int;
      
      private var _type:int;
      
      private var _actor:com.taomee.seer2.app.processor.activity.frozen.FrozenActor;
      
      private var _frpzen:com.taomee.seer2.app.processor.activity.frozen.Frozen;
      
      private var _randomFrpzen:int;
      
      private var _frozenPointList:Vector.<com.taomee.seer2.app.processor.activity.frozen.FrozenPoint>;
      
      public function FrozenManager(param1:MapModel)
      {
         super();
         this._map = param1;
         this.initMap();
      }
      
      public static function isActivityTime() : Boolean
      {
         var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
         var _loc2_:Boolean = false;
         if(Boolean(DateUtil.isInHourScope(14,15,30,30)) || Boolean(DateUtil.isInHourScope(18,19,30,30)))
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      private function initMap() : void
      {
         UpdateActivityActor.enterMap(this.init);
      }
      
      private function init() : void
      {
         this.initPoint();
         this.initActor();
         this._frpzen = new com.taomee.seer2.app.processor.activity.frozen.Frozen(this._map.content["frozen"]);
         FrozenBubble.setupBubble();
         this._actor.thisActor.addEventListener(MoveEvent.MOVE,this.onMove);
         this._map.content.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         Connection.addErrorHandler(CommandSet.FROZEN_FIGHT_1154,this.onError);
         Connection.addCommandListener(CommandSet.FROZEN_STATUS_1158,this.onFrozenInfo);
         Connection.send(CommandSet.FROZEN_STATUS_1158);
         Connection.addCommandListener(CommandSet.FROZEN_OUT_OR_OVER_1150,this.onOverOrOut);
         Connection.addCommandListener(CommandSet.FROZEN_ACTIVITY_TYPE_1151,this.onFrozenActivityType);
      }
      
      private function initActor() : void
      {
         var _loc1_:Actor = null;
         _loc1_ = ActorManager.getActor();
         this._actor = new com.taomee.seer2.app.processor.activity.frozen.FrozenActor();
         this._actor.thisActor = _loc1_;
         this._actor.setThisHp(_loc1_.getInfo().activityData[0]);
         _loc1_.buttonMode = false;
         _loc1_.mouseChildren = false;
         _loc1_.mouseEnabled = false;
         if(_loc1_.getFollowingPet())
         {
            _loc1_.getFollowingPet().mouseChildren = false;
            _loc1_.getFollowingPet().mouseEnabled = false;
         }
      }
      
      private function initPoint() : void
      {
         this._frozenPointList = Vector.<com.taomee.seer2.app.processor.activity.frozen.FrozenPoint>([]);
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            this._frozenPointList.push(new com.taomee.seer2.app.processor.activity.frozen.FrozenPoint(this._map.content["point" + _loc1_],this._map.content["thisPoint" + _loc1_]));
            _loc1_++;
         }
      }
      
      private function onFrozenInfo(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.FROZEN_STATUS_1158,this.onFrozenInfo);
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:uint = uint(_loc2_.readUnsignedInt());
         this._frpzen.removeBlood();
         this._frpzen.setType(_loc3_);
         this._frpzen.setHp(_loc4_);
         this._type = _loc3_;
         this.updateType(true);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:com.taomee.seer2.app.processor.activity.frozen.FrozenPoint = null;
         var _loc4_:Boolean = false;
         var _loc7_:int = 0;
         if(this._type != 0 && this._type != 2)
         {
            return;
         }
         var _loc3_:Actor = ActorManager.getActor();
         var _loc5_:Array;
         (_loc5_ = ArrayUtil.toArray(ActorManager.getAllRemoteActors())).push(_loc3_);
         var _loc6_:int = 0;
         while(_loc6_ < 5)
         {
            _loc2_ = this._frozenPointList[_loc6_];
            _loc4_ = false;
            _loc7_ = 0;
            while(_loc7_ < _loc5_.length)
            {
               if(_loc2_.thisMc.hitTestObject(_loc5_[_loc7_]))
               {
                  _loc4_ = true;
               }
               _loc7_++;
            }
            this.isPlayIndex(_loc4_,_loc6_);
            _loc6_++;
         }
      }
      
      private function isPlayIndex(param1:Boolean, param2:int) : void
      {
         var _loc3_:com.taomee.seer2.app.processor.activity.frozen.FrozenPoint = this._frozenPointList[param2];
         this._index = param2;
         if(param1 && _loc3_.status == false)
         {
            _loc3_.status = true;
            _loc3_.mc.gotoAndStop(2);
            this.bubbleCount();
         }
         else if(param1 == false && _loc3_.status)
         {
            _loc3_.status = false;
            _loc3_.mc.gotoAndStop(1);
            this.bubbleCount();
         }
      }
      
      private function bubbleCount() : void
      {
         var _loc2_:com.taomee.seer2.app.processor.activity.frozen.FrozenPoint = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this._frozenPointList)
         {
            if(_loc2_.status)
            {
               _loc1_++;
            }
         }
         FrozenBubble.enterBubble(_loc1_);
      }
      
      private function onMove(param1:MoveEvent) : void
      {
         var _loc2_:com.taomee.seer2.app.processor.activity.frozen.FrozenPoint = null;
         var _loc4_:Boolean = false;
         var _loc3_:Actor = ActorManager.getActor();
         if(this._actor.getBlood())
         {
            this._actor.getBlood().x = _loc3_.x - 65;
            this._actor.getBlood().y = _loc3_.y - 100;
         }
         var _loc5_:int = 0;
         while(_loc5_ < 5)
         {
            _loc2_ = this._frozenPointList[_loc5_];
            _loc4_ = false;
            if(_loc2_.thisMc.hitTestObject(_loc3_))
            {
               _loc4_ = true;
            }
            this.verification(_loc4_,_loc5_);
            _loc5_++;
         }
      }
      
      private function verification(param1:Boolean, param2:int) : void
      {
         if(!FrozenManager.isActivityTime())
         {
            return;
         }
         var _loc3_:com.taomee.seer2.app.processor.activity.frozen.FrozenPoint = this._frozenPointList[param2];
         this._index = param2;
         if(param1 && _loc3_.serverStatus == false)
         {
            this._frozenPointList[this._index].serverStatus = true;
            Connection.send(CommandSet.FROZEN_OUT_OR_OVER_1150,this._index + 1,1);
         }
         else if(param1 == false && _loc3_.serverStatus)
         {
            this._frozenPointList[this._index].serverStatus = false;
            Connection.send(CommandSet.FROZEN_OUT_OR_OVER_1150,this._index + 1,0);
         }
      }
      
      private function onOverOrOut(param1:MessageEvent) : void
      {
         var _loc2_:IDataInput = param1.message.getRawData();
      }
      
      private function onFrozenActivityType(param1:MessageEvent) : void
      {
         var _loc2_:IDataInput = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:com.taomee.seer2.app.processor.activity.frozen.FrozenActor = null;
         _loc2_ = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:uint = uint(_loc2_.readUnsignedInt());
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            switch(_loc3_)
            {
               case 1:
                  this._type = _loc2_.readUnsignedInt();
                  this.updateType();
                  break;
               case 2:
                  _loc6_ = uint(_loc2_.readUnsignedInt());
                  this._frpzen.setHp(_loc6_);
                  break;
               case 3:
                  _loc7_ = uint(_loc2_.readUnsignedInt());
                  this.onFight(_loc7_);
                  break;
            }
            if(_loc3_ == 4)
            {
               _loc8_ = uint(_loc2_.readUnsignedInt());
               if(this._actor.thisActor.getInfo().id == _loc8_)
               {
                  LayerManager.resetOperation();
                  this._actor.releaseUser();
               }
               else
               {
                  (_loc9_ = UpdateActivityActor.getActor(_loc8_)).releaseUser();
               }
            }
            _loc5_++;
         }
      }
      
      private function updateType(param1:Boolean = false) : void
      {
         if(this._type < 3)
         {
            LayerManager.resetOperation();
            ShootController.removeEventListener(ShootEvent.PLAY_END,this.onShootOver);
            FrozenBubble.setTimerBubble(this._type);
            this._frpzen.disposeBlood();
         }
         switch(this._type)
         {
            case 1:
               this.type1(param1);
               break;
            case 2:
               this.type2();
               break;
            case 3:
               this.type3(param1);
               break;
            case 4:
               this.type4(param1);
               break;
            case 5:
               this.type5(param1);
         }
      }
      
      private function type1(param1:Boolean) : void
      {
         var _loc2_:com.taomee.seer2.app.processor.activity.frozen.FrozenPoint = null;
         this._actor.setThisHp(20);
         for each(_loc2_ in this._frozenPointList)
         {
            _loc2_.mc.gotoAndStop(1);
         }
         this._frpzen.mc.gotoAndStop(this._frpzen.mc.totalFrames);
         FrozenBubble.setTimerBubble(this._type);
         StoneAward.setupStone(this._map);
         if(param1)
         {
            return;
         }
         FrozenStatus.playAnimation6();
      }
      
      private function type2() : void
      {
         FrozenSo.clearSo();
         StoneAward.remove();
         this._frpzen.mc.gotoAndStop(1);
      }
      
      private function type3(param1:Boolean) : void
      {
         FrozenSo.clearSo();
         FrozenBubble.setTimerBubble(this._type);
         this.openFrozen();
         if(param1)
         {
            this._frpzen.mc.gotoAndStop(76);
            return;
         }
         this._frpzen.removeBlood();
         this._frpzen.setType(this._type);
         this._frpzen.setHp(6000);
         FrozenStatus.playAnimation1(this.openFrozen,this._frpzen.mc);
      }
      
      private function type4(param1:Boolean) : void
      {
         FrozenSo.clearSo();
         this.openFrozen();
         FrozenBubble.setTimerBubble(this._type);
         if(param1)
         {
            this._frpzen.mc.gotoAndStop(111);
            return;
         }
         this._frpzen.removeBlood();
         this._frpzen.setType(this._type);
         this._frpzen.setHp(9000);
         FrozenStatus.playAnimation2(this._frpzen.mc,this.openFrozen);
      }
      
      private function type5(param1:Boolean) : void
      {
         FrozenSo.clearSo();
         this.openFrozen();
         FrozenBubble.setTimerBubble(this._type);
         if(param1)
         {
            this._frpzen.mc.gotoAndStop(152);
            return;
         }
         this._frpzen.removeBlood();
         this._frpzen.setType(this._type);
         this._frpzen.setHp(14000);
         FrozenStatus.playAnimation3(this._frpzen.mc,this.openFrozen);
      }
      
      private function onFight(param1:uint) : void
      {
         var random:uint = param1;
         var i:int = 0;
         while(i < this._frozenPointList.length)
         {
            if(i >= this._frozenPointList.length - 1)
            {
               MovieClipUtil.playMc(this._frozenPointList[i].mc,12,this._frozenPointList[i].mc.totalFrames,function():void
               {
                  if(_frpzen.hp > 3)
                  {
                     FrozenStatus.playAnimation5(handleUser);
                  }
                  else
                  {
                     ShootController.close();
                     handleUser();
                  }
               });
            }
            else
            {
               MovieClipUtil.playMc(this._frozenPointList[i].mc,12,this._frozenPointList[i].mc.totalFrames);
            }
            i++;
         }
         this._randomFrpzen = random - 1;
         if(this._randomFrpzen > 3)
         {
            this._randomFrpzen = 3;
         }
         this._frozenPointList[this._randomFrpzen].mc.gotoAndStop(3);
      }
      
      private function handleUser() : void
      {
         var userList:Vector.<com.taomee.seer2.app.processor.activity.frozen.FrozenActor>;
         var actor:com.taomee.seer2.app.processor.activity.frozen.FrozenActor = null;
         var hp:uint = 0;
         this._frozenPointList[this._randomFrpzen].mc.gotoAndStop(2);
         if(this._actor.thisActor.hitTestObject(this._frozenPointList[this._randomFrpzen].mc) == false)
         {
            if(this._actor.hp > 5)
            {
               hp = this._actor.hp;
               this._actor.setThisHp(hp - 5);
               LayerManager.focusOnTopLayer();
               this._actor.startTimer(function():void
               {
                  LayerManager.resetOperation();
               },true);
            }
            else
            {
               SceneManager.changeScene(SceneType.LOBBY,50);
            }
         }
         else
         {
            Connection.addErrorHandler(CommandSet.FROZEN_DEFEND_1155,this.onError);
            Connection.addCommandListener(CommandSet.FROZEN_DEFEND_1155,this.onDefend);
            Connection.send(CommandSet.FROZEN_DEFEND_1155,0);
         }
         userList = UpdateActivityActor.getList();
         for each(actor in userList)
         {
            if(actor.actor.hitTestObject(this._frozenPointList[this._randomFrpzen].mc) == false)
            {
               actor.status = false;
               actor.startTimer();
            }
         }
      }
      
      private function onDefend(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.FROZEN_DEFEND_1155,this.onError);
         Connection.removeCommandListener(CommandSet.FROZEN_DEFEND_1155,this.onDefend);
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         this._actor.thisActor.getInfo().activityData[0] = _loc3_;
         this._actor.hp = _loc3_;
      }
      
      private function openFrozen() : void
      {
         ShootController.addEventListener(ShootEvent.PLAY_END,this.onShootOver);
      }
      
      private function onShootOver(param1:ShootEvent) : void
      {
         var _loc4_:com.taomee.seer2.app.processor.activity.frozen.FrozenActor = null;
         if(this._type < 3)
         {
            return;
         }
         var _loc2_:ShootInfo = param1.info;
         if(this._frpzen.mc.hitTestPoint(_loc2_.endPos.x,_loc2_.endPos.y))
         {
            if(_loc2_.id == 3)
            {
               Connection.send(CommandSet.FROZEN_FIGHT_1154,0);
            }
         }
         var _loc3_:Vector.<com.taomee.seer2.app.processor.activity.frozen.FrozenActor> = UpdateActivityActor.getList();
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_.actor.hitTestPoint(_loc2_.endPos.x,_loc2_.endPos.y))
            {
               if(_loc2_.id == 3 && _loc4_.status == false)
               {
                  Connection.send(CommandSet.FROZEN_FIGHT_1154,_loc4_.actor.getInfo().id);
                  _loc4_.releaseUser();
                  return;
               }
            }
         }
      }
      
      private function onError(param1:MessageEvent) : void
      {
         if(param1.message.statusCode == 2)
         {
            return;
         }
      }
      
      private function clear() : void
      {
         if(this._actor)
         {
            this._actor.thisActor.buttonMode = true;
            this._actor.thisActor.mouseChildren = true;
            this._actor.thisActor.mouseEnabled = true;
            if(this._actor.thisActor.getFollowingPet())
            {
               this._actor.thisActor.getFollowingPet().mouseChildren = true;
               this._actor.thisActor.getFollowingPet().mouseEnabled = true;
            }
         }
         this._actor = null;
         this._frozenPointList = null;
      }
      
      public function dispose() : void
      {
         LayerManager.resetOperation();
         FrozenStatus.removeFigthMc();
         FrozenBubble.remove();
         StoneAward.remove();
         if(this._actor)
         {
            this._actor.removeHp();
            this._actor.thisActor.removeEventListener(MoveEvent.MOVE,this.onMove);
         }
         if(this._frpzen)
         {
            this._frpzen.removeBlood();
         }
         ShootController.removeEventListener(ShootEvent.PLAY_END,this.onShootOver);
         if(this._map)
         {
            this._map.content.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
         Connection.removeErrorHandler(CommandSet.FROZEN_DEFEND_1155,this.onError);
         Connection.removeErrorHandler(CommandSet.FROZEN_FIGHT_1154,this.onError);
         Connection.removeCommandListener(CommandSet.FROZEN_STATUS_1158,this.onFrozenInfo);
         Connection.removeCommandListener(CommandSet.FROZEN_DEFEND_1155,this.onDefend);
         Connection.removeCommandListener(CommandSet.FROZEN_OUT_OR_OVER_1150,this.onOverOrOut);
         Connection.removeCommandListener(CommandSet.FROZEN_ACTIVITY_TYPE_1151,this.onFrozenActivityType);
         UpdateActivityActor.remove();
         this.clear();
      }
   }
}
