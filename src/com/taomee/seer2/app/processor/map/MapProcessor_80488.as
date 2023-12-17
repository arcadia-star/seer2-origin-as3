package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.processor.activity.moonWakeUpAct.MoonWakeUpAct;
   import com.taomee.seer2.core.map.MapModel;
   
   public class MapProcessor_80488 extends TitleMapProcessor
   {
       
      
      public function MapProcessor_80488(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         MoonWakeUpAct.getInstance().setup(_map);
      }
      
      override public function dispose() : void
      {
         MoonWakeUpAct.getInstance().dispose();
         super.dispose();
      }
   }
}
