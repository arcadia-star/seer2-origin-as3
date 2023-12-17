package com.taomee.seer2.app.cmdl
{
   import com.taomee.seer2.app.config.PetConfig;
   import com.taomee.seer2.app.config.pet.PetDefinition;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.pet.events.PetInfoEvent;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.core.net.MessageEvent;
   import flash.utils.ByteArray;
   import org.taomee.bean.BaseBean;
   
   public class StartTrainingPet extends BaseBean
   {
       
      
      public function StartTrainingPet()
      {
         super();
      }
      
      override public function start() : void
      {
         Connection.addCommandListener(CommandSet.PET_TRAINING_START_1039,this.onData);
         finish();
      }
      
      private function onData(param1:MessageEvent) : void
      {
         var _loc2_:PetDefinition = null;
         var _loc3_:ByteArray = param1.message.getRawDataCopy();
         var _loc4_:uint = _loc3_.readUnsignedInt();
         var _loc5_:uint = _loc3_.readUnsignedInt();
         var _loc6_:uint = _loc3_.readUnsignedInt();
         var _loc7_:PetInfo;
         if((_loc7_ = PetInfoManager.getPetInfoFromMap(_loc6_)) != null)
         {
            PetInfoManager.setFirst(_loc4_);
            if(_loc7_.isInBag && _loc7_.isSetBirth == false && _loc7_.isBirthIng == false)
            {
               PetInfoManager.removePetInfoFromBagById(_loc6_);
            }
            _loc7_.isTraining = true;
            _loc2_ = _loc7_.getPetDefinition();
         }
         else
         {
            _loc2_ = PetConfig.getPetDefinition(_loc5_);
         }
         var _loc8_:PetInfo;
         (_loc8_ = new PetInfo()).catchTime = _loc6_;
         PetInfoManager.dispatchEvent(PetInfoEvent.PET_START_TRAINING,_loc8_);
         var _loc9_:* = _loc2_.name + "已放回小屋训练";
         ServerMessager.addMessage(_loc9_);
      }
   }
}
