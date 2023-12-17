package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.processor.activity.GrabXiaoYueSeAct.GrabXiaoYueSeAct;
   import com.taomee.seer2.core.map.MapModel;
   
   public class MapProcessor_80122 extends MapProcessor_80101
   {
       
      
      public function MapProcessor_80122(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         GrabXiaoYueSeAct.getInstance().setup(_map);
      }
      
      override public function dispose() : void
      {
         GrabXiaoYueSeAct.getInstance().dispose();
         super.dispose();
      }
   }
}
