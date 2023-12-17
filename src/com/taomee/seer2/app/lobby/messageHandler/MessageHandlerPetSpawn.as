package com.taomee.seer2.app.lobby.messageHandler
{
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.pet.MonsterManager;
   import com.taomee.seer2.app.pet.SpawnedPet;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.net.message.IMessageHandler;
   import com.taomee.seer2.core.scene.SceneManager;
   import flash.utils.IDataInput;
   
   public class MessageHandlerPetSpawn implements IMessageHandler
   {
       
      
      public function MessageHandlerPetSpawn()
      {
         super();
      }
      
      public function setup() : void
      {
         Connection.addCommandListener(CommandSet.PET_SPAWN_1103,this.onMessage);
      }
      
      public function onMessage(param1:MessageEvent) : void
      {
         var _loc3_:IDataInput = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:SpawnedPet = null;
         var _loc2_:uint = uint(SceneManager.active.mapID);
         if(_loc2_ == 192)
         {
            if(QuestManager.isStepComplete(9,1) && !QuestManager.isStepComplete(9,3))
            {
               return;
            }
         }
         if(_loc2_ != 1 && _loc2_ != 139 && _loc2_ != 220)
         {
            MobileManager.clearMobileVec(MobileType.SPAWNED_PET);
            _loc3_ = param1.message.getRawDataCopy();
            _loc4_ = int(_loc3_.readUnsignedInt());
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc6_ = int(_loc3_.readUnsignedInt());
               _loc7_ = int(_loc3_.readUnsignedInt());
               _loc8_ = int(_loc3_.readUnsignedShort());
               _loc3_.readUnsignedInt();
               _loc3_.readUnsignedByte();
               _loc9_ = new SpawnedPet(_loc7_,_loc6_,_loc8_);
               MobileManager.addMobile(_loc9_,MobileType.SPAWNED_PET);
               _loc5_++;
            }
            if(MonsterManager.isShow == false)
            {
               MobileManager.hideMoileVec(MobileType.SPAWNED_PET);
            }
         }
      }
      
      public function dispose() : void
      {
         Connection.removeCommandListener(CommandSet.PET_SPAWN_1103,this.onMessage);
      }
   }
}
