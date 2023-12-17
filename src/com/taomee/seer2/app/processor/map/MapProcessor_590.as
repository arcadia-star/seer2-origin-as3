package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.processor.activity.miKaAct.MiKaFindProcessHandle;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_590 extends MapProcessor
   {
       
      
      private var _mikaFindHandle:MiKaFindProcessHandle;
      
      public function MapProcessor_590(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_177);
         this._mikaFindHandle = new MiKaFindProcessHandle(_map);
      }
      
      override public function dispose() : void
      {
         if(this._mikaFindHandle)
         {
            this._mikaFindHandle.dispose();
            this._mikaFindHandle = null;
         }
         super.dispose();
      }
   }
}
