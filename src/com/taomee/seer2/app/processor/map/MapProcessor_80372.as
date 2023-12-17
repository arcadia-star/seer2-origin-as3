package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.processor.activity.earthSearchAct.EarthSearchThreeLayer;
   import com.taomee.seer2.core.map.MapModel;
   
   public class MapProcessor_80372 extends TitleMapProcessor
   {
       
      
      private var _earthThree:EarthSearchThreeLayer;
      
      public function MapProcessor_80372(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this._earthThree = new EarthSearchThreeLayer(_map);
      }
      
      override public function dispose() : void
      {
         this._earthThree.dispose();
         this._earthThree = null;
         super.dispose();
      }
   }
}
