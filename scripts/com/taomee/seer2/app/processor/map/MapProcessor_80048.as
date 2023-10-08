package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.processor.activity.rainOfSunAct.RainOfSunActThree;
   import com.taomee.seer2.core.map.MapModel;
   
   public class MapProcessor_80048 extends TitleMapProcessor
   {
       
      
      private var _rainOfSunActThree:RainOfSunActThree;
      
      public function MapProcessor_80048(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this._rainOfSunActThree = new RainOfSunActThree(_map);
      }
      
      override public function dispose() : void
      {
         if(this._rainOfSunActThree)
         {
            this._rainOfSunActThree.dispose();
         }
         this._rainOfSunActThree = null;
         super.dispose();
      }
   }
}
