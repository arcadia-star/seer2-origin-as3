package com.taomee.seer2.app.home.messageHandler
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.home.data.TrainingPetInfo;
   import com.taomee.seer2.app.home.training.TrainingPetHelper;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.net.message.IMessageHandler;
   import com.taomee.seer2.core.net.message.Message;
   import com.taomee.seer2.core.scene.SceneManager;
   import flash.utils.ByteArray;
   
   public class MessageHandlerPetTraining implements IMessageHandler
   {
       
      
      public function MessageHandlerPetTraining()
      {
         super();
      }
      
      public function setup() : void
      {
         Connection.addCommandListener(CommandSet.PET_TRAINING_START_1039,this.onMessage);
         Connection.addCommandListener(CommandSet.PET_TRAINING_FINISH_1040,this.onMessage);
      }
      
      public function onMessage(param1:MessageEvent) : void
      {
         switch(param1.message.commandId)
         {
            case CommandSet.PET_TRAINING_START_1039.id:
               this.onStartTrainingPet(param1.message);
               break;
            case CommandSet.PET_TRAINING_FINISH_1040.id:
               this.onFinishTrainingPet(param1.message);
         }
      }
      
      private function onStartTrainingPet(param1:Message) : void
      {
         var _loc4_:TrainingPetInfo = null;
         var _loc2_:ByteArray = param1.getRawDataCopy();
         var _loc3_:uint = _loc2_.readUnsignedInt();
         if(Boolean(SceneManager.active) && SceneManager.active.mapID == ActorManager.actorInfo.id)
         {
            _loc4_ = new TrainingPetInfo(_loc2_);
            TrainingPetHelper.addTrainingPet(_loc4_);
         }
      }
      
      private function onFinishTrainingPet(param1:Message) : void
      {
         var _loc2_:ByteArray = param1.getRawDataCopy();
         var _loc3_:uint = _loc2_.readUnsignedInt();
         var _loc4_:uint = _loc2_.readUnsignedInt();
         PetInfoManager.requestAddToBagFromStorage(_loc4_,_loc3_);
         if(Boolean(SceneManager.active) && SceneManager.active.mapID == ActorManager.actorInfo.id)
         {
            TrainingPetHelper.removeTrainingPet(_loc4_);
         }
      }
      
      public function dispose() : void
      {
         Connection.removeCommandListener(CommandSet.PET_TRAINING_START_1039,this.onMessage);
         Connection.removeCommandListener(CommandSet.PET_TRAINING_FINISH_1040,this.onMessage);
      }
   }
}
