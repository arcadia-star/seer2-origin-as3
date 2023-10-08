package com.taomee.seer2.app.cmdl
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.RemoteActor;
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.actor.events.ActorEvent;
   import com.taomee.seer2.app.gameRule.ring.RingSupport;
   import com.taomee.seer2.app.gameRule.util.MapUserStatusType;
   import com.taomee.seer2.app.manager.MapUserStatusManager;
   import com.taomee.seer2.app.morphSystem.MorphManager;
   import com.taomee.seer2.app.morphSystem.MorphSwitch;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.helper.UserInfoParseHelper;
   import com.taomee.seer2.app.processor.activity.ghostMorph.GhostMorphStart;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   import org.taomee.bean.BaseBean;
   
   public class ActorMapServerBean extends BaseBean
   {
       
      
      public function ActorMapServerBean()
      {
         super();
         Connection.addCommandListener(CommandSet.LIST_USER_1004,this.onUserList);
         Connection.addCommandListener(CommandSet.USER_ENTER_MAP_1002,this.onUserEnterMap);
         Connection.addCommandListener(CommandSet.USER_LEAVE_MAP_1003,this.onUserLeaveMap);
         finish();
      }
      
      public static function syncToServer() : void
      {
         if(SceneManager.active.type == SceneType.ARENA)
         {
            syncLeaveMap();
            syncEnterMap();
         }
         else
         {
            if(SceneManager.prevSceneType != SceneType.ARENA)
            {
               syncLeaveMap();
            }
            syncEnterMap();
         }
      }
      
      private static function syncLeaveMap() : void
      {
         Connection.send(CommandSet.USER_LEAVE_MAP_1003);
      }
      
      private static function syncEnterMap() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Point = null;
         var _loc4_:int = 0;
         if(SceneManager.active.type != SceneType.ARENA)
         {
            _loc1_ = int(SceneManager.active.mapID);
            _loc2_ = int(SceneType.getServerType(SceneManager.active.type));
            _loc3_ = SceneManager.active.mapModel.initialPoint;
            _loc4_ = int(SceneManager.active.mapModel.userBehavior);
            Connection.send(CommandSet.USER_ENTER_MAP_1002,_loc1_,_loc2_,_loc3_.x,_loc3_.y,_loc4_);
            Connection.send(CommandSet.LIST_USER_1004);
         }
         else
         {
            ActorManager.dispatchEvent(ActorEvent.ACTOR_SYNC_SVR);
         }
      }
      
      private static function syncToServerComplete() : void
      {
         ActorManager.dispatchEvent(ActorEvent.ACTOR_SYNC_SVR);
      }
      
      private function onUserList(param1:MessageEvent) : void
      {
         var _loc5_:UserInfo = null;
         var _loc6_:uint = 0;
         var _loc2_:ByteArray = param1.message.getRawData();
         var _loc3_:int = int(_loc2_.readUnsignedInt());
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = new UserInfo();
            UserInfoParseHelper.parseEnterMap(_loc5_,_loc2_);
            if(_loc5_.id != ActorManager.actorInfo.id)
            {
               ActorManager.createRemoteActor(_loc5_);
               MapUserStatusManager.addMapUser(_loc5_);
               MapUserStatusManager.updateMapUser(_loc5_.id,_loc2_.readUnsignedByte());
            }
            _loc5_.updateNonoInfo(_loc2_);
            _loc5_.morphInfo.morphId = MorphSwitch.morphSwitch(_loc2_.readUnsignedInt());
            _loc6_ = _loc2_.readUnsignedInt();
            _loc5_.isYearVip = _loc2_.readUnsignedInt();
            if(_loc6_ != 0)
            {
               _loc5_.birthdayInfo.isOpen = true;
               _loc5_.birthdayInfo.year = uint(_loc6_ / 10000);
               _loc5_.birthdayInfo.month = uint(_loc6_ % 10000 / 100);
               _loc5_.birthdayInfo.day = _loc6_ % 100;
            }
            if(_loc5_.id != ActorManager.actorInfo.id && _loc5_.morphInfo.morphId != 0)
            {
               MorphManager.startRemoteMorph(_loc5_.morphInfo.morphId,ActorManager.getRemoteActor(_loc5_.id));
            }
            else if(_loc5_.id != ActorManager.actorInfo.id)
            {
               MorphManager.removeMorph(ActorManager.getRemoteActor(_loc5_.id));
            }
            if(_loc5_.id == ActorManager.actorInfo.id)
            {
               GhostMorphStart.startMorph(ActorManager.getActor());
            }
            else
            {
               GhostMorphStart.startMorph(ActorManager.getRemoteActor(_loc5_.id));
            }
            _loc4_++;
         }
      }
      
      private function onUserEnterMap(param1:MessageEvent) : void
      {
         var _loc5_:RemoteActor = null;
         var _loc2_:ByteArray = param1.message.getRawDataCopy();
         var _loc3_:UserInfo = new UserInfo();
         UserInfoParseHelper.parseEnterMap(_loc3_,_loc2_);
         MapUserStatusManager.updateMapUser(_loc3_.id,_loc2_.readUnsignedByte());
         _loc3_.updateNonoInfo(_loc2_);
         _loc3_.morphInfo.morphId = MorphSwitch.morphSwitch(_loc2_.readUnsignedInt());
         var _loc4_:uint = _loc2_.readUnsignedInt();
         _loc3_.isYearVip = _loc2_.readUnsignedInt();
         if(_loc4_ != 0)
         {
            _loc3_.birthdayInfo.isOpen = true;
            _loc3_.birthdayInfo.year = uint(_loc4_ / 10000);
            _loc3_.birthdayInfo.month = uint(_loc4_ % 10000 / 100);
            _loc3_.birthdayInfo.day = _loc4_ % 100;
         }
         if(_loc3_.id == ActorManager.getActor().id)
         {
            ActorManager.actorInfo.activityData = _loc3_.activityData;
            MapUserStatusManager.clearMapUsers();
            MapUserStatusManager.addMapUser(_loc3_);
            syncToServerComplete();
         }
         else if((_loc5_ = ActorManager.getRemoteActor(_loc3_.id)) != null)
         {
            this.addMorph(_loc5_);
         }
         else
         {
            ActorManager.createRemoteActor(_loc3_);
            MapUserStatusManager.addMapUser(_loc3_);
         }
         if(SceneManager.active != null && SceneManager.active.mapID == 81)
         {
            RingSupport.getInstance().onEnterMapUpdate();
         }
      }
      
      private function addMorph(param1:RemoteActor) : void
      {
         if(param1.getInfo().morphInfo.morphId != 0)
         {
            MorphManager.startRemoteMorph(param1.getInfo().morphInfo.morphId,param1);
         }
         else
         {
            MorphManager.removeMorph(param1);
         }
         GhostMorphStart.startMorph(param1);
      }
      
      private function onUserLeaveMap(param1:MessageEvent) : void
      {
         var _loc2_:ByteArray = param1.message.getRawDataCopy();
         var _loc3_:int = int(_loc2_.readUnsignedInt());
         var _loc4_:int;
         if((_loc4_ = int(_loc2_.readUnsignedByte())) == 1)
         {
            MapUserStatusManager.updateMapUser(_loc3_,MapUserStatusType.FIGHT);
         }
         else
         {
            ActorManager.removeRemoteActor(_loc3_);
            MapUserStatusManager.removeMapUser(_loc3_);
         }
      }
   }
}
