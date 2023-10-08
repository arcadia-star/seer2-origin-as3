package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.processor.activity.vinesFight.VinesFight;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_830 extends MapProcessor
   {
       
      
      private var _vinesFight:VinesFight;
      
      public function MapProcessor_830(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this._vinesFight = new VinesFight(_map);
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_185);
      }
      
      override public function dispose() : void
      {
         if(this._vinesFight)
         {
            this._vinesFight.dispose();
         }
         this._vinesFight = null;
         super.dispose();
      }
   }
}
