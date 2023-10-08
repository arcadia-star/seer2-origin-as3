package com.taomee.seer2.app.processor.activity.frozen
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.RemoteActor;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.core.net.MessageEvent;
   
   public class UpdateActivityActor
   {
      
      private static var _frozenActorList:Vector.<com.taomee.seer2.app.processor.activity.frozen.FrozenActor>;
      
      private static var _fun:Function;
       
      
      public function UpdateActivityActor()
      {
         super();
      }
      
      public static function enterMap(param1:Function) : void
      {
         _fun = param1;
         Connection.addCommandListener(CommandSet.LIST_USER_1004,listUsers);
         Connection.addCommandListener(CommandSet.USER_ENTER_MAP_1002,listUsers);
      }
      
      private static function listUsers(param1:MessageEvent) : void
      {
         var _loc3_:com.taomee.seer2.app.processor.activity.frozen.FrozenActor = null;
         var _loc4_:RemoteActor = null;
         var _loc2_:Vector.<RemoteActor> = ActorManager.getAllRemoteActors();
         _frozenActorList = Vector.<com.taomee.seer2.app.processor.activity.frozen.FrozenActor>([]);
         for each(_loc4_ in _loc2_)
         {
            _loc3_ = new com.taomee.seer2.app.processor.activity.frozen.FrozenActor();
            _loc3_.actor = _loc4_;
            _loc3_.hp = _loc4_.getInfo().activityData[0];
            _loc3_.status = true;
            _loc3_.actor.buttonMode = false;
            _loc3_.actor.mouseChildren = false;
            _loc3_.actor.mouseEnabled = false;
            if(_loc3_.actor.getFollowingPet())
            {
               _loc3_.actor.getFollowingPet().mouseChildren = false;
               _loc3_.actor.getFollowingPet().mouseEnabled = false;
            }
            _frozenActorList.push(_loc3_);
         }
         if(_fun != null)
         {
            _fun();
         }
         _fun = null;
      }
      
      public static function getList() : Vector.<com.taomee.seer2.app.processor.activity.frozen.FrozenActor>
      {
         return _frozenActorList;
      }
      
      public static function getActor(param1:uint) : com.taomee.seer2.app.processor.activity.frozen.FrozenActor
      {
         var _loc2_:com.taomee.seer2.app.processor.activity.frozen.FrozenActor = null;
         for each(_loc2_ in _frozenActorList)
         {
            if(_loc2_.actor.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function remove() : void
      {
         var _loc1_:com.taomee.seer2.app.processor.activity.frozen.FrozenActor = null;
         Connection.removeCommandListener(CommandSet.LIST_USER_1004,listUsers);
         Connection.removeCommandListener(CommandSet.USER_ENTER_MAP_1002,listUsers);
         for each(_loc1_ in _frozenActorList)
         {
            _loc1_.removeTimer();
            _loc1_.status = true;
            if(_loc1_.actor.getFollowingPet())
            {
               _loc1_.actor.getFollowingPet().mouseChildren = true;
               _loc1_.actor.getFollowingPet().mouseEnabled = true;
            }
            _loc1_.actor.buttonMode = true;
            _loc1_.actor.mouseChildren = true;
            _loc1_.actor.mouseEnabled = true;
         }
      }
   }
}
