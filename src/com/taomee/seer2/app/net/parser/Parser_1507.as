package com.taomee.seer2.app.net.parser
{
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import flash.utils.IDataInput;
   
   public class Parser_1507
   {
       
      
      public function Parser_1507(param1:IDataInput)
      {
         var _loc5_:PetInfo = null;
         var _loc6_:uint = 0;
         var _loc8_:PetInfo = null;
         super();
         var _loc2_:uint = uint(param1.readUnsignedByte());
         var _loc3_:uint = uint(param1.readUnsignedByte());
         var _loc4_:int = int(param1.readUnsignedInt());
         var _loc7_:int = 0;
         while(_loc7_ < _loc4_)
         {
            _loc6_ = uint(param1.readUnsignedInt());
            for each(_loc8_ in PetInfoManager.getAllBagPetInfo())
            {
               if(_loc8_.catchTime == _loc6_)
               {
                  _loc5_ = _loc8_;
               }
            }
            PetInfo.readBaseBaseInfo(_loc5_,param1);
            PetInfo.readSkillInfo(_loc5_,param1);
            PetInfo.readGainedSkillInfo(_loc5_,param1);
            _loc5_.learningInfo.pointUnused = param1.readUnsignedShort();
            _loc5_.twoExp = param1.readUnsignedInt();
            _loc5_.threeExp = param1.readUnsignedInt();
            _loc5_.twoStudy = param1.readUnsignedInt();
            _loc7_++;
         }
      }
   }
}
