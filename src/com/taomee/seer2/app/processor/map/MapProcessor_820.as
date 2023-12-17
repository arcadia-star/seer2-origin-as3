package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.processor.activity.leiyiKaisaFight.LeiyiKaisaFight;
   import com.taomee.seer2.core.map.MapModel;
   
   public class MapProcessor_820 extends TitleMapProcessor
   {
       
      
      private var _leiyiKaisaFight:LeiyiKaisaFight;
      
      public function MapProcessor_820(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initActivity();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_184);
      }
      
      private function initActivity() : void
      {
         this._leiyiKaisaFight = new LeiyiKaisaFight();
      }
      
      override public function dispose() : void
      {
         this._leiyiKaisaFight.dispose();
         this._leiyiKaisaFight = null;
      }
   }
}
