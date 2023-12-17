package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.processor.activity.sourceOfWater.SourceOfWaterManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_1711 extends MapProcessor
   {
       
      
      private var _water:SourceOfWaterManager;
      
      public function MapProcessor_1711(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         if(!this._water)
         {
            this._water = new SourceOfWaterManager();
         }
         this._water.setUp();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._water = null;
      }
   }
}
