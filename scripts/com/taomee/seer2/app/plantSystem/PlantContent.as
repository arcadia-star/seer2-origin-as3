package com.taomee.seer2.app.plantSystem
{
   import com.taomee.seer2.app.inventory.item.SpecialItem;
   
   public class PlantContent
   {
       
      
      public function PlantContent()
      {
         super();
      }
      
      public static function getType(param1:SpecialItem) : int
      {
         if(param1.referenceId >= 601000 && param1.referenceId < 601499)
         {
            return PlantType.SEED;
         }
         if(param1.referenceId >= 601500 && param1.referenceId < 601999)
         {
            return PlantType.FRUIT;
         }
         if(param1.referenceId >= 602000 && param1.referenceId < 602499)
         {
            return PlantType.FERTILIZER;
         }
         return -1;
      }
   }
}
