package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.processor.activity.GrabXiaoYueSeAct.GrabXiaoYueSeAct;
   import com.taomee.seer2.app.processor.activity.holyAreaProtectAct.HolyAreaProtectAct;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_3815 extends MapProcessor
   {
       
      
      private var _holyAreaAct:HolyAreaProtectAct;
      
      public function MapProcessor_3815(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         this._holyAreaAct = new HolyAreaProtectAct(_map);
         GrabXiaoYueSeAct.getInstance().setup(_map);
      }
      
      override public function dispose() : void
      {
         this._holyAreaAct.dispose();
         GrabXiaoYueSeAct.getInstance().dispose();
         super.dispose();
      }
   }
}
