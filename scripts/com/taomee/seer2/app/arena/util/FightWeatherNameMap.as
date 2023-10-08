package com.taomee.seer2.app.arena.util
{
   import org.taomee.ds.HashMap;
   
   public class FightWeatherNameMap
   {
      
      private static var _map:HashMap;
       
      
      public function FightWeatherNameMap()
      {
         super();
      }
      
      private static function initialize() : void
      {
         _map = new HashMap();
         _map.add(1,"晴天");
         _map.add(2,"雨天");
         _map.add(3,"炎热");
         _map.add(4,"暴风雪");
         _map.add(5,"沙尘暴");
         _map.add(6,"地震");
         _map.add(7,"雷暴天");
         _map.add(8,"飓风");
         _map.add(9,"夜幕");
         _map.add(10,"异空间");
         _map.add(11,"古战场");
         _map.add(12,"虫群");
         _map.add(13,"星移");
         _map.add(14,"三级星移");
         _map.add(15,"二级星移");
         _map.add(17,"强震");
         _map.add(18,"黄沙暴");
         _map.add(20,"MAX星移");
         _map.add(23,"烈日");
      }
      
      public static function getWeatherNameByCode(param1:uint) : String
      {
         if(_map == null)
         {
            initialize();
         }
         if(_map.containsKey(param1) == true)
         {
            return _map.getValue(param1);
         }
         return "未设置";
      }
   }
}
