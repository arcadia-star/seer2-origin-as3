package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actives.TongHunFight;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_951 extends MapProcessor
   {
       
      
      public function MapProcessor_951(param1:MapModel)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         StatisticsManager.newSendNovice("2014活动","瞳魂兽第三章","进入新场景");
         TongHunFight.getInstance().dispose();
      }
      
      override public function init() : void
      {
         TongHunFight.getInstance().setup();
      }
   }
}
