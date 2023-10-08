package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.processor.activity.darkAct.DarkTwoLayer;
   import com.taomee.seer2.core.map.MapModel;
   
   public class MapProcessor_80012 extends TitleMapProcessor
   {
       
      
      private var _dartTwoAct:DarkTwoLayer;
      
      public function MapProcessor_80012(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this._dartTwoAct = new DarkTwoLayer(_map);
      }
      
      override public function dispose() : void
      {
         this._dartTwoAct.dispose();
         this._dartTwoAct = null;
         super.dispose();
      }
   }
}
