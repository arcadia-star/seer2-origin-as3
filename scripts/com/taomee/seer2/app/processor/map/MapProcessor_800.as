package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.core.map.MapModel;
   
   public class MapProcessor_800 extends TitleMapProcessor
   {
       
      
      public function MapProcessor_800(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         ServerBufferManager.updateServerBuffer(ServerBufferType.PETMELEE,0,0);
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_183);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
