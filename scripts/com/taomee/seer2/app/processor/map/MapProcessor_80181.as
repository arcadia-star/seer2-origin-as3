package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.processor.activity.zhouSiAct.ZhouSiAct;
   import com.taomee.seer2.core.map.MapModel;
   
   public class MapProcessor_80181 extends TitleMapProcessor
   {
       
      
      public function MapProcessor_80181(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         ZhouSiAct.getInstance().setup(_map);
      }
      
      override public function dispose() : void
      {
         ZhouSiAct.getInstance().dispose();
         super.dispose();
      }
   }
}
