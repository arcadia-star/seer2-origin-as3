package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.processor.activity.taTianAct.TaTianAct;
   import com.taomee.seer2.core.map.MapModel;
   
   public class MapProcessor_80213 extends TitleMapProcessor
   {
       
      
      public function MapProcessor_80213(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         TaTianAct.getInstance().setup(_map);
      }
      
      override public function dispose() : void
      {
         TaTianAct.getInstance().dispose();
         super.dispose();
      }
   }
}
