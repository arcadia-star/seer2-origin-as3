package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.processor.activity.rainOfSunAct.RainOfSunActOne;
   import com.taomee.seer2.core.map.MapModel;
   
   public class MapProcessor_80046 extends TitleMapProcessor
   {
       
      
      private var _rainOfSunActOne:RainOfSunActOne;
      
      public function MapProcessor_80046(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this._rainOfSunActOne = new RainOfSunActOne(_map);
      }
      
      override public function dispose() : void
      {
         if(this._rainOfSunActOne)
         {
            this._rainOfSunActOne.dispose();
         }
         this._rainOfSunActOne = null;
         super.dispose();
      }
   }
}
