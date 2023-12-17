package com.taomee.seer2.app.morphSystem
{
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.RemoteActor;
   
   public class MorphManager
   {
       
      
      public function MorphManager()
      {
         super();
      }
      
      public static function startThisMorph(param1:uint) : void
      {
         ActorManager.getActor().startTransform(param1);
      }
      
      public static function removeMorph(param1:Actor) : void
      {
         if(param1.id == ActorManager.actorInfo.id)
         {
            MorphUpdate.removeTime();
            param1.stopTransform();
            param1.getInfo().morphInfo.morphId = 0;
         }
         else
         {
            ActorManager.getRemoteActor(param1.id).stopTransform();
            ActorManager.getRemoteActor(param1.id).getInfo().morphInfo.morphId = 0;
         }
      }
      
      public static function startRemoteMorph(param1:uint, param2:RemoteActor) : void
      {
         param2.startTransform(param1);
      }
   }
}
