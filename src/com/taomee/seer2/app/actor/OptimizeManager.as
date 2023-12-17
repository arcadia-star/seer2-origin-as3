package com.taomee.seer2.app.actor
{
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.ImageLevelManager;
   
   public class OptimizeManager
   {
      
      private static var _isHideRemoteActor:Boolean = true;
      
      private static var _actor:RemoteActor;
       
      
      public function OptimizeManager()
      {
         super();
      }
      
      public static function startOptimize() : void
      {
         ActorManager.getActor().isShopAllEquipPlay(false,true);
         Connection.addCommandListener(CommandSet.LIST_USER_1004,bitMapInit);
         Connection.addCommandListener(CommandSet.USER_ENTER_MAP_1002,bitMapInit);
      }
      
      private static function bitMapInit(param1:MessageEvent) : void
      {
         var remoteActor:RemoteActor = null;
         var event:MessageEvent = param1;
         if(ActorManager.getAllRemoteActors().length >= 10)
         {
            if(_isHideRemoteActor)
            {
               _isHideRemoteActor = false;
               AlertManager.showConfirm("由于场景拥挤，是否隐藏其它赛尔",function():void
               {
                  ImageLevelManager.showImagePanel();
               });
            }
         }
         for each(remoteActor in ActorManager.getAllRemoteActors())
         {
            remoteActor.isShopAllEquipPlay(true,true);
         }
      }
      
      private static function onTick(param1:uint) : void
      {
      }
      
      public static function dispose() : void
      {
         var _loc1_:RemoteActor = null;
         Connection.removeCommandListener(CommandSet.LIST_USER_1004,bitMapInit);
         Connection.removeCommandListener(CommandSet.USER_ENTER_MAP_1002,bitMapInit);
         for each(_loc1_ in ActorManager.getAllRemoteActors())
         {
            _loc1_.isShopAllEquipPlay(false,false);
         }
         ActorManager.getActor().isShopAllEquipPlay(false,false);
         _actor = null;
      }
   }
}
