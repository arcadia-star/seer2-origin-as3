package com.taomee.seer2.app.firstTeach
{
   import com.taomee.seer2.app.pet.data.PetInfo;
   
   public class FirstTeachType
   {
      
      public static const FIRST_TEACH_TOTAL_NUM:int = 6;
      
      public static const SKILLTEACH_LA_AO:int = 3;
      
      public static const SKILLTEACH_DIDILAN:int = 4;
      
      public static const SKILLTEACH_XIUXIU:int = 5;
       
      
      public function FirstTeachType()
      {
         super();
      }
      
      public static function getTaskPosition(param1:PetInfo) : int
      {
         if(param1.resourceId == 3)
         {
            return FirstTeachType.SKILLTEACH_DIDILAN;
         }
         if(param1.resourceId == 6)
         {
            return FirstTeachType.SKILLTEACH_XIUXIU;
         }
         if(param1.resourceId == 9)
         {
            return FirstTeachType.SKILLTEACH_LA_AO;
         }
         return 0;
      }
      
      public static function gerTaskParser(param1:PetInfo) : int
      {
         if(param1.resourceId == 3)
         {
            return 3;
         }
         if(param1.resourceId == 6)
         {
            return 4;
         }
         if(param1.resourceId == 9)
         {
            return 3;
         }
         return 0;
      }
   }
}
