package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.core.map.MapModel;
   import flash.geom.Point;
   
   public class MapProcessor_1050 extends TitleMapProcessor
   {
      
      private static const TIP_POS:Point = new Point(762,200);
       
      
      public function MapProcessor_1050(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initMascot();
      }
      
      private function initMascot() : void
      {
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
