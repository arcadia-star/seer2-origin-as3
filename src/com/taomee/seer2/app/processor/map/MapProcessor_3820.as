package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.processor.activity.lovePaoPaoAct.LovePaoPaoAct;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_3820 extends MapProcessor
   {
       
      
      private var _loveAct:LovePaoPaoAct;
      
      public function MapProcessor_3820(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         this._loveAct = new LovePaoPaoAct(_map);
         StatisticsManager.sendNovice("0x100345FD");
      }
      
      override public function dispose() : void
      {
         this._loveAct.dispose();
         super.dispose();
      }
   }
}
