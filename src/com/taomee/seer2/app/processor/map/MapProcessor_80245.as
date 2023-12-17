package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.manager.SeatTipsManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import flash.geom.Point;
   
   public class MapProcessor_80245 extends MapProcessor
   {
       
      
      private const POINT_LIST:Vector.<Point> = Vector.<Point>([new Point(310,250),new Point(420,170),new Point(650,260)]);
      
      public function MapProcessor_80245(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
      }
      
      override public function dispose() : void
      {
         SeatTipsManager.removeSeat(this.POINT_LIST[0],80245);
         SeatTipsManager.removeSeat(this.POINT_LIST[1],80245);
         SeatTipsManager.removeSeat(this.POINT_LIST[2],80245);
         super.dispose();
      }
   }
}
