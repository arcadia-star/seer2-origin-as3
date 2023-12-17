package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.processor.activity.darkAct.DarkThreeLayer;
   import com.taomee.seer2.core.map.MapModel;
   
   public class MapProcessor_80013 extends TitleMapProcessor
   {
       
      
      private var _darkThree:DarkThreeLayer;
      
      public function MapProcessor_80013(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this._darkThree = new DarkThreeLayer(_map);
      }
      
      override public function dispose() : void
      {
         this._darkThree.dispose();
         this._darkThree = null;
         super.dispose();
      }
   }
}
