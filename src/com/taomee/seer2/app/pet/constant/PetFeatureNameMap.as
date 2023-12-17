package com.taomee.seer2.app.pet.constant
{
   import org.taomee.ds.HashMap;
   
   public class PetFeatureNameMap
   {
      
      private static var _map:HashMap;
      
      {
         initialize();
      }
      
      public function PetFeatureNameMap()
      {
         super();
      }
      
      private static function initialize() : void
      {
         _map = new HashMap();
         _map.add(1001,"终结");
         _map.add(1002,"炎火");
         _map.add(1003,"坚韧");
         _map.add(1004,"入梦");
         _map.add(1005,"阳光");
         _map.add(1006,"重压");
         _map.add(1007,"坚强");
         _map.add(1008,"流水");
         _map.add(1009,"毒药");
         _map.add(1010,"空气");
         _map.add(1011,"锋利");
         _map.add(1012,"潮湿");
         _map.add(1013,"燃烧");
         _map.add(1014,"眩晕");
         _map.add(1015,"阳炎");
         _map.add(1016,"快攻");
         _map.add(1017,"光滑");
         _map.add(1018,"红心");
         _map.add(1019,"偏斜");
      }
      
      public static function getFeatureName(param1:uint) : String
      {
         if(_map.containsKey(param1) == true)
         {
            return _map.getValue(param1);
         }
         return "未知";
      }
   }
}
