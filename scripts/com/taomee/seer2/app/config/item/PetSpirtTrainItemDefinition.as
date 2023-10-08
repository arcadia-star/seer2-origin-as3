package com.taomee.seer2.app.config.item
{
   public class PetSpirtTrainItemDefinition extends BasisItemDefinition
   {
       
      
      public var type:int;
      
      public var breedTime:int;
      
      public var breedMonID:int;
      
      public var breedMonLv:int;
      
      public var exchangeItemID:int;
      
      public var exchangeCount:int;
      
      public function PetSpirtTrainItemDefinition(param1:int, param2:int, param3:String, param4:Number, param5:int, param6:int, param7:int, param8:Boolean, param9:Boolean, param10:int, param11:String, param12:int, param13:int, param14:int, param15:int, param16:int, param17:int)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         this.type = param12;
         this.breedTime = param13;
         this.breedMonID = param14;
         this.breedMonLv = param15;
         this.exchangeItemID = param16;
         this.exchangeCount = param17;
      }
   }
}
