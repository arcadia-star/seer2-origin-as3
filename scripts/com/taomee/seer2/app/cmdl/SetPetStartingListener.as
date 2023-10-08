package com.taomee.seer2.app.cmdl
{
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import flash.utils.ByteArray;
   import org.taomee.bean.BaseBean;
   
   public class SetPetStartingListener extends BaseBean
   {
       
      
      public function SetPetStartingListener()
      {
         super();
      }
      
      override public function start() : void
      {
         Connection.addCommandListener(CommandSet.PET_SET_STARTING_1018,this.onFirstData);
         Connection.addCommandListener(CommandSet.SET_SECOND_MON_1193,this.onSubData);
         finish();
      }
      
      private function onFirstData(param1:MessageEvent) : void
      {
         var _loc2_:ByteArray = param1.message.getRawDataCopy();
         var _loc3_:uint = _loc2_.readUnsignedInt();
         var _loc4_:uint = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            PetInfoManager.setSubPetInfo(_loc3_);
         }
         if(_loc4_ != 0)
         {
            PetInfoManager.setFirst(_loc4_);
         }
      }
      
      private function onSubData(param1:MessageEvent) : void
      {
         var _loc2_:ByteArray = param1.message.getRawDataCopy();
         var _loc3_:uint = _loc2_.readUnsignedInt();
         var _loc4_:uint = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            PetInfoManager.setSubPetInfo(_loc3_);
         }
         if(_loc4_ != 0)
         {
            PetInfoManager.setFirst(_loc4_);
         }
      }
   }
}
